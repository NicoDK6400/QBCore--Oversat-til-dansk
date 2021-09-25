--[[
 ______ _           __  __      _ _    
|  ____(_)         |  \/  |    | | |   
| |__   ___   _____| \  / |  __| | | __
|  __| | \ \ / / _ \ |\/| | / _` | |/ /
| |    | |\ V /  __/ |  | || (_| |   < 
|_|    |_| \_/ \___|_|  |_(_)__,_|_|\_\

Vores sider:
  • Hjemmesiden: https://fivem.dk
  • Patreon: https://patreon.com/dkfivem
  • Facebook: https://facebook.com/dkfivem
  • Discord: https://discord.gg/dkfivem
  • DybHosting: https://dybhosting.eu/ - Rabatkode: dkfivem10
]]

local VehicleStatus = {}
local VehicleDrivingDistance = {}

QBCore.Functions.CreateCallback('qb-vehicletuning:server:GetDrivingDistances', function(source, cb)
    cb(VehicleDrivingDistance)
end)

RegisterServerEvent('qb-vehicletuning:server:SaveVehicleProps')
AddEventHandler('qb-vehicletuning:server:SaveVehicleProps', function(vehicleProps)
    local src = source
    if IsVehicleOwned(vehicleProps.plate) then
        exports.oxmysql:execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?',
            {json.encode(vehicleProps), vehicleProps.plate})
    end
end)

RegisterServerEvent("vehiclemod:server:setupVehicleStatus")
AddEventHandler("vehiclemod:server:setupVehicleStatus", function(plate, engineHealth, bodyHealth)
    local src = source
    local engineHealth = engineHealth ~= nil and engineHealth or 1000.0
    local bodyHealth = bodyHealth ~= nil and bodyHealth or 1000.0
    if VehicleStatus[plate] == nil then
        if IsVehicleOwned(plate) then
            local statusInfo = GetVehicleStatus(plate)
            if statusInfo == nil then
                statusInfo = {
                    ["engine"] = engineHealth,
                    ["body"] = bodyHealth,
                    ["radiator"] = Config.MaxStatusValues["radiator"],
                    ["axle"] = Config.MaxStatusValues["axle"],
                    ["brakes"] = Config.MaxStatusValues["brakes"],
                    ["clutch"] = Config.MaxStatusValues["clutch"],
                    ["fuel"] = Config.MaxStatusValues["fuel"]
                }
            end
            VehicleStatus[plate] = statusInfo
            TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, statusInfo)
        else
            local statusInfo = {
                ["engine"] = engineHealth,
                ["body"] = bodyHealth,
                ["radiator"] = Config.MaxStatusValues["radiator"],
                ["axle"] = Config.MaxStatusValues["axle"],
                ["brakes"] = Config.MaxStatusValues["brakes"],
                ["clutch"] = Config.MaxStatusValues["clutch"],
                ["fuel"] = Config.MaxStatusValues["fuel"]
            }
            VehicleStatus[plate] = statusInfo
            TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, statusInfo)
        end
    else
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterServerEvent('qb-vehicletuning:server:UpdateDrivingDistance')
AddEventHandler('qb-vehicletuning:server:UpdateDrivingDistance', function(amount, plate)
    VehicleDrivingDistance[plate] = amount
    TriggerClientEvent('qb-vehicletuning:client:UpdateDrivingDistance', -1, VehicleDrivingDistance[plate], plate)
    local result = exports.oxmysql:fetchSync('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result[1] ~= nil then
        exports.oxmysql:execute('UPDATE player_vehicles SET drivingdistance = ? WHERE plate = ?', {amount, plate})
    end
end)

QBCore.Functions.CreateCallback('qb-vehicletuning:server:IsVehicleOwned', function(source, cb, plate)
    local retval = false
    local result = exports.oxmysql:scalarSync('SELECT 1 from player_vehicles WHERE plate = ?', {plate})
    if result then
        retval = true
    end
    cb(retval)
end)

RegisterServerEvent('qb-vehicletuning:server:LoadStatus')
AddEventHandler('qb-vehicletuning:server:LoadStatus', function(veh, plate)
    VehicleStatus[plate] = veh
    TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, veh)
end)

RegisterServerEvent("vehiclemod:server:updatePart")
AddEventHandler("vehiclemod:server:updatePart", function(plate, part, level)
    if VehicleStatus[plate] ~= nil then
        if part == "engine" or part == "body" then
            VehicleStatus[plate][part] = level
            if VehicleStatus[plate][part] < 0 then
                VehicleStatus[plate][part] = 0
            elseif VehicleStatus[plate][part] > 1000 then
                VehicleStatus[plate][part] = 1000.0
            end
        else
            VehicleStatus[plate][part] = level
            if VehicleStatus[plate][part] < 0 then
                VehicleStatus[plate][part] = 0
            elseif VehicleStatus[plate][part] > 100 then
                VehicleStatus[plate][part] = 100
            end
        end
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterServerEvent('qb-vehicletuning:server:SetPartLevel')
AddEventHandler('qb-vehicletuning:server:SetPartLevel', function(plate, part, level)
    if VehicleStatus[plate] ~= nil then
        VehicleStatus[plate][part] = level
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterServerEvent("vehiclemod:server:fixEverything")
AddEventHandler("vehiclemod:server:fixEverything", function(plate)
    if VehicleStatus[plate] ~= nil then
        for k, v in pairs(Config.MaxStatusValues) do
            VehicleStatus[plate][k] = v
        end
        TriggerClientEvent("vehiclemod:client:setVehicleStatus", -1, plate, VehicleStatus[plate])
    end
end)

RegisterServerEvent("vehiclemod:server:saveStatus")
AddEventHandler("vehiclemod:server:saveStatus", function(plate)
    if VehicleStatus[plate] ~= nil then
        exports.oxmysql:execute('UPDATE player_vehicles SET status = ? WHERE plate = ?',
            {json.encode(VehicleStatus[plate]), plate})
    end
end)

function IsVehicleOwned(plate)
    local result = exports.oxmysql:scalarSync('SELECT 1 from player_vehicles WHERE plate = ?', {plate})
    if result then
        return true
    else
        return false
    end
end

function GetVehicleStatus(plate)
    local retval = nil
    local result = exports.oxmysql:fetchSync('SELECT status FROM player_vehicles WHERE plate = ?', {plate})
    if result[1] ~= nil then
        retval = result[1].status ~= nil and json.decode(result[1].status) or nil
    end
    return retval
end

QBCore.Commands.Add("setvehiclestatus", "Sæt køretøjs status", {{
    name = "part",
    help = "Skriv hvilken type du vil ændre"
}, {
    name = "amount",
    help = "Procentdel er blevet repareret"
}}, true, function(source, args)
    local part = args[1]:lower()
    local level = tonumber(args[2])
    TriggerClientEvent("vehiclemod:client:setPartLevel", source, part, level)
end, "god")

QBCore.Functions.CreateCallback('qb-vehicletuning:server:GetAttachedVehicle', function(source, cb)
    cb(Config.Plates)
end)

QBCore.Functions.CreateCallback('qb-vehicletuning:server:IsMechanicAvailable', function(source, cb)
    local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "mechanic" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
    end
    cb(amount)
end)

RegisterServerEvent('qb-vehicletuning:server:SetAttachedVehicle')
AddEventHandler('qb-vehicletuning:server:SetAttachedVehicle', function(veh, k)
    if veh ~= false then
        Config.Plates[k].AttachedVehicle = veh
        TriggerClientEvent('qb-vehicletuning:client:SetAttachedVehicle', -1, veh, k)
    else
        Config.Plates[k].AttachedVehicle = nil
        TriggerClientEvent('qb-vehicletuning:client:SetAttachedVehicle', -1, false, k)
    end
end)

RegisterServerEvent('qb-vehicletuning:server:CheckForItems')
AddEventHandler('qb-vehicletuning:server:CheckForItems', function(part)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local RepairPart = Player.Functions.GetItemByName(Config.RepairCostAmount[part].item)

    if RepairPart ~= nil then
        if RepairPart.amount >= Config.RepairCostAmount[part].costs then
            TriggerClientEvent('qb-vehicletuning:client:RepaireeePart', src, part)
            Player.Functions.RemoveItem(Config.RepairCostAmount[part].item, Config.RepairCostAmount[part].costs)

            for i = 1, Config.RepairCostAmount[part].costs, 1 do
                TriggerClientEvent('inventory:client:ItemBox', src,
                    QBCore.Shared.Items[Config.RepairCostAmount[part].item], "remove")
                Citizen.Wait(500)
            end
        else
            TriggerClientEvent('QBCore:Notify', src,
                "Du har ikke nok af " .. QBCore.Shared.Items[Config.RepairCostAmount[part].item]["label"] .. " (min. " ..
                    Config.RepairCostAmount[part].costs .. "x)", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du har ikke " ..
            QBCore.Shared.Items[Config.RepairCostAmount[part].item]["label"] .. " på dig!", "error")
    end
end)

function IsAuthorized(CitizenId)
    local retval = false
    for _, cid in pairs(Config.AuthorizedIds) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    return retval
end

QBCore.Commands.Add("setmechanic", "Giv nogen et mekaniker job", {{
    name = "id",
    help = "ID af spilleren"
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = QBCore.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                TargetData.Functions.SetJob("mechanic")
                TriggerClientEvent('QBCore:Notify', TargetData.PlayerData.source,
                    "Du blev ansat hos Autocare!")
                TriggerClientEvent('QBCore:Notify', source, "Du har (" .. TargetData.PlayerData.charinfo.firstname ..
                    ") som en ny kollega hos Autocare!")
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Du skal oplyse et spiller ID!")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Du kan ikke gøre det sådan!", "error")
    end
end)

QBCore.Commands.Add("firemechanic", "Fyr en mekaniker", {{
    name = "id",
    help = "ID af spilleren"
}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if IsAuthorized(Player.PlayerData.citizenid) then
        local TargetId = tonumber(args[1])
        if TargetId ~= nil then
            local TargetData = QBCore.Functions.GetPlayer(TargetId)
            if TargetData ~= nil then
                if TargetData.PlayerData.job.name == "mechanic" then
                    TargetData.Functions.SetJob("unemployed")
                    TriggerClientEvent('QBCore:Notify', TargetData.PlayerData.source,
                        "Du blev fyret fra Autocare!")
                    TriggerClientEvent('QBCore:Notify', source,
                        "Du har fyret (" .. TargetData.PlayerData.charinfo.firstname .. ") fra Autocare!")
                else
                    TriggerClientEvent('QBCore:Notify', source, "Du er ikke ansat hos Autocare!", "error")
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Du skal oplyse spilleren ID", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Du kan ikke gøre det sådan!", "error")
    end
end)

QBCore.Functions.CreateCallback('qb-vehicletuning:server:GetStatus', function(source, cb, plate)
    if VehicleStatus[plate] ~= nil and next(VehicleStatus[plate]) ~= nil then
        cb(VehicleStatus[plate])
    else
        cb(nil)
    end
end)

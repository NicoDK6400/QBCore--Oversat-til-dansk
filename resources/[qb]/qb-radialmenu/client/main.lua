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

local inRadialMenu = false

RegisterCommand('radialmenu', function()
    openRadial(true)
    SetCursorLocation(0.5, 0.5)
end)

RegisterKeyMapping('radialmenu', 'Open Radial Menu', 'keyboard', 'F1')

function setupSubItems()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] then
            if PlayerData.job.name == "police" or PlayerData.job.name == "ambulance" then
                Config.MenuItems[4].items = {
                    [1] = {
                        id = 'emergencybutton2',
                        title = 'Nødknap',
                        icon = 'general',
                        type = 'client',
                        event = 'police:client:SendPoliceEmergencyAlert',
                        shouldClose = true,
                    },
                }
            end
        else
            if Config.JobInteractions[PlayerData.job.name] ~= nil and next(Config.JobInteractions[PlayerData.job.name]) ~= nil then
                Config.MenuItems[4].items = Config.JobInteractions[PlayerData.job.name]
            else 
                Config.MenuItems[4].items = {}
            end
        end
    end)

    local Vehicle = GetVehiclePedIsIn(PlayerPedId())

    if Vehicle ~= nil or Vehicle ~= 0 then
        local AmountOfSeats = GetVehicleModelNumberOfSeats(GetEntityModel(Vehicle))

        if AmountOfSeats == 2 then
            Config.MenuItems[3].items[3].items = {
                [1] = {
                    id    = -1,
                    title = 'Fører',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [2] = {
                    id    = 0,
                    title = 'Passager',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        elseif AmountOfSeats == 3 then
            Config.MenuItems[3].items[3].items = {
                [4] = {
                    id    = -1,
                    title = 'Fører',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [1] = {
                    id    = 0,
                    title = 'Passager',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [3] = {
                    id    = 1,
                    title = 'Andet',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        elseif AmountOfSeats == 4 then
            Config.MenuItems[3].items[3].items = {
                [4] = {
                    id    = -1,
                    title = 'Fører',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [1] = {
                    id    = 0,
                    title = 'Passager',
                    icon = 'caret-up',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [3] = {
                    id    = 1,
                    title = 'Venstre bag',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
                [2] = {
                    id    = 2,
                    title = 'Højre bag',
                    icon = 'caret-down',
                    type = 'client',
                    event = 'qb-radialmenu:client:ChangeSeat',
                    shouldClose = false,
                },
            }
        end
    end
end

function openRadial(bool)    
    setupSubItems()

    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        radial = bool,
        items = Config.MenuItems
    })
    inRadialMenu = bool
end

function closeRadial(bool)    
    SetNuiFocus(false, false)
    inRadialMenu = bool
end

function getNearestVeh()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

RegisterNUICallback('closeRadial', function()
    closeRadial(false)
end)

RegisterNUICallback('selectItem', function(data)
    local itemData = data.itemData

    if itemData.type == 'client' then
        TriggerEvent(itemData.event, itemData)
    elseif itemData.type == 'server' then
        TriggerServerEvent(itemData.event, itemData)
    end
end)

RegisterNetEvent('qb-radialmenu:client:noPlayers')
AddEventHandler('qb-radialmenu:client:noPlayers', function(data)
    QBCore.Functions.Notify('Der er ingen i nærheden', 'error', 2500)
end)

RegisterNetEvent('qb-radialmenu:client:giveidkaart')
AddEventHandler('qb-radialmenu:client:giveidkaart', function(data)
    -- ??
end)

RegisterNetEvent('qb-radialmenu:client:openDoor')
AddEventHandler('qb-radialmenu:client:openDoor', function(data)
    local string = data.id
    local replace = string:gsub("door", "")
    local door = tonumber(replace)
    local ped = PlayerPedId()
    local closestVehicle = nil

    if IsPedInAnyVehicle(ped, false) then
        closestVehicle = GetVehiclePedIsIn(ped)
    else
        closestVehicle = getNearestVeh()
    end

    if closestVehicle ~= 0 then
        if closestVehicle ~= GetVehiclePedIsIn(ped) then
            local plate = GetVehicleNumberPlateText(closestVehicle)
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('qb-radialmenu:trunk:server:Door', false, plate, door)
                else
                    SetVehicleDoorShut(closestVehicle, door, false)
                end
            else
                if not IsVehicleSeatFree(closestVehicle, -1) then
                    TriggerServerEvent('qb-radialmenu:trunk:server:Door', true, plate, door)
                else
                    SetVehicleDoorOpen(closestVehicle, door, false, false)
                end
            end
        else
            if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
                SetVehicleDoorShut(closestVehicle, door, false)
            else
                SetVehicleDoorOpen(closestVehicle, door, false, false)
            end
        end
    else
        QBCore.Functions.Notify('Der er intet køretøj i nærheden...', 'error', 2500)
    end
end)

RegisterNetEvent('qb-radialmenu:client:setExtra')
AddEventHandler('qb-radialmenu:client:setExtra', function(data)
    local string = data.id
    local replace = string:gsub("extra", "")
    local extra = tonumber(replace)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    local enginehealth = 1000.0
    local bodydamage = 1000.0

    if veh ~= nil then
        local plate = GetVehicleNumberPlateText(closestVehicle)
    
        if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            if DoesExtraExist(veh, extra) then 
                if IsVehicleExtraTurnedOn(veh, extra) then
                    enginehealth = GetVehicleEngineHealth(veh)
                    bodydamage = GetVehicleBodyHealth(veh)
                    SetVehicleExtra(veh, extra, 1)
                    SetVehicleEngineHealth(veh, enginehealth)
                    SetVehicleBodyHealth(veh, bodydamage)
                    QBCore.Functions.Notify('Ekstra ' .. extra .. ' Deaktiveret', 'error', 2500)
                else
                    enginehealth = GetVehicleEngineHealth(veh)
                    bodydamage = GetVehicleBodyHealth(veh)
                    SetVehicleExtra(veh, extra, 0)
                    SetVehicleEngineHealth(veh, enginehealth)
                    SetVehicleBodyHealth(veh, bodydamage)
                    QBCore.Functions.Notify('Ekstra ' .. extra .. ' Aktiveret', 'success', 2500)
                end    
            else
                QBCore.Functions.Notify('Ekstra ' .. extra .. ' er ikke muligt på dette køretøj ', 'error', 2500)
            end
        else
            QBCore.Functions.Notify('Du er ikke føreren af køretøjet!', 'error', 2500)
        end
    end
end)

RegisterNetEvent('qb-radialmenu:trunk:client:Door')
AddEventHandler('qb-radialmenu:trunk:client:Door', function(plate, door, open)
    local veh = GetVehiclePedIsIn(PlayerPedId())

    if veh ~= 0 then
        local pl = GetVehicleNumberPlateText(veh)

        if pl == plate then
            if open then
                SetVehicleDoorOpen(veh, door, false, false)
            else
                SetVehicleDoorShut(veh, door, false)
            end
        end
    end
end)

local Seats = {
    ["-1"] = "Førersæde",
    ["0"] = "passagersædet",
    ["1"] = "Venstre bagsæde",
    ["2"] = "Højre bagsæde",
}

RegisterNetEvent('qb-radialmenu:client:ChangeSeat')
AddEventHandler('qb-radialmenu:client:ChangeSeat', function(data)
    local Veh = GetVehiclePedIsIn(PlayerPedId())
    local IsSeatFree = IsVehicleSeatFree(Veh, data.id)
    local speed = GetEntitySpeed(Veh)
    local HasHarnass = exports['qb-smallresources']:HasHarness()
    if not HasHarnass then
        local kmh = (speed * 3.6);  

        if IsSeatFree then
            if kmh <= 100.0 then
                SetPedIntoVehicle(PlayerPedId(), Veh, data.id)
                QBCore.Functions.Notify('Du er nu på  '..data.title..'!')
            else
                QBCore.Functions.Notify('Dette køretøj kører for hurtigt..')
            end
        else
            QBCore.Functions.Notify('Dette sæde er taget..')
        end
    else
        QBCore.Functions.Notify('Du har en racersele på, du kan ikke tage af/på..', 'error')
    end
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

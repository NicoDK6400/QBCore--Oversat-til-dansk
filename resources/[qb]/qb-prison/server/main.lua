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

local AlarmActivated = false

RegisterServerEvent('prison:server:SetJailStatus')
AddEventHandler('prison:server:SetJailStatus', function(jailTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.SetMetaData("injail", jailTime)
    if jailTime > 0 then
        if Player.PlayerData.job.name ~= "unemployed" then
            Player.Functions.SetJob("unemployed")
            TriggerClientEvent('QBCore:Notify', src, "You're unemployed..")
        end
    end
end)

RegisterServerEvent('prison:server:SaveJailItems')
AddEventHandler('prison:server:SaveJailItems', function(jailTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = 10
    if Player.PlayerData.metadata["jailitems"] == nil or next(Player.PlayerData.metadata["jailitems"]) == nil then 
        Player.Functions.SetMetaData("jailitems", Player.PlayerData.items)
        Player.Functions.AddMoney('cash', 80)
        Citizen.Wait(2000)
        Player.Functions.ClearInventory()
    end
end)

RegisterServerEvent('prison:server:GiveJailItems')
AddEventHandler('prison:server:GiveJailItems', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.ClearInventory()
    Citizen.Wait(1000)
    for k, v in pairs(Player.PlayerData.metadata["jailitems"]) do
        Player.Functions.AddItem(v.name, v.amount, false, v.info)
    end
    Citizen.Wait(1000)
    Player.Functions.SetMetaData("jailitems", {})
end)

RegisterServerEvent('prison:server:SecurityLockdown')
AddEventHandler('prison:server:SecurityLockdown', function()
    local src = source
    TriggerClientEvent("prison:client:SetLockDown", -1, true)
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                TriggerClientEvent("prison:client:PrisonBreakAlert", v)
            end
        end
	end
end)

RegisterServerEvent('prison:server:SetGateHit')
AddEventHandler('prison:server:SetGateHit', function(key)
    local src = source
    TriggerClientEvent("prison:client:SetGateHit", -1, key, true)
    if math.random(1, 100) <= 50 then
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player ~= nil then 
                if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                    TriggerClientEvent("prison:client:PrisonBreakAlert", v)
                end
            end
        end
    end
end)

RegisterServerEvent('prison:server:CheckRecordStatus')
AddEventHandler('prison:server:CheckRecordStatus', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CriminalRecord = Player.PlayerData.metadata["criminalrecord"]
    local currentDate = os.date("*t")

    if (CriminalRecord["date"].month + 1) == 13 then
        CriminalRecord["date"].month = 0
    end

    if CriminalRecord["hasRecord"] then
        if currentDate.month == (CriminalRecord["date"].month + 1) or currentDate.day == (CriminalRecord["date"].day - 1) then
            CriminalRecord["hasRecord"] = false
            CriminalRecord["date"] = nil
        end
    end
end)

RegisterServerEvent('prison:server:JailAlarm')
AddEventHandler('prison:server:JailAlarm', function()
    if not AlarmActivated then
        TriggerClientEvent('prison:client:JailAlarm', -1, true)
        SetTimeout(5 * (60 * 1000), function()
            TriggerClientEvent('prison:client:JailAlarm', -1, false)
        end)
    end
end)

QBCore.Functions.CreateCallback('prison:server:IsAlarmActive', function(source, cb)
    cb(AlarmActivated)
end)
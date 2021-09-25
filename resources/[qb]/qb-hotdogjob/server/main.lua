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

local Bail = {}

QBCore.Functions.CreateCallback('qb-hotdogjob:server:HasMoney', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    -- if Player.PlayerData.money.cash >= Config.Bail then
    --     Player.Functions.RemoveMoney('cash', Config.Bail)
    --     Bail[Player.PlayerData.citizenid] = true
    --     cb(true)
    -- else
    if Player.PlayerData.money.bank >= Config.Bail then
        Player.Functions.RemoveMoney('bank', Config.Bail)
        Bail[Player.PlayerData.citizenid] = true
        cb(true)
    else
        Bail[Player.PlayerData.citizenid] = false
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-hotdogjob:server:BringBack', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

    if Bail[Player.PlayerData.citizenid] then
        Player.Functions.AddMoney('bank', Config.Bail)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('qb-hotdogjob:server:Sell')
AddEventHandler('qb-hotdogjob:server:Sell', function(Amount, Price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney('cash', tonumber(Amount * Price))
end)

local Reset = false

RegisterServerEvent('qb-hotdogjob:server:UpdateReputation')
AddEventHandler('qb-hotdogjob:server:UpdateReputation', function(quality)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local JobReputation = Player.PlayerData.metadata["jobrep"]
    
    if Reset then
        JobReputation["hotdog"] = 0
        Player.Functions.SetMetaData("jobrep", JobReputation)
        TriggerClientEvent('qb-hotdogjob:client:UpdateReputation', src, JobReputation)
        return
    end

    if quality == "forrygende" then
        if JobReputation["hotdog"] ~= nil and JobReputation["hotdog"] + 3 > Config.MaxReputation then
            JobReputation["hotdog"] = Config.MaxReputation
            Player.Functions.SetMetaData("jobrep", JobReputation)
            TriggerClientEvent('qb-hotdogjob:client:UpdateReputation', src, JobReputation)
            return
        end
        if JobReputation["hotdog"] == nil then
            JobReputation["hotdog"] = 3
        else
            JobReputation["hotdog"] = JobReputation["hotdog"] + 3
        end
    elseif quality == "dejlig" then
        if JobReputation["hotdog"] ~= nil and JobReputation["hotdog"] + 2 > Config.MaxReputation then
            JobReputation["hotdog"] = Config.MaxReputation
            Player.Functions.SetMetaData("jobrep", JobReputation)
            TriggerClientEvent('qb-hotdogjob:client:UpdateReputation', src, JobReputation)
            return
        end
        if JobReputation["hotdog"] == nil then
            JobReputation["hotdog"] = 2
        else
            JobReputation["hotdog"] = JobReputation["hotdog"] + 2
        end
    elseif quality == "almindelig" then
        if JobReputation["hotdog"] ~= nil and JobReputation["hotdog"] + 1 > Config.MaxReputation then
            JobReputation["hotdog"] = Config.MaxReputation
            Player.Functions.SetMetaData("jobrep", JobReputation)
            TriggerClientEvent('qb-hotdogjob:client:UpdateReputation', src, JobReputation)
            return
        end
        if JobReputation["hotdog"] == nil then
            JobReputation["hotdog"] = 1
        else
            JobReputation["hotdog"] = JobReputation["hotdog"] + 1
        end
    end
    Player.Functions.SetMetaData("jobrep", JobReputation)
    TriggerClientEvent('qb-hotdogjob:client:UpdateReputation', src, JobReputation)
end)


QBCore.Commands.Add("removestand", "Fjern bod (Kun Admin)", {}, false, function(source, args)
    TriggerClientEvent('qb-hotdogjob:staff:DeletStand', source)
end, 'admin')
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

local Races = {}
RegisterServerEvent('qb-streetraces:NewRace')
AddEventHandler('qb-streetraces:NewRace', function(RaceTable)
    local src = source
    local RaceId = math.random(1000, 9999)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.Functions.RemoveMoney('cash', RaceTable.amount, "streetrace-created") then
        Races[RaceId] = RaceTable
        Races[RaceId].creator = QBCore.Functions.GetIdentifier(src, 'license')
        table.insert(Races[RaceId].joined, QBCore.Functions.GetIdentifier(src, 'license'))
        TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
        TriggerClientEvent('qb-streetraces:SetRaceId', src, RaceId)
        TriggerClientEvent('QBCore:Notify', src, "Du tilmeldte dig for "..Races[RaceId].amount..",- DKK", 'success')
    end
end)

RegisterServerEvent('qb-streetraces:RaceWon')
AddEventHandler('qb-streetraces:RaceWon', function(RaceId)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddMoney('cash', Races[RaceId].pot, "race-won")
    TriggerClientEvent('QBCore:Notify', src, "Du vandt racet og modtog "..Races[RaceId].pot..",- DKK", 'success')
    TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
    TriggerClientEvent('qb-streetraces:RaceDone', -1, RaceId, GetPlayerName(src))
end)

RegisterServerEvent('qb-streetraces:JoinRace')
AddEventHandler('qb-streetraces:JoinRace', function(RaceId)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local zPlayer = QBCore.Functions.GetPlayer(Races[RaceId].creator)
    if zPlayer ~= nil then
        if xPlayer.PlayerData.money.cash >= Races[RaceId].amount then
            Races[RaceId].pot = Races[RaceId].pot + Races[RaceId].amount
            table.insert(Races[RaceId].joined, QBCore.Functions.GetIdentifier(src, 'license'))
            if xPlayer.Functions.RemoveMoney('cash', Races[RaceId].amount, "streetrace-joined") then
                TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
                TriggerClientEvent('qb-streetraces:SetRaceId', src, RaceId)
                TriggerClientEvent('QBCore:Notify', zPlayer.PlayerData.source, GetPlayerName(src).." Tilmeldte sig", 'primary')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Du har ikke nok penge", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Personen der har lavet racet er ikke online!", 'error')
        Races[RaceId] = {}
    end
end)

QBCore.Commands.Add("createrace", "Start et Street Race", {{name="amount", help="Indsatsbeløbet til løbet."}}, false, function(source, args)
    local src = source
    local amount = tonumber(args[1])
    local Player = QBCore.Functions.GetPlayer(src)

    if GetJoinedRace(QBCore.Functions.GetIdentifier(src, 'license')) == 0 then
        TriggerClientEvent('qb-streetraces:CreateRace', src, amount)
    else
        TriggerClientEvent('QBCore:Notify', src, "Du er allerede tilmeldt dig et race", 'error')    
    end
end)

QBCore.Commands.Add("stoprace", "Stop det race du startede", {}, false, function(source, args)
    local src = source
    CancelRace(src)
end)

QBCore.Commands.Add("quitrace", "Giv op på race. (Du får ikke dine penge retur!)", {}, false, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local RaceId = GetJoinedRace(QBCore.Functions.GetIdentifier(src, 'license'))
    local zPlayer = QBCore.Functions.GetPlayer(Races[RaceId].creator)

    if RaceId ~= 0 then
        if GetCreatedRace(QBCore.Functions.GetIdentifier(src, 'license')) ~= RaceId then
            RemoveFromRace(QBCore.Functions.GetIdentifier(src, 'license'))
            TriggerClientEvent('QBCore:Notify', src, "Du forlod dit race! Dine penge er tabte", 'error')
        else
            TriggerClientEvent('QBCore:Notify', src, "/stoprace For at stoppe race", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du er ikke i et race ", 'error')
    end
end)

QBCore.Commands.Add("startrace", "Start Race", {}, false, function(source, args)
    local src = source
    local RaceId = GetCreatedRace(QBCore.Functions.GetIdentifier(src, 'license'))
    
    if RaceId ~= 0 then
      
        Races[RaceId].started = true
        TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
        TriggerClientEvent("qb-streetraces:StartRace", -1, RaceId)
    else
        TriggerClientEvent('QBCore:Notify', src, "Du har ikke startet et race", 'error')
        
    end
end)

function CancelRace(source)
    local RaceId = GetCreatedRace(QBCore.Functions.GetIdentifier(source, 'license'))
    local Player = QBCore.Functions.GetPlayer(source)

    if RaceId ~= 0 then
        for key, race in pairs(Races) do
            if Races[key] ~= nil and Races[key].creator == Player.PlayerData.license then
                if not Races[key].started then
                    for _, iden in pairs(Races[key].joined) do
                        local xdPlayer = QBCore.Functions.GetPlayer(iden)
                            xdPlayer.Functions.AddMoney('cash', Races[key].amount, "race-cancelled")
                            TriggerClientEvent('QBCore:Notify', xdPlayer.PlayerData.source, "Race er blevet stoppet, du fik "..Races[key].amount.." DKK tilbage", 'error')
                            TriggerClientEvent('qb-streetraces:StopRace', xdPlayer.PlayerData.source)
                            RemoveFromRace(iden)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, "Race er allerede startet", 'error')
                end
                TriggerClientEvent('QBCore:Notify', source, "Race stoppede!", 'error')
                Races[key] = nil
            end
        end
        TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
    else
        TriggerClientEvent('QBCore:Notify', source, "Du har ikke startet et race!", 'error')
    end
end

function RemoveFromRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and not Races[key].started then
            for i, iden in pairs(Races[key].joined) do
                if iden == identifier then
                    table.remove(Races[key].joined, i)
                end
            end
        end
    end
end

function GetJoinedRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and not Races[key].started then
            for _, iden in pairs(Races[key].joined) do
                if iden == identifier then
                    return key
                end
            end
        end
    end
    return 0
end

function GetCreatedRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and Races[key].creator == identifier and not Races[key].started then
            return key
        end
    end
    return 0
end

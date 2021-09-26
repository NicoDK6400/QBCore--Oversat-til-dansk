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

local PaymentTax = 15
local Bail = {}

RegisterServerEvent('qb-tow:server:DoBail')
AddEventHandler('qb-tow:server:DoBail', function(bool, vehInfo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if bool then
        -- if Player.PlayerData.money.cash >= Config.BailPrice then
        --     Bail[Player.PlayerData.citizenid] = Config.BailPrice
        --     Player.Functions.RemoveMoney('cash', Config.BailPrice, "tow-paid-bail")
        --     TriggerClientEvent('QBCore:Notify', src, 'You Have The Deposit of $1000,- paid', 'success')
        --     TriggerClientEvent('qb-tow:client:SpawnVehicle', src, vehInfo)
        -- else
        if Player.PlayerData.money.bank >= Config.BailPrice then
            Bail[Player.PlayerData.citizenid] = Config.BailPrice
            Player.Functions.RemoveMoney('bank', Config.BailPrice, "tow-paid-bail")
            TriggerClientEvent('QBCore:Notify', src, 'Du har betalt et depositum på '..Config.BailPrice..' DKK', 'success')
            TriggerClientEvent('qb-tow:client:SpawnVehicle', src, vehInfo)
        else
            TriggerClientEvent('QBCore:Notify', src, 'Du har ikke nok penge til et depositum på '..Config.BailPrice..' DKK', 'error')
        end
    else
        if Bail[Player.PlayerData.citizenid] ~= nil then
            Player.Functions.AddMoney('bank', Bail[Player.PlayerData.citizenid], "tow-bail-paid")
            Bail[Player.PlayerData.citizenid] = nil
            TriggerClientEvent('QBCore:Notify', src, 'Du fik '..Config.BailPrice..' DKK tilbage fra dit depositum', 'success')
        end
    end
end)

RegisterNetEvent('qb-tow:server:nano')
AddEventHandler('qb-tow:server:nano', function()
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))

	xPlayer.Functions.AddItem("cryptostick", 1, false)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["cryptostick"], "add")
end)

RegisterNetEvent('qb-tow:server:11101110')
AddEventHandler('qb-tow:server:11101110', function(drops)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local drops = tonumber(drops)
    local bonus = 0
    local DropPrice = math.random(150, 170)
    if drops > 5 then 
        bonus = math.ceil((DropPrice / 10) * 5)
    elseif drops > 10 then
        bonus = math.ceil((DropPrice / 10) * 7)
    elseif drops > 15 then
        bonus = math.ceil((DropPrice / 10) * 10)
    elseif drops > 20 then
        bonus = math.ceil((DropPrice / 10) * 12)
    end
    local price = (DropPrice * drops) + bonus
    local taxAmount = math.ceil((price / 100) * PaymentTax)
    local payment = price - taxAmount

    Player.Functions.AddJobReputation(1)
    Player.Functions.AddMoney("bank", payment, "tow-salary")
    TriggerClientEvent('chatMessage', source, "JOB", "warning", "Du har modtaget løn: "..payment.." DKK, Brutto: "..price.." DKK (Fra "..bonus.." DKK Bonus) I "..taxAmount.." DKK Moms ("..PaymentTax.."%)")
end)

QBCore.Commands.Add("npc", "NPC opgaver", {}, false, function(source, args)
	TriggerClientEvent("jobs:client:ToggleNpc", source)
end)

QBCore.Commands.Add("tow", "Sæt et køretøj på dit lad", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "tow" then
        TriggerClientEvent("qb-tow:client:TowVehicle", source)
    end
end)
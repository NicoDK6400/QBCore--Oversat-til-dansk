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

local chicken = vehicleBaseRepairCost

RegisterServerEvent('qb-customs:attemptPurchase')
AddEventHandler('qb-customs:attemptPurchase', function(type, upgradeLevel)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local balance = nil
    if Player.PlayerData.job.name == "mechanic" then
        balance = exports['qb-bossmenu']:GetAccount(Player.PlayerData.job.name)
    else
        balance = Player.Functions.GetMoney(moneyType)
    end
    if type == "repair" then
        if balance >= chicken then
            if Player.PlayerData.job.name == "mechanic" then
                TriggerEvent('qb-bossmenu:server:removeAccountMoney', Player.PlayerData.job.name, chicken)
            else
                Player.Functions.RemoveMoney(moneyType, chicken, "bennys")
            end
            TriggerClientEvent('qb-customs:purchaseSuccessful', source)
        else
            TriggerClientEvent('qb-customs:purchaseFailed', source)
        end
    elseif type == "performance" then
        if balance >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('qb-customs:purchaseSuccessful', source)
            if Player.PlayerData.job.name == "mechanic" then
                TriggerEvent('qb-bossmenu:server:removeAccountMoney', Player.PlayerData.job.name,
                    vehicleCustomisationPrices[type].prices[upgradeLevel])
            else
                Player.Functions.RemoveMoney(moneyType, vehicleCustomisationPrices[type].prices[upgradeLevel], "bennys")
            end
        else
            TriggerClientEvent('qb-customs:purchaseFailed', source)
        end
    else
        if balance >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('qb-customs:purchaseSuccessful', source)
            if Player.PlayerData.job.name == "mechanic" then
                TriggerEvent('qb-bossmenu:server:removeAccountMoney', Player.PlayerData.job.name,
                    vehicleCustomisationPrices[type].price)
            else
                Player.Functions.RemoveMoney(moneyType, vehicleCustomisationPrices[type].price, "bennys")
            end
        else
            TriggerClientEvent('qb-customs:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('qb-customs:updateRepairCost')
AddEventHandler('qb-customs:updateRepairCost', function(cost)
    chicken = cost
end)

RegisterServerEvent("updateVehicle")
AddEventHandler("updateVehicle", function(myCar)
    local src = source
    if IsVehicleOwned(myCar.plate) then
        exports.oxmysql:execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(myCar), myCar.plate})
    end
end)

function IsVehicleOwned(plate)
    local retval = false
    local result = exports.oxmysql:scalarSync('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        retval = true
    end
    return retval
end
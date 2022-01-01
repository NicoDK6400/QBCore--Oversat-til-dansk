
local ItemList = {
    ["redchip"] = 1,
}
RegisterServerEvent("qb-casino:server:RedSell")
AddEventHandler("qb-casino:server:RedSell", function()
    local src = source
    local price = 5
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("redchip")
    if xItem ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price * (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney("cash", price, "sold-casino-chips")
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['redchip'], "remove")

                    TriggerClientEvent('QBCore:Notify', src, "Du solgte alle dine røde chips for "..price.." DKK")
                    TriggerEvent("qb-log:server:CreateLog", "casino", "Chips", "blue", "**"..GetPlayerName(src) .. "** got $"..price.." for selling the Chips")
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du har ingen røde chips...", "error")
    end
end)

local ItemList = {
    ["whitechip"] = 1,
}
RegisterServerEvent("qb-casino:server:WhiteSell")
AddEventHandler("qb-casino:server:WhiteSell", function()
    local src = source
    local price = 1
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("whitechip")
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price * (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney("cash", price, "sold-casino-chips")
                    TriggerClientEvent('QBCore:Notify', src, "Du solgte alle dine hvide chips for "..price.." DKK")
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['whitechip'], "remove")

                    TriggerEvent("qb-log:server:CreateLog", "casino", "Chips", "blue", "**"..GetPlayerName(src) .. "** got $"..price.." for selling the Chips")
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du har ingen hvide chips...", "error")
    end
end)

local ItemList = {
    ["bluechip"] = 1,
}
RegisterServerEvent("qb-casino:server:BlueSell")
AddEventHandler("qb-casino:server:BlueSell", function()
    local src = source
    local price = 10
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("bluechip")
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price * (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney("cash", price, "sold-casino-chips")
                    TriggerClientEvent('QBCore:Notify', src, "Du solgte alle dine blå chips for "..price.." DKK")
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['bluechip'], "remove")

                    TriggerEvent("qb-log:server:CreateLog", "casino", "Chips", "blue", "**"..GetPlayerName(src) .. "** got $"..price.." for selling the Chips")
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du har ingen blå chips...", "error")
    end
end)

local ItemList = {
    ["blackchip"] = 1,
}
RegisterServerEvent("qb-casino:server:BlackSell")
AddEventHandler("qb-casino:server:BlackSell", function()
    local src = source
    local price = 50
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("blackchip")
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price * (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney("cash", price, "sold-casino-chips")
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['blackchip'], "remove")

                    TriggerClientEvent('QBCore:Notify', src, "Du solgte alle dine sorte chips for "..price.." DKK")
                    TriggerEvent("qb-log:server:CreateLog", "casino", "Chips", "blue", "**"..GetPlayerName(src) .. "** got $"..price.." for selling the Chips")
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du har ingen sorte chips...", "error")
    end
end)

local ItemList = {
    ["goldchip"] = 1,
}
RegisterServerEvent("qb-casino:server:GoldSell")
AddEventHandler("qb-casino:server:GoldSell", function()
    local src = source
    local price = 100
    local Player = QBCore.Functions.GetPlayer(src)
    local xItem = Player.Functions.GetItemByName("goldchip")
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price * (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    Player.Functions.AddMoney("cash", price, "sold-casino-chips")

                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['goldchip'], "remove")

                    TriggerClientEvent('QBCore:Notify', src, "Du solgte alle dine guld chips for "..price.." DKK")
                    TriggerEvent("qb-log:server:CreateLog", "casino", "Chips", "blue", "**"..GetPlayerName(src) .. "** got $"..price.." for selling the Chips")
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Du har ingen guld chips...", "error")
    end
end)
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

RegisterNetEvent('qb-vineyard:server:getGrapes')
AddEventHandler('qb-vineyard:server:getGrapes', function()
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.AddItem("grape", Config.GrapeAmount)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['grape'], "add")
end)

RegisterServerEvent('qb-vineyard:server:loadIngredients') 
AddEventHandler('qb-vineyard:server:loadIngredients', function()
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
    local grape = xPlayer.Functions.GetItemByName('grape')

	if xPlayer.PlayerData.items ~= nil then 
        if grape ~= nil then 
            if grape.amount >= 23 then 

                xPlayer.Functions.RemoveItem("grape", 23, false)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['grape'], "remove")
                
                TriggerClientEvent("qb-vineyard:client:loadIngredients", source)

            else
                TriggerClientEvent('QBCore:Notify', source, "Du har ikke de rette ting", 'error')   
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Du har ikke de rette ting", 'error')   
        end
	else
		TriggerClientEvent('QBCore:Notify', source, "Du har ingenting...", "error")
	end 
	
end) 

RegisterServerEvent('qb-vineyard:server:grapeJuice') 
AddEventHandler('qb-vineyard:server:grapeJuice', function()
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
    local grape = xPlayer.Functions.GetItemByName('grape')

	if xPlayer.PlayerData.items ~= nil then 
        if grape ~= nil then 
            if grape.amount >= 16 then 

                xPlayer.Functions.RemoveItem("grape", 16, false)
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['grape'], "remove")
                
                TriggerClientEvent("qb-vineyard:client:grapeJuice", source)

            else
                TriggerClientEvent('QBCore:Notify', source, "Du har ikke de rette ting", 'error')   
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Du har ikke de rette ting", 'error')   
        end
	else
		TriggerClientEvent('QBCore:Notify', source, "Du har ingenting...", "error")
	end 
	
end) 

RegisterServerEvent('qb-vineyard:server:receiveWine')
AddEventHandler('qb-vineyard:server:receiveWine', function()
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))

	xPlayer.Functions.AddItem("wine", Config.WineAmount, false)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['wine'], "add")
end)

RegisterServerEvent('qb-vineyard:server:receiveGrapeJuice')
AddEventHandler('qb-vineyard:server:receiveGrapeJuice', function()
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))

	xPlayer.Functions.AddItem("grapejuice", Config.GrapeJuiceAmount, false)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['grapejuice'], "add")
end)


-- Hire/Fire

--[[ QBCore.Commands.Add("hirevineyard", "Hire a player to the Vineyard!", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.gang.name == "la_familia") then
            Player.Functions.SetJob("vineyard")
        end
    end
end)

QBCore.Commands.Add("firevineyard", "Fire a player to the Vineyard!", {{name="id", help="Player ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local Myself = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then 
        if (Myself.PlayerData.gang.name == "la_familia") then
            Player.Functions.SetJob("unemployed")
        end
    end
end) ]]
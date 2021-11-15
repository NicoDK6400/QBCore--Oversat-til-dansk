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


local QBCore = exports['qb-core']:GetCoreObject()

-- Code

QBCore.Functions.CreateCallback('qb-tattooshop:GetPlayerTattoos', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)

	if Player then
		local result = exports.oxmysql:fetchSync('SELECT tattoos FROM playerskins WHERE citizenid = ?', { Player.PlayerData.citizenid })
		cb(json.decode(result[1].tattoos))
	else
		cb()
	end
end)

QBCore.Functions.CreateCallback('qb-tattooshop:PurchaseTattoo', function(source, cb, tattooList, price, tattoo, tattooName)
	local Player = QBCore.Functions.GetPlayer(source)


	if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney('cash', price)

		table.insert(tattooList, tattoo)
		exports.oxmysql:execute("UPDATE playerskins SET tattoos = @tattoos WHERE citizenid = @citizenid", { json.encode(tattooList), Player.PlayerData.citizenid }, function() end)

		TriggerClientEvent('QBCore:Notify', source, "Du har købt: " .. tattooName .. " tatovering for DKK" .. price, 'success')
		cb(true)
	else
		TriggerClientEvent('QBCore:Notify', source, "Du har ikke penge nok", 'error')

		cb(false)
	end
end)

RegisterServerEvent('qb-tattooshop:server:RemoveTattoo')
AddEventHandler('qb-tattooshop:server:RemoveTattoo', function (tattooList)
	local Player = QBCore.Functions.GetPlayer(source)

	exports.oxmysql:execute("UPDATE playerskins SET tattoos = @tattoos WHERE citizenid = @citizenid", { json.encode(tattooList), Player.PlayerData.citizenid }, function() end)
end)

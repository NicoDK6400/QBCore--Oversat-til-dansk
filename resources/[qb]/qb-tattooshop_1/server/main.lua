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
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player then
		exports.oxmysql:execute('SELECT tattoos FROM playerskin WHERE citizenid = ?', { Player.PlayerData.citizenid }, function(result)
			if result[1].tattoos then
				cb(json.decode(result[1].tattoos))
			else
				cb()
			end
		end)
	else
		 cb()
	end
end)

QBCore.Functions.CreateCallback('qb-tattooshop:PurchaseTattoo', function(source, cb, tattooList, price, tattoo, tattooName)
	local src = source
	local Player = QBCore.Functions.GetPlayer(source)


	if Player.PlayerData.money.cash >= price then
        Player.Functions.RemoveMoney('cash', price)
		table.insert(tattooList, tattoo)
		TriggerClientEvent('QBCore:Notify', src, "Du har købt ~y~" .. tattooName .. "~s~ tatovering for ~g~" .. price.. " DKK", "success", 4000)
		cb(true)
	else
		TriggerClientEvent('QBCore:Notify', src, "Du har ikke penge nok til en tatovering", "success", 4000)
		cb(false)
	end
end)

RegisterServerEvent('qb-tattooshop:server:RemoveTattoo', function (tattooList)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	exports.oxmysql:update('UPDATE playerskin SET tattoos = ? WHERE citizenid = ?', { json.encode(tattooList), Player.PlayerData.citizenid })
end)
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

RegisterServerEvent('oxydelivery:server')
AddEventHandler('oxydelivery:server', function()
	local player = QBCore.Functions.GetPlayer(source)

	if player.PlayerData.money['cash'] >= Config.StartOxyPayment then
		player.Functions.RemoveMoney('cash', Config.StartOxyPayment)
		
		TriggerClientEvent("oxydelivery:startDealing", source)
	else
		TriggerClientEvent('QBCore:Notify', source, 'Du har ikke nok penge', 'error')
	end
end)

RegisterServerEvent('oxydelivery:receiveBigRewarditem')
AddEventHandler('oxydelivery:receiveBigRewarditem', function()
	local player = QBCore.Functions.GetPlayer(source)

	player.PlayerData.AddItem(Config.BigRewarditem, 1)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.BigRewarditem], "add")
end)

RegisterServerEvent('oxydelivery:receiveoxy')
AddEventHandler('oxydelivery:receiveoxy', function()
	local player = QBCore.Functions.GetPlayer(source)

	player.Functions.AddMoney('cash', Config.Payment / 2)
	player.Functions.AddItem(Config.Item, Config.OxyAmount)
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.Item], "add")
end)

RegisterServerEvent('oxydelivery:receivemoneyyy')
AddEventHandler('oxydelivery:receivemoneyyy', function()
	local player = QBCore.Functions.GetPlayer(source)

	player.Functions.AddMoney('cash', Config.Payment)
end)
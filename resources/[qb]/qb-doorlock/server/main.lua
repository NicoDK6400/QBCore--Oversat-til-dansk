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

local doorInfo = {}

RegisterServerEvent('qb-doorlock:server:setupDoors')
AddEventHandler('qb-doorlock:server:setupDoors', function()
	local src = source
	TriggerClientEvent("qb-doorlock:client:setDoors", QB.Doors)
end)

RegisterServerEvent('qb-doorlock:server:updateState')
AddEventHandler('qb-doorlock:server:updateState', function(doorID, state)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
	QB.Doors[doorID].locked = state

	TriggerClientEvent('qb-doorlock:client:setState', -1, doorID, state)
end)

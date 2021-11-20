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

RegisterNetEvent('qb-doorlock:server:setupDoors', function()
	TriggerClientEvent("qb-doorlock:client:setDoors", QB.Doors)
end)

RegisterNetEvent('qb-doorlock:server:updateState', function(doorID, state)
	QB.Doors[doorID].locked = state
	TriggerClientEvent('qb-doorlock:client:setState', -1, doorID, state)
end)
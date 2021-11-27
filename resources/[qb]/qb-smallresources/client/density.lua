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
local density = 0.8

Citizen.CreateThread(function()
	while true do
		SetParkedVehicleDensityMultiplierThisFrame(density)
		SetVehicleDensityMultiplierThisFrame(density)
		SetRandomVehicleDensityMultiplierThisFrame(density)
		SetPedDensityMultiplierThisFrame(density)
		SetScenarioPedDensityMultiplierThisFrame(density, density) -- Walking NPC Density
		Wait(0)
	end
end)
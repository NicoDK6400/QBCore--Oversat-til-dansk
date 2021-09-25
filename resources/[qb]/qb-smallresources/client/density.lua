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

Citizen.CreateThread(function()
	while true do
		SetVehicleDensityMultiplierThisFrame(0.05)
	    SetPedDensityMultiplierThisFrame(1.0)
	    SetParkedVehicleDensityMultiplierThisFrame(1.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)

		Citizen.Wait(3)
	end
end)
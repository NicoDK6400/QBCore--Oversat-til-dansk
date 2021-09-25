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


exports('GetNorthYanktonObject', function()
	return NorthYankton
end)

NorthYankton = {
	ipl = {
		"prologue01",
		"prologue01c",
		"prologue01d",
		"prologue01e",
		"prologue01f",
		"prologue01g",
		"prologue01h",
		"prologue01i",
		"prologue01j",
		"prologue01k",
		"prologue01z",
		"prologue02",
		"prologue03",
		"prologue03b",
		"prologue04",
		"prologue04b",
		"prologue05",
		"prologue05b",
		"prologue06",
		"prologue06b",
		"prologue06_int",
		"prologuerd",
		"prologuerdb",
		"prologue_DistantLights",
		"prologue_LODLights",
		"prologue_m2_door"
	},
	Enable = function(state) EnableIpl(NorthYankton.ipl, state) end
}

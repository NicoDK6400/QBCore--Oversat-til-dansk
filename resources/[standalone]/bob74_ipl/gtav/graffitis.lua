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


exports('GetGraffitisObject', function()
    return Graffitis
end)

Graffitis = {
    ipl = {
        "ch3_rd2_bishopschickengraffiti",	-- 1861.28, 2402.11, 58.53
        "cs5_04_mazebillboardgraffiti",		-- 2697.32, 3162.18, 58.1
        "cs5_roads_ronoilgraffiti"			-- 2119.12, 3058.21, 53.25
    },
    Enable = function(state) EnableIpl(Graffitis.ipl, state) end
}

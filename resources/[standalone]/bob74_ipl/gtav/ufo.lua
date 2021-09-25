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


exports('GetUFOObject', function()
    return UFO
end)

UFO = {
    Hippie = {
        ipl = "ufo",		-- Hippie base: 2490.47729, 3774.84351, 2414.035
        Enable = function(state)
            EnableIpl(UFO.Hippie.ipl, state)
        end
    },
    Chiliad = {
        ipl = "ufo_eye",	-- Chiliad: 501.5288, 5593.865, 796.2325
        Enable = function(state)
            EnableIpl(UFO.Chiliad.ipl, state)
        end
    },
    Zancudo = {
        ipl = "ufo_lod",	-- Zancudo: -2051.99463, 3237.05835, 1456.97021
        Enable = function(state)
            EnableIpl(UFO.Zancudo.ipl, state)
        end
    }
}


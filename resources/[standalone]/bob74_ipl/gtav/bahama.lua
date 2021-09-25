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

-- Bahama Mamas: -1388.0013, -618.41967, 30.819599

exports('GetBahamaMamasObject', function()
    return BahamaMamas
end)

BahamaMamas = {
    ipl = "hei_sm_16_interior_v_bahama_milo_",

    Enable = function(state)
        EnableIpl(BahamaMamas.ipl, state)
    end
}

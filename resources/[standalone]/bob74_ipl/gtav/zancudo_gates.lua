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

-- Zancudo Gates (GTAO like): -1600.30100000 2806.73100000 18.79683000

exports('GetZancudoGatesObject', function()
    return ZancudoGates
end)

ZancudoGates = {
    Gates = {
        Open = function()
            EnableIpl("CS3_07_MPGates", false)
        end,
        Close = function()
            EnableIpl("CS3_07_MPGates", true)
        end,
    },

    LoadDefault = function()
        ZancudoGates.Gates.Open()
    end
}

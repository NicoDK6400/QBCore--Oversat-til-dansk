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


exports('GetSimeonObject', function()
    return Simeon
end)

Simeon = {
    interiorId = 7170,
    Ipl = {
        Interior = {
            ipl = {"shr_int"},
            Load = function() EnableIpl(Simeon.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(Simeon.Ipl.Interior.ipl, false) end
        },
    },
    Style = {
        normal = "csr_beforeMission", noGlass = "csr_inMission", destroyed = "csr_afterMissionA", fixed = "csr_afterMissionB",
        Set = function(style, refresh)
            Simeon.Style.Clear(false)
            SetIplPropState(Simeon.interiorId, style, true, refresh)
        end,
        Clear = function(refresh) SetIplPropState(Simeon.interiorId, {Simeon.Style.normal, Simeon.Style.noGlass, Simeon.Style.destroyed, Simeon.Style.fixed}, false, refresh) end
    },
    Shutter = {
        none = "", opened = "shutter_open", closed = "shutter_closed",
        Set = function(shutter, refresh)
            Simeon.Shutter.Clear(false)
            if (shutter ~= "") then
                SetIplPropState(Simeon.interiorId, shutter, true, refresh)
            else
                if (refresh) then RefreshInterior(Simeon.interiorId) end
            end
        end,
        Clear = function(refresh) SetIplPropState(Simeon.interiorId, {Simeon.Shutter.opened, Simeon.Shutter.closed}, false, refresh) end
    },

    LoadDefault = function()
        Simeon.Ipl.Interior.Load()
        Simeon.Style.Set(Simeon.Style.normal)
        Simeon.Shutter.Set(Simeon.Shutter.opened)
        RefreshInterior(Simeon.interiorId)
    end
}

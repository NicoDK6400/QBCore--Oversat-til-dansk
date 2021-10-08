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


exports('GetTrevorsTrailerObject', function()
    return TrevorsTrailer
end)

TrevorsTrailer = {
    interiorId = 2562,
    Interior = {
        tidy = "trevorstrailertidy", trash = "TrevorsTrailerTrash",
        Set = function(interior)
            TrevorsTrailer.Interior.Clear()
            EnableIpl(interior, true)
        end,
        Clear = function() EnableIpl({TrevorsTrailer.Interior.tidy, TrevorsTrailer.Interior.trash}, false) end
    },
    Details = {
        copHelmet = "V_26_Trevor_Helmet3",			-- Cop helmet in the closet
        briefcase = "V_24_Trevor_Briefcase3",		-- Briefcase in the main room
        michaelStuff = "V_26_Michael_Stay3",		-- Michael's suit hanging on the window
        Enable = function (details, state, refresh) SetIplPropState(TrevorsTrailer.interiorId, details, state, refresh) end
    },

    LoadDefault = function()
        TrevorsTrailer.Interior.Set(TrevorsTrailer.Interior.tidy)
        TrevorsTrailer.Details.Enable(TrevorsTrailer.Details.copHelmet, false, false)
        TrevorsTrailer.Details.Enable(TrevorsTrailer.Details.briefcase, false, false)
        TrevorsTrailer.Details.Enable(TrevorsTrailer.Details.michaelStuff, false, false)
        RefreshInterior(TrevorsTrailer.interiorId)
    end
}

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


exports('GetFranklinAuntObject', function()
    return FranklinAunt
end)

FranklinAunt = {
    interiorId = 197889,
    Style = {
        empty = "", franklinStuff = "V_57_FranklinStuff", franklinLeft = "V_57_Franklin_LEFT",
        Set = function(style, refresh)
            FranklinAunt.Style.Clear(false)
            if style ~= "" then
                SetIplPropState(FranklinAunt.interiorId, style, true, refresh)
            else
                if (refresh) then RefreshInterior(FranklinAunt.interiorId) end
            end
        end,
        Clear = function(refresh) SetIplPropState(FranklinAunt.interiorId, {FranklinAunt.Style.franklinStuff, FranklinAunt.Style.franklinLeft}, false, refresh) end
    },
    Details = {
        bandana = "V_57_GangBandana",				-- Bandana on the bed
        bag = "V_57_Safari",						-- Bag in the closet
        Enable = function (details, state, refresh) SetIplPropState(FranklinAunt.interiorId, details, state, refresh) end
    },

    LoadDefault = function()
        FranklinAunt.Style.Set(FranklinAunt.Style.empty)
        FranklinAunt.Details.Enable(FranklinAunt.Details.bandana, false)
        FranklinAunt.Details.Enable(FranklinAunt.Details.bag, false)
        RefreshInterior(FranklinAunt.interiorId)
    end
}

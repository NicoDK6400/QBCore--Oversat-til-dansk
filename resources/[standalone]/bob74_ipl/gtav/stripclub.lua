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


exports('GetStripClubObject', function()
    return StripClub
end)

StripClub = {
    interiorId = 197121,
    Mess = {
        mess = "V_19_Trevor_Mess",					-- A bit of mess in the office
        Enable = function (state) SetIplPropState(StripClub.interiorId, StripClub.Mess.mess, state, true) end
    },

    LoadDefault = function()
        StripClub.Mess.Enable(false)
    end
}

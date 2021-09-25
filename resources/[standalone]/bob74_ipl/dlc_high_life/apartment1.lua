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


-- Apartment 1: -1462.28100000, -539.62760000, 72.44434000

exports('GetHLApartment1Object', function()
    return HLApartment1
end)

HLApartment1 = {
    interiorId = 145921,
    Ipl = {
        Interior = {
            ipl = "mpbusiness_int_placement_interior_v_mp_apt_h_01_milo_",
            Load = function() EnableIpl(HLApartment1.Ipl.Interior.ipl, true) end,
            Remove = function() EnableIpl(HLApartment1.Ipl.Interior.ipl, false) end
        },
    },
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment1.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment1.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(HLApartment1.interiorId, details, state, refresh)
        end
    }, 
    LoadDefault = function()
        HLApartment1.Ipl.Interior.Load()
        HLApartment1.Strip.Enable({HLApartment1.Strip.A, HLApartment1.Strip.B, HLApartment1.Strip.C}, false)
        HLApartment1.Booze.Enable({HLApartment1.Booze.A, HLApartment1.Booze.B, HLApartment1.Booze.C}, false)
        HLApartment1.Smoke.Enable({HLApartment1.Smoke.A, HLApartment1.Smoke.B, HLApartment1.Smoke.C}, false)
        RefreshInterior(HLApartment1.interiorId)
    end
}

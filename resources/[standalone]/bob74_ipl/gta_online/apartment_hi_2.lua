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


-- Dell Perro Heights, Apt 7
-- High end apartment 2: -1477.14 -538.7499 55.5264

exports('GetGTAOApartmentHi2Object', function()
    return GTAOApartmentHi2
end)

GTAOApartmentHi2 = {
    interiorId = 145665,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOApartmentHi2.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOApartmentHi2.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOApartmentHi2.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOApartmentHi2.Strip.Enable({GTAOApartmentHi2.Strip.A, GTAOApartmentHi2.Strip.B, GTAOApartmentHi2.Strip.C}, false)
        GTAOApartmentHi2.Booze.Enable({GTAOApartmentHi2.Booze.A, GTAOApartmentHi2.Booze.B, GTAOApartmentHi2.Booze.C}, false)
        GTAOApartmentHi2.Smoke.Enable({GTAOApartmentHi2.Smoke.A, GTAOApartmentHi2.Smoke.B, GTAOApartmentHi2.Smoke.C}, false)
        RefreshInterior(GTAOApartmentHi2.interiorId)
    end
}

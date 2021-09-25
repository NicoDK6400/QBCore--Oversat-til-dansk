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


-- 2862 Hillcrest Avenue 
-- High end house 4: -676.127 588.612 145.1698

exports('GetGTAOHouseHi4Object', function()
    return GTAOHouseHi4
end)

GTAOHouseHi4 = {
    interiorId = 208129,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi4.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi4.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi4.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseHi4.Strip.Enable({GTAOHouseHi4.Strip.A, GTAOHouseHi4.Strip.B, GTAOHouseHi4.Strip.C}, false)
        GTAOHouseHi4.Booze.Enable({GTAOHouseHi4.Booze.A, GTAOHouseHi4.Booze.B, GTAOHouseHi4.Booze.C}, false)
        GTAOHouseHi4.Smoke.Enable({GTAOHouseHi4.Smoke.A, GTAOHouseHi4.Smoke.B, GTAOHouseHi4.Smoke.C}, false)
        RefreshInterior(GTAOHouseHi4.interiorId)
    end
}

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


-- 2868 Hillcrest Avenue 
-- High end house 5: -763.107 615.906 144.1401

exports('GetGTAOHouseHi5Object', function()
    return GTAOHouseHi5
end)

GTAOHouseHi5 = {
    interiorId = 207617,
    Strip = {
        A = "Apart_Hi_Strip_A", B = "Apart_Hi_Strip_B", C = "Apart_Hi_Strip_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi5.interiorId, details, state, refresh)
        end
    },
    Booze = {
        A = "Apart_Hi_Booze_A", B = "Apart_Hi_Booze_B", C = "Apart_Hi_Booze_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi5.interiorId, details, state, refresh)
        end
    },
    Smoke = {
        A = "Apart_Hi_Smokes_A", B = "Apart_Hi_Smokes_B", C = "Apart_Hi_Smokes_C",
        Enable = function (details, state, refresh)
            SetIplPropState(GTAOHouseHi5.interiorId, details, state, refresh)
        end
    },
    LoadDefault = function()
        GTAOHouseHi5.Strip.Enable({GTAOHouseHi5.Strip.A, GTAOHouseHi5.Strip.B, GTAOHouseHi5.Strip.C}, false)
        GTAOHouseHi5.Booze.Enable({GTAOHouseHi5.Booze.A, GTAOHouseHi5.Booze.B, GTAOHouseHi5.Booze.C}, false)
        GTAOHouseHi5.Smoke.Enable({GTAOHouseHi5.Smoke.A, GTAOHouseHi5.Smoke.B, GTAOHouseHi5.Smoke.C}, false)
        RefreshInterior(GTAOHouseHi5.interiorId)
    end
}

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

Config = Config or {}

Config.MinZOffset = 30
Config.CurrentLab = 0
Config.CooldownActive = false

Config.HydrochloricAcid = 3
Config.Ephedrine = 3
Config.Acetone  = 3

Config.FurnaceTimer = 5

Config.BreakMethTimer = math.random(10000, 12000)

Config.Locations = {
    ["laboratories"] = {
        [1] = {
            coords = vector4(321.72, -305.87, 52.50, 94.5),
        },
    },
    ["exit"] = {
        coords = vector4(997.01, -3200.65, -36.4, 90.4), 
    },
    ["break"] = {
        coords = vector4(1016.04, -3194.95, -38.99, 275.5), 
    }
}

Config.Tasks = {
    ["Furnace"] = {
        label = "Ovn",
        completed = false,
        started = false,
        -- ingredients = {
        --     current = 0,
        --     needed = 1,
        -- },
        coords = vector4(1005.72, -3200.38, -38.52, 124.5),
        timeremaining = 3,
        duration = 3,
        done = false,
    },
}
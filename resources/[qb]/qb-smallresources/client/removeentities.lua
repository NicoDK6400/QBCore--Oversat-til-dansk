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

local objects = {
    {x = 266.09, y = -349.35, z = 44.74, model = "prop_sec_barier_02b"}, 
    {x = 285.28, y = -355.78, z = 45.13, model = "prop_sec_barier_02a"}, 
}

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(objects) do
            local ent = GetClosestObjectOfType(objects[k].x, objects[k].y, objects[k].z, 2.0, GetHashKey(objects[k].model), false, false, false)

            SetEntityAsMissionEntity(ent, 1, 1)
            DeleteObject(ent)
            SetEntityAsNoLongerNeeded(ent)
        end

        Citizen.Wait(5000)
    end
end)
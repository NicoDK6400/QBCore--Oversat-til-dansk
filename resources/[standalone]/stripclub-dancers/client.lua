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

-- Configure the coordinates where the strippers should be placed.
local strippers = {
  {type=5, hash=0x2970a494, x=112.159, y=-1287.326, z=28.459, a=265.902},
  {type=5, hash=0x2970a494, x=108.440, y=-1289.298, z=28.859, a=338.700},
  {type=5, hash=0x2970a494, x=108.181, y=-1304.807, z=28.769, a=186.893},
  {type=5, hash=0x2970a494, x=118.125, y=-1283.357, z=28.277, a=124.466},
  }

-- Configure the coordinates for the bartenders.
  local bartenders = {
    {type=5, hash=0x780c01bd, x=128.900, y=-1283.211, z=29.273, a=123.98},
  }

-- Configure the coordinates for the bartenders.
local bouncers = {
  {type=4, hash=0x9fd4292d, x=130.328, y=-1298.409, z=29.233, a=211.486},
  {type=4, hash=0x9fd4292d, x=127.404, y=-1300.126, z=29.23, a=211.587},
  {type=4, hash=0x9fd4292d, x=111.088, y=-1304.371, z=29.020, a=296.699},
}

function LocalPed()
  return GetPlayerPed(-1)
end

Citizen.CreateThread(function()
  -- Load the ped modal (s_f_y_bartender_01)
  RequestModel(GetHashKey("s_f_y_bartender_01"))
  while not HasModelLoaded(GetHashKey("s_f_y_bartender_01")) do
    Wait(1)
  end

  -- Load the ped modal (mp_f_stripperlite)
  RequestModel(GetHashKey("mp_f_stripperlite"))
  while not HasModelLoaded(GetHashKey("mp_f_stripperlite")) do
    Wait(1)
  end

  -- Load the ped modal (s_m_m_bouncer_01)
  RequestModel(GetHashKey("s_m_m_bouncer_01"))
  while not HasModelLoaded(GetHashKey("s_m_m_bouncer_01")) do
    Wait(1)
  end

  -- Load the animation (testing)
  RequestAnimDict("mini@strip_club@private_dance@part2")
  while not HasAnimDictLoaded("mini@strip_club@private_dance@part2") do
    Wait(1)
  end

  -- Load the bouncer animation (testing)
  RequestAnimDict("mini@strip_club@idles@bouncer@base")
  while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
    Wait(1)
  end

    -- Spawn the bartender to the coordinates
    bartender =  CreatePed(5, 0x780c01bd, 128.900, -1283.21, 29.273, 123.98, false, true)
    SetBlockingOfNonTemporaryEvents(bartender, true)
    SetPedCombatAttributes(bartender, 292, true)
    SetPedFleeAttributes(bartender, 0, 0)
    SetPedRelationshipGroupHash(bartender, GetHashKey("CIVFEMALE"))


  -- Spawn the bouncers to the coordinates
  for _, item in pairs(bouncers) do
    ped =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
    SetPedCombatAttributes(ped, 292, true)
    SetPedFleeAttributes(ped, 0, 0)
    SetPedRelationshipGroupHash(ped, GetHashKey("CIVMALE"))
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GUARD_STAND_PATROL", 0, true)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end

  -- Spawn the strippers to the coordinates
  for _, item in pairs(strippers) do
    stripper =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
    SetPedCombatAttributes(stripper, 292, true)
    SetPedFleeAttributes(stripper, 0, 0)
    SetPedDiesWhenInjured(ped, false)
    SetPedRelationshipGroupHash(stripper, GetHashKey("CIVFEMALE"))
    TaskPlayAnim(stripper,"mini@strip_club@private_dance@part2","priv_dance_p2", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
end)


local playerCoords
local playerPed
showStartText = false


function Toxicated()
  RequestAnimSet("move_m@drunk@verydrunk")
  while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
    Citizen.Wait(0)
  end

  TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_DRUG_DEALER", 0, 1)
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(GetPlayerPed(-1))
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(GetPlayerPed(-1), true)
  SetPedMovementClipset(GetPlayerPed(-1), "move_m@drunk@verydrunk", true)
  SetPedIsDrunk(GetPlayerPed(-1), true)
  DoScreenFadeIn(1000)
  end

  function reality()
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(GetPlayerPed(-1), 0)
    SetPedIsDrunk(GetPlayerPed(-1), false)
    SetPedMotionBlur(GetPlayerPed(-1), false)
    -- Stop the toxication
    Citizen.Trace("Going back to reality\n")
end
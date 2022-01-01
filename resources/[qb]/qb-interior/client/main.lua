
local IsNew = false

RegisterNetEvent('qb-interior:client:SetNewState', function(bool)
	IsNew = bool
end)

-- Functions

local function DespawnInterior(objects, cb)
    CreateThread(function()
        for k, v in pairs(objects) do
            if DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end

        cb()
    end)
end

function TeleportToInterior(x, y, z, h)
    CreateThread(function()
        SetEntityCoords(PlayerPedId(), x, y, z, 0, 0, 0, false)
        SetEntityHeading(PlayerPedId(), h)

        Wait(100)

        DoScreenFadeIn(1000)
    end)
end

-- Starting Apartment

local function CreateApartmentFurnished(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": -1.50, "y": 10.0, "z": 1.3, "h":358.50}')
	POIOffsets.clothes = json.decode('{"x": -6.028, "y": -9.5, "z": 1.2, "h":2.263}')
	POIOffsets.stash = json.decode('{"x": -7.305, "y": -3.922, "z": 0.5, "h":2.263}')
	POIOffsets.logout = json.decode('{"x": -0.8, "y": 1.0, "z": 1.0, "h":2.263}')
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
	RequestModel(`furnitured_midapart`)
	while not HasModelLoaded(`furnitured_midapart`) do
	    Wait(3)
	end
	local house = CreateObject(`furnitured_midapart`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + 1.5, spawn.y - 10.0, spawn.z, POIOffsets.exit.h)
	if IsNew then
		SetTimeout(750, function()
			TriggerEvent('qb-clothes:client:CreateFirstCharacter')
			IsNew = false
		end)
	end
    return { objects, POIOffsets }
end

-- Shells (in order by tier starting at 1)

local function CreateApartmentShell(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 4.693, "y": -6.015, "z": 1.11, "h":358.634}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
	RequestModel(`shell_v16low`)
	while not HasModelLoaded(`shell_v16low`) do
	    Wait(1000)
	end
	local house = CreateObject(`shell_v16low`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateTier1House(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 1.561, "y": -14.305, "z": 1.147, "h":2.263}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
	RequestModel(`shell_v16mid`)
	while not HasModelLoaded(`shell_v16mid`) do
	    Wait(1000)
	end
	local house = CreateObject(`shell_v16mid`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateTrevorsShell(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 0.374, "y": -3.789, "z": 2.428, "h":358.633}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
	RequestModel(`shell_trevor`)
	while not HasModelLoaded(`shell_trevor`) do
	    Wait(1000)
	end
	local house = CreateObject(`shell_trevor`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateCaravanShell(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"z":3.3, "y":-2.1, "x":-1.4, "h":358.633972168}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
	RequestModel(`shell_trailer`)
	while not HasModelLoaded(`shell_trailer`) do
	    Wait(1000)
	end
	local house = CreateObject(`shell_trailer`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateLesterShell(spawn)
	local objects = {}
    local POIOffsets = {}
    POIOffsets.exit = json.decode('{"x":-1.780, "y":-0.795, "z":1.1,"h":270.30}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
	RequestModel(`shell_lester`)
	while not HasModelLoaded(`shell_lester`) do
	    Wait(1000)
	end
	local house = CreateObject(`shell_lester`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateRanchShell(spawn)
	local objects = {}
    local POIOffsets = {}
    POIOffsets.exit = json.decode('{"x":-1.257, "y":-5.469, "z":2.5, "h":270.57,}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
	RequestModel(`shell_ranch`)
	while not HasModelLoaded(`shell_ranch`) do
	    Wait(1000)
	end
	local house = CreateObject(`shell_ranch`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

local function CreateHouseRobbery(spawn)
	local objects = {}
    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"x": 1.46, "y": -10.33, "z": 1.06, "h": 0.39}')
	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
	RequestModel(`furnitured_midapart`)
	while not HasModelLoaded(`furnitured_midapart`) do
	    Wait(1000)
	end
	local house = CreateObject(`furnitured_midapart`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
    objects[#objects+1] = house
	TeleportToInterior(spawn.x + POIOffsets.exit.x, spawn.y + POIOffsets.exit.y, spawn.z + POIOffsets.exit.z, POIOffsets.exit.h)
    return { objects, POIOffsets }
end

-- Exports

exports('DespawnInterior', DespawnInterior)
exports('CreateRanchShell', CreateRanchShell)
exports('CreateTier1House', CreateTier1House)
exports('CreateLesterShell', CreateLesterShell)
exports('CreateHouseRobbery', CreateHouseRobbery)
exports('CreateTrevorsShell', CreateTrevorsShell)
exports('CreateCaravanShell', CreateCaravanShell)
exports('CreateApartmentShell', CreateApartmentShell)
exports('CreateApartmentFurnished', CreateApartmentFurnished)

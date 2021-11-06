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

-- QBCore Command Events
RegisterNetEvent('QBCore:Command:TeleportToPlayer')
AddEventHandler('QBCore:Command:TeleportToPlayer', function(coords)
	local ped = PlayerPedId()
	SetPedCoordsKeepVehicle(ped, coords.x, coords.y, coords.z)
end)

RegisterNetEvent('QBCore:Command:TeleportToCoords')
AddEventHandler('QBCore:Command:TeleportToCoords', function(x, y, z)
	local ped = PlayerPedId()
	SetPedCoordsKeepVehicle(ped, x, y, z)
end)

RegisterNetEvent('QBCore:Command:SpawnVehicle')
AddEventHandler('QBCore:Command:SpawnVehicle', function(model)
	QBCore.Functions.SpawnVehicle(model, function(vehicle)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
		TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
	end)
end)

RegisterNetEvent('QBCore:Command:DeleteVehicle')
AddEventHandler('QBCore:Command:DeleteVehicle', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	if IsPedInAnyVehicle(PlayerPedId()) then vehicle = GetVehiclePedIsIn(PlayerPedId(), false) else vehicle = QBCore.Functions.GetClosestVehicle() end
	-- TriggerServerEvent('QBCore:Command:CheckOwnedVehicle', GetVehicleNumberPlateText(vehicle))
	QBCore.Functions.DeleteVehicle(vehicle)
end)

RegisterNetEvent('QBCore:Command:Revive')
AddEventHandler('QBCore:Command:Revive', function()
	local coords = QBCore.Functions.GetCoords(PlayerPedId())
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z+0.2, coords.a, true, false)
	SetPlayerInvincible(PlayerPedId(), false)
	ClearPedBloodDamage(PlayerPedId())
end)

RegisterNetEvent('QBCore:Command:GoToMarker')
AddEventHandler('QBCore:Command:GoToMarker', function()
	Citizen.CreateThread(function()
		local entity = PlayerPedId()
		if IsPedInAnyVehicle(entity, false) then
			entity = GetVehiclePedIsUsing(entity)
		end
		local success = false
		local blipFound = false
		local blipIterator = GetBlipInfoIdIterator()
		local blip = GetFirstBlipInfoId(8)

		while DoesBlipExist(blip) do
			if GetBlipInfoIdType(blip) == 4 then
				cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector())) --GetBlipInfoIdCoord(blip)
				blipFound = true
				break
			end
			blip = GetNextBlipInfoId(blipIterator)
		end

		if blipFound then
			DoScreenFadeOut(250)
			while IsScreenFadedOut() do
				Citizen.Wait(250)
			end
			local groundFound = false
			local yaw = GetEntityHeading(entity)
			
			for i = 0, 1000, 1 do
				SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
				SetEntityRotation(entity, 0, 0, 0, 0 ,0)
				SetEntityHeading(entity, yaw)
				SetGameplayCamRelativeHeading(0)
				Citizen.Wait(0)
				--groundFound = true
				if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then --GetGroundZFor3dCoord(cx, cy, i, 0, 0) GetGroundZFor_3dCoord(cx, cy, i)
					cz = ToFloat(i)
					groundFound = true
					break
				end
			end
			if not groundFound then
				cz = -300.0
			end
			success = true
		end

		if success then
			SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
			SetGameplayCamRelativeHeading(0)
			if IsPedSittingInAnyVehicle(PlayerPedId()) then
				if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
					SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
				end
			end
			--HideLoadingPromt()
			DoScreenFadeIn(250)
		end
	end)
end)

-- Other stuff
RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
	QBCore.PlayerData = val
end)

RegisterNetEvent('QBCore:Player:UpdatePlayerData')
AddEventHandler('QBCore:Player:UpdatePlayerData', function()
	local data = {}
	data.position = QBCore.Functions.GetCoords(PlayerPedId())
	TriggerServerEvent('QBCore:UpdatePlayer', data)
end)

RegisterNetEvent('QBCore:Player:UpdatePlayerPosition')
AddEventHandler('QBCore:Player:UpdatePlayerPosition', function()
	local position = QBCore.Functions.GetCoords(PlayerPedId())
	TriggerServerEvent('QBCore:UpdatePlayerPosition', position)
end)

RegisterNetEvent('QBCore:Notify')
AddEventHandler('QBCore:Notify', function(text, type, length)
	QBCore.Functions.Notify(text, type, length)
end)

RegisterNetEvent('QBCore:Client:TriggerCallback') -- QBCore:Client:TriggerCallback falls under GPL License here: [esxlicense]/LICENSE
AddEventHandler('QBCore:Client:TriggerCallback', function(name, ...)
	if QBCore.ServerCallbacks[name] ~= nil then
		QBCore.ServerCallbacks[name](...)
		QBCore.ServerCallbacks[name] = nil
	end
end)

RegisterNetEvent("QBCore:Client:UseItem") -- QBCore:Client:UseItem falls under GPL License here: [esxlicense]/LICENSE
AddEventHandler('QBCore:Client:UseItem', function(item)
	TriggerServerEvent("QBCore:Server:UseItem", item)
end)

--[[
-- Me command

local function Draw3DText(coords, str)
    local onScreen, worldX, worldY = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords = GetGameplayCamCoord()
	local scale = 200 / (GetGameplayCamFov() * #(camCoords - coords))
    if onScreen then
        SetTextScale(1.0, 0.5 * scale)
        SetTextFont(4)
        SetTextColour(255, 255, 255, 255)
        SetTextEdge(2, 0, 0, 0, 150)
		SetTextProportional(1)
		SetTextOutline()
		SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(str)
        DrawText(worldX, worldY)
    end
end

RegisterNetEvent('QBCore:Command:ShowMe3D', function(senderId, msg)
    local sender = GetPlayerFromServerId(senderId)
    CreateThread(function()
        local displayTime = 5000 + GetGameTimer()
        while displayTime > GetGameTimer() do
            local targetPed = GetPlayerPed(sender)
            local tCoords = GetEntityCoords(targetPed)
            Draw3DText(tCoords, msg)
            Wait(0)
        end
    end)
end)
--]]
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

local isLoggedIn = false
local PlayerJob = {}
local GarbageVehicle = nil
local hasGarbageTruck = false
local hasGarbageBag = false
local GarbageLocation = 0
local DeliveryBlip = nil
local IsWorking = false
local AmountOfBags = 0
local GarbageObject = nil
local EndBlip = nil
local GarbageBlip = nil
local Earnings = 0
local CanTakeBag = true

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
    GarbageVehicle = nil
    hasGarbageTruck = false
    hasGarbageBag = false
    GarbageLocation = 0
    DeliveryBlip = nil
    IsWorking = false
    AmountOfBags = 0
    GarbageObject = nil
    EndBlip = nil

    if PlayerJob.name == "garbage" then
        GarbageBlip = AddBlipForCoord(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z)
        SetBlipSprite(GarbageBlip, 318)
        SetBlipDisplay(GarbageBlip, 4)
        SetBlipScale(GarbageBlip, 0.6)
        SetBlipAsShortRange(GarbageBlip, true)
        SetBlipColour(GarbageBlip, 39)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations["main"].label)
        EndTextCommandSetBlipName(GarbageBlip)
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    GarbageVehicle = nil
    hasGarbageTruck = false
    hasGarbageBag = false
    GarbageLocation = 0
    DeliveryBlip = nil
    IsWorking = false
    AmountOfBags = 0
    GarbageObject = nil
    EndBlip = nil

    if PlayerJob.name == "garbage" then
        if GarbageBlip ~= nil then
            RemoveBlip(GarbageBlip)
        end
    end

    if JobInfo.name == "garbage" then
        GarbageBlip = AddBlipForCoord(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z)
        SetBlipSprite(GarbageBlip, 318)
        SetBlipDisplay(GarbageBlip, 4)
        SetBlipScale(GarbageBlip, 0.6)
        SetBlipAsShortRange(GarbageBlip, true)
        SetBlipColour(GarbageBlip, 39)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Locations["main"].label)
        EndTextCommandSetBlipName(GarbageBlip)
    end

    PlayerJob = JobInfo
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function DrawText3D2(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x,coords.y,coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function LoadModel(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(10)
    end
end

function LoadAnimation(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end

function BringBackCar()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    DeleteVehicle(veh)
    if EndBlip ~= nil then
        RemoveBlip(EndBlip)
    end
    if DeliveryBlip ~= nil then
        RemoveBlip(DeliveryBlip)
    end
    if Earnings > 0 then
        PayCheckLoop(GarbageLocation)
    end
    GarbageVehicle = nil
    hasGarbageTruck = false
    hasGarbageBag = false
    GarbageLocation = 0
    DeliveryBlip = nil
    IsWorking = false
    AmountOfBags = 0
    GarbageObject = nil
    EndBlip = nil
end

function PayCheckLoop(location)
    Citizen.CreateThread(function()
        while Earnings > 0 do
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local coords = Config.Locations["paycheck"].coords
            local distance = #(pos - vector3(coords.x, coords.y, coords.z))

            if distance < 20 then
                DrawMarker(2, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                if distance < 1.5 then
                    DrawText3D(coords.x, coords.y, coords.z, "~g~E~w~ - Lønseddel")
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('qb-garbagejob:server:PayShit', Earnings, location)
                        Earnings = 0
                    end
                elseif distance < 5 then
                    DrawText3D(coords.x, coords.y, coords.z, "Payslip")
                end
            end

            Citizen.Wait(1)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local spawnplek = Config.Locations["vehicle"].label
        local InVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
        local distance = #(pos - vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z))

        if isLoggedIn then
            if PlayerJob.name == "garbage" then
                if distance < 10.0 then
                    DrawMarker(2, Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 233, 55, 22, 222, false, false, false, true, false, false, false)
                    if distance < 1.5 then
                        if InVehicle then
                            DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "~g~E~w~ - Store Garbage Truck")
                            if IsControlJustReleased(0, 38) then
                                QBCore.Functions.TriggerCallback('qb-garbagejob:server:CheckBail', function(DidBail)
                                    if DidBail then
                                        BringBackCar()
                                        QBCore.Functions.Notify("Du har fået dine 250,- DKK i depositum tilbage!")
                                    else
                                        QBCore.Functions.Notify("Du har intet depositum betalt på dette køretøj..")
                                    end
                                end)
                            end
                        else
                            DrawText3D(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z, "~g~E~w~ - Garbage Truck")
                            if IsControlJustReleased(0, 38) then
                                QBCore.Functions.TriggerCallback('qb-garbagejob:server:HasMoney', function(HasMoney)
                                    if HasMoney then
                                        local coords = Config.Locations["vehicle"].coords
                                        QBCore.Functions.SpawnVehicle("trash2", function(veh)
                                            GarbageVehicle = veh
                                            SetVehicleNumberPlateText(veh, "GARB"..tostring(math.random(1000, 9999)))
                                            SetEntityHeading(veh, coords.w)
                                            exports['LegacyFuel']:SetFuel(veh, 100.0)
                                            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                            SetEntityAsMissionEntity(veh, true, true)
                                            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
                                            SetVehicleEngineOn(veh, true, true)
                                            hasGarbageTruck = true
                                            GarbageLocation = 1
                                            IsWorking = true
                                            SetGarbageRoute()
                                            QBCore.Functions.Notify("Du har indbetalt 250,- DKK!")
                                            QBCore.Functions.Notify("Du er begyndt at arbejde, placering markeret med GPS!")
                                        end, coords, true)
                                    else
                                        QBCore.Functions.Notify("Du har ikke penge nok til depositum .. Depositum er på 1000,- DKK")
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end

        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while true do

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false

        if isLoggedIn then
            if PlayerJob.name == "garbage" then
                if IsWorking then
                    if GarbageLocation ~= 0 then
                        if DeliveryBlip ~= nil then
                            local DeliveryData = Config.Locations["trashcan"][GarbageLocation]
                            local Distance = #(pos - vector3(DeliveryData.coords.x, DeliveryData.coords.y, DeliveryData.coords.z))

                            if Distance < 20 or hasGarbageBag then
                                LoadAnimation('missfbi4prepp1')
                                DrawMarker(2, DeliveryData.coords.x, DeliveryData.coords.y, DeliveryData.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 55, 22, 255, false, false, false, false, false, false, false)
                                if not hasGarbageBag then
                                    if CanTakeBag then
                                        if Distance < 1.5 then
                                            DrawText3D2(DeliveryData.coords, "~g~E~w~ - Tag en skraldesæk")
                                            if IsControlJustPressed(0, 51) then
                                                if AmountOfBags == 0 then
                                                    -- Randomizes how many bags to deliver
                                                    AmountOfBags = math.random(3, 5)
                                                end
                                                hasGarbageBag = true
                                                TakeAnim()
                                            end
                                        elseif Distance < 10 then
                                            DrawText3D2(DeliveryData.coords, "Stå her for at tag en skraldesæk.")
                                        end
                                    end
                                else
                                    if DoesEntityExist(GarbageVehicle) then
                                        if Distance < 10 then
                                            DrawText3D2(DeliveryData.coords, "Smid sækken bag i..")
                                        end

                                        local Coords = GetOffsetFromEntityInWorldCoords(GarbageVehicle, 0.0, -4.5, 0.0)
                                        local TruckDist = #(pos - Coords)

                                        if TruckDist < 2 then
                                            DrawText3D(Coords.x, Coords.y, Coords.z, "~g~E~w~ - Bortskaf skraldessækken")
                                            if IsControlJustPressed(0, 51) then
                                                hasGarbageBag = false
                                                local AmountOfLocations = #Config.Locations["trashcan"]
                                                -- Checks if you've delivered all the bags
                                                if (AmountOfBags - 1) == 0 then
                                                    -- Delivered all the bags
                                                    Earnings = Earnings + math.random(60, 90)
                                                    if (GarbageLocation + 1) <= AmountOfLocations then
                                                        -- Here he puts your next location and you are not finished working yet.
                                                        GarbageLocation = GarbageLocation + 1
                                                        local chance = math.random(1,100)
                                                        if chance < 26 then
                                                            TriggerServerEvent('qb-garbagejob:server:nano')
                                                        end
                                                        SetGarbageRoute()
                                                        QBCore.Functions.Notify("Alle affaldsposer er færdige, fortsæt til det næste sted!")
                                                    else
                                                        -- Finished work
                                                        QBCore.Functions.Notify("Du er færdig med at arbejde! Gå tilbage til depotet.")
                                                        IsWorking = false
                                                        RemoveBlip(DeliveryBlip)
                                                        SetRouteBack()
                                                    end
                                                    AmountOfBags = 0
                                                    hasGarbageBag = false
                                                else
                                                    -- Didn't deliver all the bags yet
                                                    AmountOfBags = AmountOfBags - 1
                                                    if AmountOfBags > 1 then
                                                        QBCore.Functions.Notify("Der er stadig "..AmountOfBags.." sække tilbage!")
                                                    else
                                                        QBCore.Functions.Notify("Der er stadig "..AmountOfBags.." sække derovre!")
                                                    end
                                                    hasGarbageBag = false
                                                end
                                                DeliverAnim()
                                            end
                                        elseif TruckDist < 10 then
                                            DrawText3D(Coords.x, Coords.y, Coords.z, "Stå her..")
                                        end
                                    else
                                        DrawText3D2(DeliveryData.coords, "Du har ingen skraldebil..")
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if not IsWorking then
            Citizen.Wait(1000)
        end

        Citizen.Wait(1)
    end
end)

function SetGarbageRoute()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local CurrentLocation = Config.Locations["trashcan"][GarbageLocation]

    if DeliveryBlip ~= nil then
        RemoveBlip(DeliveryBlip)
    end

    DeliveryBlip = AddBlipForCoord(CurrentLocation.coords.x, CurrentLocation.coords.y, CurrentLocation.coords.z)
    SetBlipSprite(DeliveryBlip, 1)
    SetBlipDisplay(DeliveryBlip, 2)
    SetBlipScale(DeliveryBlip, 1.0)
    SetBlipAsShortRange(DeliveryBlip, false)
    SetBlipColour(DeliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["trashcan"][GarbageLocation].name)
    EndTextCommandSetBlipName(DeliveryBlip)
    SetBlipRoute(DeliveryBlip, true)
end

function SetRouteBack()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local inleverpunt = Config.Locations["vehicle"]

    EndBlip = AddBlipForCoord(inleverpunt.coords.x, inleverpunt.coords.y, inleverpunt.coords.z)
    SetBlipSprite(EndBlip, 1)
    SetBlipDisplay(EndBlip, 2)
    SetBlipScale(EndBlip, 1.0)
    SetBlipAsShortRange(EndBlip, false)
    SetBlipColour(EndBlip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["vehicle"].name)
    EndTextCommandSetBlipName(EndBlip)
    SetBlipRoute(EndBlip, true)
end

function TakeAnim()
    local ped = PlayerPedId()

    LoadAnimation('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
    GarbageObject = CreateObject(GetHashKey("prop_cs_rub_binbag_01"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(GarbageObject, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)

    AnimCheck()
end

function AnimCheck()
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()

            if hasGarbageBag then
                if not IsEntityPlayingAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 3) then
                    ClearPedTasksImmediately(ped)
                    LoadAnimation('missfbi4prepp1')
                    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                end
            else
                break
            end

            Citizen.Wait(200)
        end
    end)
end

function DeliverAnim()
    local ped = PlayerPedId()

    LoadAnimation('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_throw_garbage_man', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, GetEntityHeading(GarbageVehicle))
    CanTakeBag = false

    SetTimeout(1250, function()
        DetachEntity(GarbageObject, 1, false)
        DeleteObject(GarbageObject)
        TaskPlayAnim(ped, 'missfbi4prepp1', 'exit', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
        FreezeEntityPosition(ped, false)
        GarbageObject = nil
        CanTakeBag = true
    end)
end

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        if GarbageObject ~= nil then
            DeleteEntity(GarbageObject)
            GarbageObject = nil
        end
    end
end)

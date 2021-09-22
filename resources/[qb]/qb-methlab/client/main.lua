local InsideMethlab = false
local ClosestMethlab = 0
local loadIngredients = false

local NeededAttempts = 0
local SucceededAttempts = 0
local FailedAttemps = 0

function DrawText3Ds(x, y, z, text)
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

RegisterNetEvent('police:SetCopCount')
AddEventHandler('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    TriggerServerEvent("qb-methlab:server:LoadLocationList")
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

function SetClosestMethlab()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for id, methlab in pairs(Config.Locations["laboratories"]) do
        if current ~= nil then
            if #(pos - vector3(Config.Locations["laboratories"][id].coords.x, Config.Locations["laboratories"][id].coords.y, Config.Locations["laboratories"][id].coords.z)) < dist then
                current = id
                dist = #(pos - vector3(Config.Locations["laboratories"][id].coords.x, Config.Locations["laboratories"][id].coords.y, Config.Locations["laboratories"][id].coords.z))
            end
        else
            dist = #(pos - vector3(Config.Locations["laboratories"][id].coords.x, Config.Locations["laboratories"][id].coords.y, Config.Locations["laboratories"][id].coords.z))
            current = id
        end
    end
    ClosestMethlab = current
end

Citizen.CreateThread(function()
    Wait(500)
    QBCore.Functions.TriggerCallback('qb-methlab:server:GetData', function(data)
        Config.CurrentLab = data.CurrentLab
    end)
    while true do
        SetClosestMethlab()
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    Config.CurrentLab = math.random(1, #Config.Locations["laboratories"])
    while true do
        local inRange = false
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        -- Exit distance check
        if InsideMethlab then
            if #(pos - vector3(Config.Locations["exit"].coords.x, Config.Locations["exit"].coords.y, Config.Locations["exit"].coords.z)) < 20 then
                inRange = true
                if #(pos - vector3(Config.Locations["exit"].coords.x, Config.Locations["exit"].coords.y, Config.Locations["exit"].coords.z)) < 1 then
                    DrawText3Ds(Config.Locations["exit"].coords.x, Config.Locations["exit"].coords.y, Config.Locations["exit"].coords.z, '~g~E~w~ - Leave methlab')
                    if IsControlJustPressed(0, 38) then
                        ExitMethlab()
                    end
                end
            end
        end
        -- break Meth
        if InsideMethlab then
            if #(pos - vector3(Config.Locations["break"].coords.x, Config.Locations["break"].coords.y, Config.Locations["break"].coords.z)) < 20 then
                inRange = true
                DrawMarker(2, Config.Locations["break"].coords.x, Config.Locations["break"].coords.y, Config.Locations["break"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 222, 11, 11, 155, false, false, false, true, false, false, false)
                if #(pos - vector3(Config.Locations["break"].coords.x, Config.Locations["break"].coords.y, Config.Locations["break"].coords.z)) < 1 then
                    DrawText3Ds(Config.Locations["break"].coords.x - 0.06, Config.Locations["break"].coords.y + 0.90, Config.Locations["break"].coords.z, '~g~G~w~ - Break Meth ')
                    if IsControlJustPressed(0, 47) then
                        TriggerServerEvent("qb-methlab:server:breakMeth")
                    end
                end
            end
        end
        -- load Ingredients into Furnace
        if InsideMethlab then
            if #(pos - vector3(Config.Tasks["Furnace"].coords.x, Config.Tasks["Furnace"].coords.y, Config.Tasks["Furnace"].coords.z)) < 20 then
                inRange = true
                DrawMarker(2, Config.Tasks["Furnace"].coords.x, Config.Tasks["Furnace"].coords.y,  Config.Tasks["Furnace"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.3, 0.1, 222, 11, 11, 155, false, false, false, true, false, false, false)
                DrawText3Ds(Config.Tasks["Furnace"].coords.x, Config.Tasks["Furnace"].coords.y,  Config.Tasks["Furnace"].coords.z, Config.Tasks["Furnace"].label)
                if  not machineStarted then
                    if not loadIngredients then
                        if #(pos - vector3(Config.Tasks["Furnace"].coords.x, Config.Tasks["Furnace"].coords.y, Config.Tasks["Furnace"].coords.z)) < 1 then
                            DrawText3Ds(Config.Tasks["Furnace"].coords.x, Config.Tasks["Furnace"].coords.y,  Config.Tasks["Furnace"].coords.z + 0.2, '[G] Load Ingredients')
                            if IsControlJustPressed(0, 47) then
                                TriggerServerEvent("qb-methlab:server:CheckIngredients")
                            end
                        end
                    else
                        if not finishedMachine then
                            if #(pos - vector3(Config.Tasks["Furnace"].coords.x, Config.Tasks["Furnace"].coords.y, Config.Tasks["Furnace"].coords.z)) < 1 then
                                DrawText3Ds(Config.Tasks["Furnace"].coords.x, Config.Tasks["Furnace"].coords.y,  Config.Tasks["Furnace"].coords.z + 0.2, '[E] Start Machine')
                                if IsControlJustPressed(0, 38) then
                                    StartMachine()
                                end
                            end
                        else
                            if #(pos - vector3(Config.Tasks["Furnace"].coords.x, Config.Tasks["Furnace"].coords.y, Config.Tasks["Furnace"].coords.z)) < 1 then
                                DrawText3Ds(Config.Tasks["Furnace"].coords.x, Config.Tasks["Furnace"].coords.y,  Config.Tasks["Furnace"].coords.z + 0.2, '[E] Get Meth')
                                if IsControlJustPressed(0, 38) then
                                    TriggerServerEvent("qb-methlab:server:receivemethtray")
                                    finishedMachine = false
                                    loadIngredients = false
                                    machineStarted = false
                                end
                            end
                        end
                    end
                else
                    DrawText3Ds(Config.Tasks["Furnace"].coords.x, Config.Tasks["Furnace"].coords.y, Config.Tasks["Furnace"].coords.z - 0.4, 'Ready in '..machinetimer..'s')
                end
            end
        end
        Citizen.Wait(3)
    end
end)

RegisterNetEvent('qb-methlab:client:breakMeth')
AddEventHandler('qb-methlab:client:breakMeth', function()
    PrepareAnim()
    BreakMinigame()
end)

RegisterNetEvent('qb-methlab:client:loadIngredients')
AddEventHandler('qb-methlab:client:loadIngredients', function()
    ProcessMinigame()
end)

function BreakMinigame()
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(3, 5)
        -- NeededAttempts = 1
    end

    local maxwidth = 10
    local maxduration = 3500

    Skillbar.Start({
        duration = math.random(700, 800),
        pos = math.random(10, 30),
        width = math.random(8, 12),
    }, function()

        if SucceededAttempts + 1 >= NeededAttempts then

            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0

            local random = math.random(8, 12)
            breakingMeth(random)
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(700, 800),
                pos = math.random(10, 30),
                width = math.random(8, 12),
            })
        end  
        
	end, function()
            QBCore.Functions.Notify("Failed", "error")
            ClearPedTasks(PlayerPedId())
    end)
end

function breakingMeth(amount)
    QBCore.Functions.Progressbar("break_meth", "Breaking Meth ..", Config.BreakMethTimer, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("qb-methlab:server:getmethtray", amount)
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
    end)
end

function PrepareAnim()
    local ped = PlayerPedId()
    LoadAnim('anim@heists@prison_heiststation@cop_reactions')
    TaskPlayAnim(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function ProcessMinigame()
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(3, 4)
        -- NeededAttempts = 1
    end
    local maxwidth = 10
    local maxduration = 3500
    Skillbar.Start({
        duration = math.random(700, 800),
        pos = math.random(10, 30),
        width = math.random(8, 12),
    }, function()
        if SucceededAttempts + 1 >= NeededAttempts then
            TriggerServerEvent('qb-methlab:server:loadIngredients')
            QBCore.Functions.Notify("You loaded the ingredients!", "success")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
            loadIngredients = true
            machinetimer = Config.FurnaceTimer
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(700, 800),
                pos = math.random(10, 30),
                width = math.random(8, 12),
            })
        end
	end, function()
            QBCore.Functions.Notify("Failed", "error")
    end)
end

function StartMachine()
    Citizen.CreateThread(function()
        machineStarted = true
        while machinetimer > 0 do
            machinetimer = machinetimer - 1
            Citizen.Wait(1000)
        end
        machineStarted = false
        finishedMachine = true
    end)
end

RegisterNetEvent('qb-methlab:client:UseLabKey')
AddEventHandler('qb-methlab:client:UseLabKey', function(labkey)
    if ClosestMethlab == Config.CurrentLab then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        local dist = #(pos - vector3(Config.Locations["laboratories"][ClosestMethlab].coords.x, Config.Locations["laboratories"][ClosestMethlab].coords.y, Config.Locations["laboratories"][ClosestMethlab].coords.z))
        if dist < 1 then
            if labkey == ClosestMethlab then
                EnterMethlab()
            else
                QBCore.Functions.Notify('This is not the correct key..', 'error')
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        nearMethDoor = false
            local MethDoor = #(pos - vector3(321.72,-305.87,52.50))

            if MethDoor <= 6 then
                nearMethDoor = true

                if MethDoor <= 1 then
                     if not interacting then
                        DrawText3Ds(321.72,-305.87,52.50, '~r~ Locked')

                        if IsControlJustPressed(0, 38) then
                            local ped = PlayerPedId()
                            local pos = GetEntityCoords(ped)
                    
                            local dist = #(pos - vector3(Config.Locations["laboratories"][ClosestMethlab].coords.x, Config.Locations["laboratories"][ClosestMethlab].coords.y, Config.Locations["laboratories"][ClosestMethlab].coords.z))
                            if dist < 1 then
                                 if labkey == ClosestMethlab then
                                    EnterMethlab()
                                 else
                                     QBCore.Functions.Notify('Looks like it needs a key...', 'error')
                                 end
                            end
                        end
                     end
                end
            end
        Citizen.Wait(3)
    end
end)

function EnterMethlab()
    local ped = PlayerPedId()
    OpenDoorAnimation()
    InsideMethlab = true
    Citizen.Wait(500)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    SetEntityCoords(ped, Config.Locations["exit"].coords.x, Config.Locations["exit"].coords.y, Config.Locations["exit"].coords.z - 0.98)
    SetEntityHeading(ped, Config.Locations["exit"].coords.w)
    Citizen.Wait(1000)
    DoScreenFadeIn(250)
end

function ExitMethlab()
    local ped = PlayerPedId()
    local dict = "mp_heists@keypad@"
    local anim = "idle_a"
    local flag = 0
    local keypad = {coords = {x = 996.92, y = -3199.85, z = -36.4, h = 94.5, r = 1.0}}
    SetEntityCoords(ped, keypad.coords.x, keypad.coords.y, keypad.coords.z - 0.98)
    SetEntityHeading(ped, keypad.coords.h)
    LoadAnimationDict(dict) 
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, flag, 0, false, false, false)
    Citizen.Wait(2500)
    TaskPlayAnim(ped, dict, "exit", 2.0, 2.0, -1, flag, 0, false, false, false)
    Citizen.Wait(1000)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    SetEntityCoords(ped, Config.Locations["laboratories"][Config.CurrentLab].coords.x, Config.Locations["laboratories"][Config.CurrentLab].coords.y, Config.Locations["laboratories"][Config.CurrentLab].coords.z - 0.98)
    SetEntityHeading(ped, Config.Locations["laboratories"][Config.CurrentLab].coords.w)
    InsideMethlab = false
    Citizen.Wait(1000)
    DoScreenFadeIn(250)
end

function LoadAnimationDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function OpenDoorAnimation()
    local ped = PlayerPedId()
    LoadAnimationDict("anim@heists@keycard@") 
    TaskPlayAnim(ped, "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0)
    Citizen.Wait(400)
    ClearPedTasks(ped)
end
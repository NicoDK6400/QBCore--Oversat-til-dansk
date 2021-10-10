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

local currentDealer = nil
local knockingDoor = false
local dealerIsHome = false
local waitingDelivery = nil
local activeDelivery = nil
local interacting = false
local deliveryTimeout = 0
local isHealingPerson = false
local healAnimDict = "mini@cpr@char_a@cpr_str"
local healAnim = "cpr_pumpchest"

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-drugs:server:RequestConfig', function(DealerConfig)
        Config.Dealers = DealerConfig
    end)
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        nearDealer = false

        for id, dealer in pairs(Config.Dealers) do
            local dealerDist = #(pos - vector3(dealer["coords"]["x"], dealer["coords"]["y"], dealer["coords"]["z"]))

            if dealerDist <= 6 then
                nearDealer = true

                if dealerDist <= 1.5 and not isHealingPerson then
                    if not interacting then
                        if not dealerIsHome then
                            DrawText3D(dealer["coords"]["x"], dealer["coords"]["y"], dealer["coords"]["z"], '[E] For at banke')

                            if IsControlJustPressed(0, 38) then
                                currentDealer = id
                                knockDealerDoor()
                            end
                        elseif dealerIsHome then
                            if dealer["name"] == "Mystery man" then
                                DrawText3D(dealer["coords"]["x"], dealer["coords"]["y"], dealer["coords"]["z"], '[E] For at købe / [G] Hjælp din makker (5000 DKK)')
                            else
                                DrawText3D(dealer["coords"]["x"], dealer["coords"]["y"], dealer["coords"]["z"], '[E] For at købe / [G] Start en mission')
                            end
                            if IsControlJustPressed(0, 38) then
                                buyDealerStuff()
                            end

                            if IsControlJustPressed(0, 47) then
                                if dealer["name"] == "Mystery man" then
                                    local player, distance = GetClosestPlayer()
                                    if player ~= -1 and distance < 5.0 then
                                        local playerId = GetPlayerServerId(player)
                                        isHealingPerson = true
                                        QBCore.Functions.Progressbar("hospital_revive", "Får personen på benene igen..", 5000, false, true, {
                                            disableMovement = false,
                                            disableCarMovement = false,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {
                                            animDict = healAnimDict,
                                            anim = healAnim,
                                            flags = 16,
                                        }, {}, {}, function() -- Done
                                            isHealingPerson = false
                                            StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                                            QBCore.Functions.Notify("Du har hjulpet en person!")
                                            TriggerServerEvent("hospital:server:RevivePlayer", playerId, true)
                                        end, function() -- Cancel
                                            isHealingPerson = false
                                            StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                                            QBCore.Functions.Notify("Fejlede!", "error")
                                        end)
                                    else
                                        QBCore.Functions.Notify("Der er ingen spiller i nærheden..", "error")
                                    end
                                else
                                    if waitingDelivery == nil then
                                        --TriggerEvent("chatMessage", "Dealer "..Config.Dealers[currentDealer]["name"], "Dette er produkterne, jeg holder dig opdateret på mail") --TESTER
                                        QBcore.Functions.Notify("Dealer "..Config.Dealers[currentDealer]["name"], "Dette er produkterne, jeg holder dig opdateret på mail", success, 5000)
                                        requestDelivery()
                                        interacting = false
                                        dealerIsHome = false
                                    else
                                        --TriggerEvent("chatMessage", "Dealer "..Config.Dealers[currentDealer]["name"], "error", 'Du mangler at fuldfører en mission, hvad venter du på knægt?!') --TESTER
                                        QBCore.Functions.Notify("Dealer "..Config.Dealers[currentDealer]["name"].." Du mangler at fuldfører en mission, hvad venter du på knægt?!", error, 5000)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        if not nearDealer then
            dealerIsHome = false
            Citizen.Wait(2000)
        end

        Citizen.Wait(3)
    end
end)

function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

knockDealerDoor = function()
    local hours = GetClockHours()
    local min = Config.Dealers[currentDealer]["time"]["min"]
    local max = Config.Dealers[currentDealer]["time"]["max"]

    if hours >= min and hours <= max then
        knockDoorAnim(true)
    else
        knockDoorAnim(false)
    end
end

function buyDealerStuff()
    local repItems = {}
    repItems.label = Config.Dealers[currentDealer]["name"]
    repItems.items = {}
    repItems.slots = 30

    for k, v in pairs(Config.Dealers[currentDealer]["products"]) do
        if QBCore.Functions.GetPlayerData().metadata["dealerrep"] >= Config.Dealers[currentDealer]["products"][k].minrep then
            repItems.items[k] = Config.Dealers[currentDealer]["products"][k]
        end
    end

    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Dealer_"..Config.Dealers[currentDealer]["name"], repItems)
end

function knockDoorAnim(home)
    local knockAnimLib = "timetable@jimmy@doorknock@"
    local knockAnim = "knockdoor_idle"
    local PlayerPed = PlayerPedId()
    local myData = QBCore.Functions.GetPlayerData()

    if home then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
        Citizen.Wait(100)
        while (not HasAnimDictLoaded(knockAnimLib)) do
            RequestAnimDict(knockAnimLib)
            Citizen.Wait(100)
        end
        knockingDoor = true
        TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
        Citizen.Wait(3500)
        TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
        knockingDoor = false
        Citizen.Wait(1000)
        dealerIsHome = true
        if Config.Dealers[currentDealer]["name"] == "Mystery man" then
            TriggerEvent("chatMessage", "Dealer "..Config.Dealers[currentDealer]["name"], "normal", 'Hej, hvad kan jeg gøre for dig?')
        elseif Config.Dealers[currentDealer]["name"] == "Fred" then
            dealerIsHome = false
            TriggerEvent("chatMessage", "Dealer "..Config.Dealers[currentDealer]["name"], "normal", 'Desværre, jeg laver ikke handler med dig længere ... Du skulle have behandlet mig bedre')
        else
            TriggerEvent("chatMessage", "Dealer "..Config.Dealers[currentDealer]["name"], "normal", 'Yo '..myData.charinfo.firstname..', hvad kan jeg gøre for dig?')
        end
        -- knockTimeout()
    else
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
        Citizen.Wait(100)
        while (not HasAnimDictLoaded(knockAnimLib)) do
            RequestAnimDict(knockAnimLib)
            Citizen.Wait(100)
        end
        knockingDoor = true
        TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
        Citizen.Wait(3500)
        TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
        knockingDoor = false
        Citizen.Wait(1000)
        QBCore.Functions.Notify('Ser ud til at ingen er hjemme..', 'error', 3500)
    end
end

RegisterNetEvent('qb-drugs:client:updateDealerItems')
AddEventHandler('qb-drugs:client:updateDealerItems', function(itemData, amount)
    TriggerServerEvent('qb-drugs:server:updateDealerItems', itemData, amount, currentDealer)
end)

RegisterNetEvent('qb-drugs:client:setDealerItems')
AddEventHandler('qb-drugs:client:setDealerItems', function(itemData, amount, dealer)
    Config.Dealers[dealer]["products"][itemData.slot].amount = Config.Dealers[dealer]["products"][itemData.slot].amount - amount
end)

function requestDelivery()
    local location = math.random(1, #Config.DeliveryLocations)
    local amount = math.random(1, 3)
    local item = randomDeliveryItemOnRep()
    waitingDelivery = {
        ["coords"] = Config.DeliveryLocations[location]["coords"],
        ["locationLabel"] = Config.DeliveryLocations[location]["label"],
        ["amount"] = amount,
        ["dealer"] = currentDealer,
        ["itemData"] = Config.DeliveryItems[item]
    }
    TriggerServerEvent('qb-drugs:server:giveDeliveryItems', amount)
    SetTimeout(2000, function()
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[currentDealer]["name"],
            subject = "Delivery Location",
            message = "Her er alt information til leveringen, <br>Items: <br> "..amount.."x "..QBCore.Shared.Items[waitingDelivery["itemData"]["item"]]["label"].."<br><br> lad vær med at komme for sent!!",
            button = {
                enabled = true,
                buttonEvent = "qb-drugs:client:setLocation",
                buttonData = waitingDelivery
            }
        })
    end)
end

function randomDeliveryItemOnRep()
    local ped = PlayerPedId()
    local myRep = QBCore.Functions.GetPlayerData().metadata["dealerrep"]

    retval = nil

    for k, v in pairs(Config.DeliveryItems) do
        if Config.DeliveryItems[k]["minrep"] <= myRep then
            local availableItems = {}
            table.insert(availableItems, k)

            local item = math.random(1, #availableItems)

            retval = item
        end
    end
    return retval
end

function setMapBlip(x, y)
    SetNewWaypoint(x, y)
    QBCore.Functions.Notify('Ruten til leverings adressen er blevet opdateret med til dit kort.', 'success');
end

RegisterNetEvent('qb-drugs:client:setLocation')
AddEventHandler('qb-drugs:client:setLocation', function(locationData)
    if activeDelivery == nil then
        activeDelivery = locationData
    else
        setMapBlip(activeDelivery["coords"]["x"], activeDelivery["coords"]["y"])
        QBCore.Functions.Notify('Du har stadig en levering åben...')
        return
    end

    deliveryTimeout = 300

    deliveryTimer()

    setMapBlip(activeDelivery["coords"]["x"], activeDelivery["coords"]["y"])

    Citizen.CreateThread(function()
        while true do

            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local inDeliveryRange = false

            if activeDelivery ~= nil then
                local dist = #(pos - vector3(activeDelivery["coords"]["x"], activeDelivery["coords"]["y"], activeDelivery["coords"]["z"]))

                if dist < 15 then
                    inDeliveryRange = true
                    if dist < 1.5 then
                        DrawText3D(activeDelivery["coords"]["x"], activeDelivery["coords"]["y"], activeDelivery["coords"]["z"], '[E] '..activeDelivery["amount"]..'x '..QBCore.Shared.Items[activeDelivery["itemData"]["item"]]["label"]..' aflevér.')

                        if IsControlJustPressed(0, 38) then
                            deliverStuff(activeDelivery)
                            activeDelivery = nil
                            waitingDelivery = nil
                            break
                        end
                    end
                end

                if not inDeliveryRange then
                    Citizen.Wait(1500)
                end
            else
                break
            end

            Citizen.Wait(3)
        end
    end)
end)

function deliveryTimer()
    Citizen.CreateThread(function()
        while true do

            if deliveryTimeout - 1 > 0 then
                deliveryTimeout = deliveryTimeout - 1
            else
                deliveryTimeout = 0
                break
            end

            Citizen.Wait(1000)
        end
    end)
end

function deliverStuff(activeDelivery)
    if deliveryTimeout > 0 then
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        Citizen.Wait(500)
        TriggerEvent('animations:client:EmoteCommandStart', {"bumbin"})
        checkPedDistance()
        QBCore.Functions.Progressbar("work_dropbox", "Udlevere produkter..", 3500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('qb-drugs:server:succesDelivery', activeDelivery, true)
        end, function() -- Cancel
            ClearPedTasks(PlayerPedId())
            QBCore.Functions.Notify("Canceled..", "error")
        end)
    else
        TriggerServerEvent('qb-drugs:server:succesDelivery', activeDelivery, false)
    end
    deliveryTimeout = 0
end

function checkPedDistance()
    local PlayerPeds = {}
    if next(PlayerPeds) == nil then
        for _, player in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(player)
            table.insert(PlayerPeds, ped)
        end
    end
    
    local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)

    if closestDistance < 40 and closestPed ~= 0 then
        local callChance = math.random(1, 100)

        if callChance < 15 then
            doPoliceAlert()
        end
    end
end

function doPoliceAlert()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local streetLabel = street1
    if street2 ~= nil then 
        streetLabel = streetLabel .. " " .. street2
    end

    TriggerServerEvent('qb-drugs:server:callCops', streetLabel, pos)
end

RegisterNetEvent('qb-drugs:client:robberyCall')
AddEventHandler('qb-drugs:client:robberyCall', function(msg, streetLabel, coords)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    TriggerEvent("chatMessage", "112-ALARM", "error", msg)
    --QBcore.Functions.Notify("112-ALARM" ..msg.. "", error, 5000) --TESTER
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 458)
    SetBlipColour(blip, 1)
    SetBlipDisplay(blip, 4)
    SetBlipAlpha(blip, transG)
    SetBlipScale(blip, 1.0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("112: Narkosalg")
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        if transG == 0 then
            SetBlipSprite(blip, 2)
            RemoveBlip(blip)
            return
        end
    end
end)

RegisterNetEvent('qb-drugs:client:sendDeliveryMail')
AddEventHandler('qb-drugs:client:sendDeliveryMail', function(type, deliveryData)
    if type == 'perfect' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[deliveryData["dealer"]]["name"],
            subject = "Levering",
            message = "Godt arbejde, jeg håber vi snart ses igen ;)<br><br>, "..Config.Dealers[deliveryData["dealer"]]["name"]
        })
    elseif type == 'bad' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[deliveryData["dealer"]]["name"],
            subject = "Levering",
            message = "Jeg har modtaget klager over din levering, håber ikke det gentager sig..."
        })
    elseif type == 'late' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Config.Dealers[deliveryData["dealer"]]["name"],
            subject = "Levering",
            message = "Du ankom ikke til tiden. Hvad er vigtigere end dit arbejde?"
        })
    end
end)

RegisterNetEvent('qb-drugs:client:CreateDealer')
AddEventHandler('qb-drugs:client:CreateDealer', function(dealerName, minTime, maxTime)
    local ped = PlayerPedId()
    local loc = GetEntityCoords(ped)
    local DealerData = {
        name = dealerName,
        time = {
            min = minTime,
            max = maxTime,
        },
        pos = {
            x = loc.x,
            y = loc.y,
            z = loc.z,
        }
    }

    TriggerServerEvent('qb-drugs:server:CreateDealer', DealerData)
end)

RegisterNetEvent('qb-drugs:client:RefreshDealers')
AddEventHandler('qb-drugs:client:RefreshDealers', function(DealerData)
    Config.Dealers = DealerData
end)

RegisterNetEvent('qb-drugs:client:GotoDealer')
AddEventHandler('qb-drugs:client:GotoDealer', function(DealerData)
    local ped = PlayerPedId()

    SetEntityCoords(ped, DealerData["coords"]["x"], DealerData["coords"]["y"], DealerData["coords"]["z"])
    QBCore.Functions.Notify('Du er blevet teleporteret til: '.. DealerData["name"] .. ' Held og lykke!', 'success')
end)

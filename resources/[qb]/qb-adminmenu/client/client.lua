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

local banlength = nil
local banreason = 'Unknown'
local kickreason = 'Unknown'

local menu = MenuV:CreateMenu(false, 'Admin menuen', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test')
local menu2 = MenuV:CreateMenu(false, 'Admin menuen', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test1')
local menu4 = MenuV:CreateMenu(false, 'Online spillere', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test3')
local menu5 = MenuV:CreateMenu(false, 'Server funktioner', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test4')
local menu6 = MenuV:CreateMenu(false, 'Vejr funktioner', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test5')
local menu7 = MenuV:CreateMenu(false, 'Dealer listen', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test6')
local menu8 = MenuV:CreateMenu(false, 'Ban', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test7')
local menu9 = MenuV:CreateMenu(false, 'Kick', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test8')
local menu10 = MenuV:CreateMenu(false, 'Permissions', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test9')
local menu11 = MenuV:CreateMenu(false, 'Udvikler funktioner', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test10')
local menu12 = MenuV:CreateMenu(false, 'Køretøjs handlinger', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test11')
local menu13 = MenuV:CreateMenu(false, 'Køretøjs kategori', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test12')
local menu14 = MenuV:CreateMenu(false, 'Køretøjs modeller', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'test13')

RegisterNetEvent('qb-admin:client:openMenu')
AddEventHandler('qb-admin:client:openMenu', function()
    MenuV:OpenMenu(menu)
end)

local menu_button = menu:AddButton({
    icon = '😃',
    label = 'Admin menuen',
    value = menu2,
    description = 'Misc. Admin menuen'
})
local menu_button2 = menu:AddButton({
    icon = '🙍‍♂️',
    label = 'Spiller Funktioner',
    value = menu4,
    description = 'Se oversigt over spillere'
})
local menu_button3 = menu:AddButton({
    icon = '🎮',
    label = 'Server funktioner',
    value = menu5,
    description = 'Misc. Server funktioner'
})
local menu_button21 = menu:AddButton({
    icon = '🚗',
    label = 'Køretøjer',
    value = menu12,
    description = 'Køretøjs funktioner'
})
local menu_button4 = menu:AddButton({
    icon = '💊',
    label = 'Dealer listen',
    value = menu7,
    description = 'Oversigt over dealere'
})
local menu_button5 = menu2:AddCheckbox({
    icon = '🎥',
    label = 'NoClip',
    value = menu2,
    description = 'Slå til/fra NoClip'
})
local menu_button6 = menu2:AddButton({
    icon = '🏥',
    label = 'Genopliv',
    value = 'revive',
    description = 'Genopliv dig selv'
})
local menu_button7 = menu2:AddCheckbox({
    icon = '👻',
    label = 'Usynlig',
    value = menu2,
    description = 'Slå til/fra usynlighed'
})
local menu_button8 = menu2:AddCheckbox({
    icon = '⚡',
    label = 'Godmode',
    value = menu2,
    description = 'Slå til/fra God Mode'
})
local menu_button11 = menu5:AddButton({
    icon = '🌡️',
    label = 'Vejr funktioner',
    value = menu6,
    description = 'Ændre vejret'
})
local menu_button13 = menu5:AddSlider({
    icon = '⏲️',
    label = 'Server Tid',
    value = GetClockHours(),
    values = {{
        label = '00',
        value = '00',
        description = 'Tid'
    }, {
        label = '01',
        value = '01',
        description = 'Tid'
    }, {
        label = '02',
        value = '02',
        description = 'Tid'
    }, {
        label = '03',
        value = '03',
        description = 'Tid'
    }, {
        label = '04',
        value = '04',
        description = 'Tid'
    }, {
        label = '05',
        value = '05',
        description = 'Tid'
    }, {
        label = '06',
        value = '06',
        description = 'Tid'
    }, {
        label = '07',
        value = '07',
        description = 'Tid'
    }, {
        label = '08',
        value = '08',
        description = 'Tid'
    }, {
        label = '09',
        value = '09',
        description = 'Tid'
    }, {
        label = '10',
        value = '10',
        description = 'Tid'
    }, {
        label = '11',
        value = '11',
        description = 'Tid'
    }, {
        label = '12',
        value = '12',
        description = 'Tid'
    }, {
        label = '13',
        value = '13',
        description = 'Tid'
    }, {
        label = '14',
        value = '14',
        description = 'Tid'
    }, {
        label = '15',
        value = '15',
        description = 'Tid'
    }, {
        label = '16',
        value = '16',
        description = 'Tid'
    }, {
        label = '17',
        value = '17',
        description = 'Tid'
    }, {
        label = '18',
        value = '18',
        description = 'Tid'
    }, {
        label = '19',
        value = '19',
        description = 'Tid'
    }, {
        label = '20',
        value = '20',
        description = 'Tid'
    }, {
        label = '21',
        value = '21',
        description = 'Tid'
    }, {
        label = '22',
        value = '22',
        description = 'Tid'
    }, {
        label = '23',
        value = '23',
        description = 'Tid'
    }}
})

menu_button11:On("select",function()
    menu6:ClearItems()
    local elements = {
        [1] = {
            icon = '☀️',
            label = 'Høj sol',
            value = "EXTRASUNNY",
            description = 'Hedebølge!'
        },
        [2] = {
            icon = '☀️',
            label = 'Skyfrit',
            value = "CLEAR",
            description = 'En vidunderlig dag!'
        },
        [3] = {
            icon = '☀️',
            label = 'Neutralt',
            value = "NEUTRAL",
            description = 'Bare en normal dag!'
        },
        [4] = {
            icon = '🌁',
            label = 'Røg',
            value = "SMOG",
            description = 'Der er røg overalt!'
        },
        [5] = {
            icon = '🌫️',
            label = 'Tåget',
            value = "FOGGY",
            description = 'Mose konen brygger!'
        },
        [6] = {
            icon = '⛅',
            label = 'Overskyet',
            value = "OVERCAST",
            description = 'Ikke meget sol at se!'
        },
        [7] = {
            icon = '☁️',
            label = 'Overskyet',
            value = "CLOUDS",
            description = 'Ingen sol bryder den sky'
        },
        [8] = {
            icon = '🌤️',
            label = 'Opklaring',
            value = "CLEARING",
            description = 'Det ser ud til at det bliver godt vejr!'
        },
        [9] = {
            icon = '☂️',
            label = 'Regn',
            value = "RAIN",
            description = 'Lad det regne!'
        },

        [10] = {
            icon = '⛈️',
            label = 'Torden',
            value = "THUNDER",
            description = 'Hvem elsker ikke et brag?!'
        },
        [11] = {
            icon = '❄️',
            label = 'Sne',
            value = "SNOW",
            description = 'På med frakken!'
        },
        [12] = {
            icon = '🌨️',
            label = 'Sne storm',
            value = "BLIZZARD",
            description = 'Nogen der sagde snemaskine?'
        },
        [13] = {
            icon = '❄️',
            label = 'Let sne',
            value = "SNOWLIGHT",
            description = 'Kan i mærke julen?'
        },
        [14] = {
            icon = '🌨️',
            label = 'Meget sne (Jul)',
            value = "XMAS",
            description = 'Det blev jul, og det skal fejres!'
        },
        [15] = {
            icon = '🎃',
            label = 'Halloween',
            value = "HALLOWEEN",
            description = 'Hvad er det for nogle lyde?!'
        }
    }
    for k,v in ipairs(elements) do
        local menu_button14 = menu6:AddButton({icon = v.icon,label = v.label,value = v,description = v.description,select = function(btn)
            local selection = btn.Value
            TriggerServerEvent('qb-weathersync:server:setWeather', selection.value)
            QBCore.Functions.Notify('Vejret blev ændret til: '..selection.label)
        end})
    end
end)

local menu_button69 = menu:AddButton({
    icon = '🔧',
    label = 'Udvikler funktioner',
    value = menu11,
    description = 'Misc. Dev funktioner'
})
local coords_button = menu11:AddButton({
    icon = '📋',
    label = 'Kopier koord',
    value = 'coords',
    description = 'Kopier koordinatet'
})
local togglecoords_button = menu11:AddCheckbox({
    icon = '📍',
    label = 'Vis koords',
    value = nil,
    description = 'Vis koordinater på skærmen'
})

local heading_button = menu11:AddButton({
    icon = '📋',
    label = 'Kopier Heading',
    value = 'heading',
    description = 'Kopier Heading'
})

local vehicledev_button = menu11:AddButton({
    icon = '🚘',
    label = 'Køretøjs funktioner (Dev)',
    value = nil,
    description = 'Vis køretøjs informationer'
})
local deletelazer_button = menu11:AddCheckbox({
    icon = '🔫',
    label = 'Slet Laser',
    value = menu11,
    description = 'Slå til/fra: Laser'
})
local noclip_button = menu11:AddCheckbox({
    icon = '🎥',
    label = 'NoClip',
    value = menu11,
    description = 'Slå til/fra: NoClip'
})
local names_button = menu11:AddCheckbox({               
    icon = '📋',                                        
    label = 'Navne',                                    
    value = menu11,                               
    description = 'Slå til/fra: navne overhovedet'   
})                                               
local blips_button = menu11:AddCheckbox({     
    icon = '📍',                             
    label = 'Blips',                                    
    value = menu11,                                     
    description = 'Slå til/fra: Blips på spillere'    
}) 

local menu12_button1 = menu12:AddButton({
    icon = '🚗',
    label = 'Spawn køretøj',
    value = menu13,
    description = 'Spawn et køretøj'
})
local menu12_button2 = menu12:AddButton({
    icon = '🔧',
    label = 'Fix køretøj',
    value = 'fix',
    description = 'Fix køretøjet du sidder i'
})
local menu12_button3 = menu12:AddButton({
    icon = '💲',
    label = 'Køb',
    value = 'buy',
    description = 'Køb køretøjet kvit og frit!'
})
local menu12_button4 = menu12:AddButton({
    icon = '☠',
    label = 'Fjern køretøj',
    value = 'remove',
    description = 'Fjern tætteste køretøj'
})

local deleteLazer = false
deletelazer_button:On('change', function(item, newValue, oldValue)
    deleteLazer = not deleteLazer
end)

coords_button:On("select", function()
    CopyToClipboard('coords')
end)

heading_button:On("select", function()
    CopyToClipboard('heading')
end)

vehicledev_button:On('select', function()
    ToggleVehicleDeveloperMode()
end)

noclip_button:On('change', function(item, newValue, oldValue)
    ToggleNoClipMode()
end)

togglecoords_button:On('change', function()
    ToggleShowCoordinates()
end)

local vehicles = {}
for k, v in pairs(QBCore.Shared.Vehicles) do
    local category = v["category"]
    if vehicles[category] == nil then
        vehicles[category] = { }
    end
    vehicles[category][k] = v
end

-- Car Categories
menu12_button1:On('Select', function(item)
    menu13:ClearItems()
    for k, v in pairs(vehicles) do
        local menu_button10 = menu13:AddButton({
            label = k,
            value = v,
            description = 'Kategori Navn',
            select = function(btn)
                local select = btn.Value
                OpenCarModelsMenu(select)
            end
        })
    end
end)

function OpenCarModelsMenu(category)
    menu14:ClearItems()
    MenuV:OpenMenu(menu14)
    for k, v in pairs(category) do
        local menu_button10 = menu14:AddButton({
             label = v["name"],
             value = k,
             description = 'Spawn ' .. v["name"],
             select = function(btn)
                 TriggerServerEvent('QBCore:CallCommand', "car", { k })
             end
        })
    end
end

menu12_button2:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "fix", {})
end)

menu12_button3:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "admincar", {})
end)

menu12_button4:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "dv", {})
end)

names_button:On('change', function()           
    TriggerEvent('qb-admin:client:toggleNames')
end)                                           
blips_button:On('change', function()           
    TriggerEvent('qb-admin:client:toggleBlips')
end)

-- Dealer List
menu_button4:On('Select', function(item)
    menu7:ClearItems()
    QBCore.Functions.TriggerCallback('test:getdealers', function(dealers)
        for k, v in pairs(dealers) do
            local menu_button10 = menu7:AddButton({
                label = v["name"], --.. ' | ' .. v[time.min] .. ' | ' .. v[time.max]
                value = v,
                description = 'Dealer Navn',
                select = function(btn)
                    local select = btn.Value
                    OpenDealerMenu(select)
                end
            })
        end
    end)
end)

-- Player List
menu_button2:On('select', function(item)
    menu4:ClearItems()
    QBCore.Functions.TriggerCallback('test:getplayers', function(players)
        for k, v in pairs(players) do
            local menu_button10 = menu4:AddButton({
                label = 'ID:' .. v["id"] .. ' | ' .. v["name"],
                value = v,
                description = 'Spiller navn',
                select = function(btn)
                    local select = btn.Value -- get all the values from v!

                    OpenPlayerMenus(select) -- only pass what i select nothing else
                end
            }) -- WORKS
        end
    end)
end)

menu_button13:On("select", function(item, value)
    TriggerServerEvent("qb-weathersync:server:setTime", value, value)
    QBCore.Functions.Notify("Time changed to " .. value .. " hs 00 min")

end)

function OpenDealerMenu(dealer)
    local EditDealer = MenuV:CreateMenu(false, 'Edit Dealer ' .. dealer["name"], 'topright', 220, 20, 60, 'size-125', 'none', 'menuv')
    EditDealer:ClearItems()
    MenuV:OpenMenu(EditDealer)
    local elements = {
        [1] = {
            icon = '➡️',
            label = "Gå til " .. dealer["name"],
            value = "goto",
            description = "Gå til dealer " .. dealer["name"]
        },
        [2] = {
            icon = "☠",
            label = "Fjern " .. dealer["name"],
            value = "remove",
            description = "Fjern dealer " .. dealer["name"]
        }
    }
    for k, v in ipairs(elements) do
        local menu_button10 = EditDealer:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values == "goto" then
                    TriggerServerEvent('QBCore:CallCommand', "dealergoto", { dealer["name"] })
                elseif values == "remove" then
                    TriggerServerEvent('QBCore:CallCommand', "deletedealer", { dealer["name"] })
                    EditDealer:Close()
                    menu7:Close()
                end
            end
        })
    end
end

function OpenPlayerMenus(player)

    local Players = MenuV:CreateMenu(false, player.cid .. ' Options', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv') -- Players Sub Menu
    Players:ClearItems()
    MenuV:OpenMenu(Players)
    local elements = {
        [1] = {
            icon = '💀',
            label = "Dræb",
            value = "kill",
            description = "Dræb " .. player.cid
        },
        [2] = {
            icon = '🏥',
            label = "Genopliv",
            value = "revive",
            description = "Genopliv " .. player.cid
        },
        [3] = {
            icon = '🥶',
            label = "Frys",
            value = "freeze",
            description = "Frøs " .. player.cid
        },
        [4] = {
            icon = '👀',
            label = "Spectate",
            value = "spectate",
            description = "Spectate " .. player.cid
        },
        [5] = {
            icon = '➡️',
            label = "TP til",
            value = "goto",
            description = "Gå til " .. player.cid .. " position"
        },
        [6] = {
            icon = '⬅️',
            label = "TP til mig",
            value = "bring",
            description = "Hent " .. player.cid .. " til din position"
        },
        [7] = {
            icon = '🚗',
            label = "Sid i køretøj",
            value = "intovehicle",
            description = "Sæt " .. player.cid .. " i køretøjet"
        },
        [8] = {
            icon = '🎒',
            label = "Åbn inventory",
            value = "inventory",
            description = "Åben " .. player.cid .. " inventory"
        },
        [9] = {
            icon = '👕',
            label = "Giv tøj menu",
            value = "cloth",
            description = "Giv tøj menuen til " .. player.cid
        },
        [10] = {
            icon = '🥾',
            label = "Kick",
            value = "kick",
            description = "Kick " .. player.cid .. " du skal huske at skrive en grund!"
        },
        [11] = {
            icon = '🚫',
            label = "Ban",
            value = "ban",
            description = "Ban " .. player.cid .. " du skal huske at skrive en grund!"
        },
        [12] = {
            icon = '🎟️',
            label = "Permissions",
            value = "perms",
            description = "Giv " .. player.cid .. " Permissions"
        }
    }
    for k, v in ipairs(elements) do
        local menu_button10 = Players:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values ~= "ban" and values ~= "kick" and values ~= "perms" then
                    TriggerServerEvent('qb-admin:server:'..values, player)
                elseif values == "ban" then
                    OpenBanMenu(player)
                elseif values == "kick" then
                    OpenKickMenu(player)
                elseif values == "perms" then
                    OpenPermsMenu(player)
                end
            end
        })
    end
end

function OpenBanMenu(banplayer)
    MenuV:OpenMenu(menu8)
    menu8:ClearItems()
    local menu_button15 = menu8:AddButton({
        icon = '',
        label = 'Grundlag',
        value = "reason",
        description = 'Ban grundlag',
        select = function(btn)
            banreason = LocalInput('Ban Reason', 255, 'Reason')
        end
    })

    local menu_button16 = menu8:AddSlider({
        icon = '⏲️',
        label = 'Tid',
        value = '3600',
        values = {{
            label = '1 time',
            value = '3600',
            description = 'Ban tid'
        }, {
            label = '6 timer',
            value ='21600',
            description = 'Ban tid'
        }, {
            label = '12 timer',
            value = '43200',
            description = 'Ban tid'
        }, {
            label = '1 dage',
            value = '86400',
            description = 'Ban tid'
        }, {
            label = '3 dage',
            value = '259200',
            description = 'Ban tid'
        }, {
            label = '1 uge',
            value = '604800',
            description = 'Ban tid'
        }, {
            label = '1 måned',
            value = '2678400',
            description = 'Ban tid'
        }, {
            label = '3 måneder',
            value = '8035200',
            description = 'Ban tid'
        }, {
            label = '6 måneder',
            value = '16070400',
            description = 'Ban tid'
        }, {
            label = '1 år',
            value = '32140800',
            description = 'Ban tid'
        }, {
            label = 'Permanent',
            value = '99999999999',
            description = 'Perm Ban'
        }, {
            label = 'Self',
            value = "self",
            description = 'Ban Length'
        }},
        select = function(btn, newValue, oldValue)
            if newValue == "self" then
                banlength = LocalInputInt('Ban Length', 11, 'Seconds')
            else
                banlength = newValue
            end
        end
    })

    local menu_button17 = menu8:AddButton({
        icon = '',
        label = 'Bekræft',
        value = "ban",
        description = 'Bekræft ban',
        select = function(btn)
            if banreason ~= 'Unknown' and banlength ~= nil then
                TriggerServerEvent('qb-admin:server:ban', banplayer, banlength, banreason)
                banreason = 'Unknown'
                banlength = nil
            else
                QBCore.Functions.Notify('Du skal skrive et grundlag og sæt en tid på ban!', 'error')
            end
        end
    })
end

function OpenKickMenu(kickplayer)
    MenuV:OpenMenu(menu9)
    menu9:ClearItems()
    local menu_button19 = menu9:AddButton({
        icon = '',
        label = 'Grundlag',
        value = "reason",
        description = 'Grundlag for kick',
        select = function(btn)
            kickreason = LocalInput('Kick Reason', 255, 'Reason')
        end
    })

    local menu_button18 = menu9:AddButton({
        icon = '',
        label = 'Bekræft',
        value = "kick",
        description = 'Bekræft kick',
        select = function(btn)
            if kickreason ~= 'Unknown' then
                TriggerServerEvent('qb-admin:server:kick', kickplayer, kickreason)
                kickreason = 'Unknown'
            else
                QBCore.Functions.Notify('Du skal skrive et grundlag!', 'error')
            end
        end
    })
end

function OpenPermsMenu(permsply)
    QBCore.Functions.TriggerCallback('qb-admin:server:getrank', function(rank)
        if rank then
            local selectedgroup = 'Unknown'
            MenuV:OpenMenu(menu10)
            menu10:ClearItems()
            local menu_button20 = menu10:AddSlider({
                icon = '',
                label = 'Group',
                value = 'user',
                values = {{
                    label = 'User',
                    value = 'user',
                    description = 'Group'
                }, {
                    label = 'Admin',
                    value = 'admin',
                    description = 'Group'
                }, {
                    label = 'God',
                    value = 'god',
                    description = 'Group'
                }},
                change = function(item, newValue, oldValue)
                    local vcal = newValue
                    if vcal == 1 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "user", label = "User"})
                    elseif vcal == 2 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "admin", label = "Admin"})
                    elseif vcal == 3 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "god", label = "God"})
                    end
                end
            })

            local menu_button21 = menu10:AddButton({
                icon = '',
                label = 'Bekræft',
                value = "giveperms",
                description = 'Giv permission til group',
                select = function(btn)
                    if selectedgroup ~= 'Unknown' then
                        TriggerServerEvent('qb-admin:server:setPermissions', permsply.id, selectedgroup)
			QBCore.Functions.Notify('Group blev ændret!', 'success')
                        selectedgroup = 'Unknown'
                    else
                        QBCore.Functions.Notify('Vælg en group!', 'error')
                    end
                end
            })
        else
            MenuV:CloseMenu(menu)
        end
    end)
end

-- Toggle NoClip

menu_button5:On('change', function(item, newValue, oldValue)
    ToggleNoClipMode()
end)

-- Revive Self

menu_button6:On('select', function(item)
    TriggerEvent('hospital:client:Revive', PlayerPedId())
end)

-- Invisible

local invisible = false
menu_button7:On('change', function(item, newValue, oldValue)
    if not invisible then
        invisible = true
        SetEntityVisible(PlayerPedId(), false, 0)
    else
        invisible = false
        SetEntityVisible(PlayerPedId(), true, 0)
    end
end)

-- Godmode

local godmode = false
menu_button8:On('change', function(item, newValue, oldValue)
    godmode = not godmode

    if godmode then
        while godmode do
            Citizen.Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end)

function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

function DrawEntityBoundingBox(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim =
	{
		x = 0.5*(max.x - min.x),
		y = 0.5*(max.y - min.y),
		z = 0.5*(max.z - min.z)
	}

    local FUR =
    {
		x = position.x + dim.y*rightVector.x + dim.x*forwardVector.x + dim.z*upVector.x,
		y = position.y + dim.y*rightVector.y + dim.x*forwardVector.y + dim.z*upVector.y,
		z = 0
    }

    local FUR_bool, FUR_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    FUR.z = FUR_z
    FUR.z = FUR.z + 2 * dim.z

    local BLL =
    {
        x = position.x - dim.y*rightVector.x - dim.x*forwardVector.x - dim.z*upVector.x,
        y = position.y - dim.y*rightVector.y - dim.x*forwardVector.y - dim.z*upVector.y,
        z = 0
    }
    local BLL_bool, BLL_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    BLL.z = BLL_z

    -- DEBUG
    local edge1 = BLL
    local edge5 = FUR

    local edge2 =
    {
        x = edge1.x + 2 * dim.y*rightVector.x,
        y = edge1.y + 2 * dim.y*rightVector.y,
        z = edge1.z + 2 * dim.y*rightVector.z
    }

    local edge3 =
    {
        x = edge2.x + 2 * dim.z*upVector.x,
        y = edge2.y + 2 * dim.z*upVector.y,
        z = edge2.z + 2 * dim.z*upVector.z
    }

    local edge4 =
    {
        x = edge1.x + 2 * dim.z*upVector.x,
        y = edge1.y + 2 * dim.z*upVector.y,
        z = edge1.z + 2 * dim.z*upVector.z
    }

    local edge6 =
    {
        x = edge5.x - 2 * dim.y*rightVector.x,
        y = edge5.y - 2 * dim.y*rightVector.y,
        z = edge5.z - 2 * dim.y*rightVector.z
    }

    local edge7 =
    {
        x = edge6.x - 2 * dim.z*upVector.x,
        y = edge6.y - 2 * dim.z*upVector.y,
        z = edge6.z - 2 * dim.z*upVector.z
    }

    local edge8 =
    {
        x = edge5.x - 2 * dim.z*upVector.x,
        y = edge5.y - 2 * dim.z*upVector.y,
        z = edge5.z - 2 * dim.z*upVector.z
    }

    DrawLine(edge1.x, edge1.y, edge1.z, edge2.x, edge2.y, edge2.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge3.x, edge3.y, edge3.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge6.x, edge6.y, edge6.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge7.x, edge7.y, edge7.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge5.x, edge5.y, edge5.z, color.r, color.g, color.b, color.a)
    DrawLine(edge4.x, edge4.y, edge4.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
end

Citizen.CreateThread(function()	-- While loop needed for delete lazer
	while true do
        local Wait = 7
        if deleteLazer then
            local color = {r = 255, g = 255, b = 255, a = 200}
            local position = GetEntityCoords(PlayerPedId())
            local hit, coords, entity = RayCastGamePlayCamera(1000.0)
            -- If entity is found then verifie entity
            if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
                local entityCoord = GetEntityCoords(entity)
                local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
                DrawEntityBoundingBox(entity, color)
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                Draw2DText('Obj: ~b~' .. entity .. '~w~ Model: ~b~' .. GetEntityModel(entity), 4, {255, 255, 255}, 0.4, 0.55, 0.888)
                Draw2DText('Hvis du ønsker at fjerne obkjektet skal du trykke ~g~E', 4, {255, 255, 255}, 0.4, 0.55, 0.888 + 0.025)
                -- When E pressed then remove targeted entity
                if IsControlJustReleased(0, 38) then
                    -- Set as missionEntity so the object can be remove (Even map objects)
                    SetEntityAsMissionEntity(entity, true, true)
                    --SetEntityAsNoLongerNeeded(entity)
                    --RequestNetworkControl(entity)
                    DeleteEntity(entity)
                end
            -- Only draw of not center of map
            elseif coords.x ~= 0.0 and coords.y ~= 0.0 then
                -- Draws line to targeted position
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
            end
        else
            local Wait = 500
        end
        Citizen.Wait(Wait)
	end
end)

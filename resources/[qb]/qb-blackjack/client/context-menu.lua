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

RegisterNetEvent('casino:context:hit&stand', function() 
    exports['qb-menu']:openMenu({
        {
            header = "Diamond Casino Blackjack",
            isMenuHeader = true,
        },
        {
            header = "Hit", 
            txt = "Få et kort mere",
            params = {
                event = "BLACKJACK:client:hit",
                args = {
                    
                }
            }
        },
        {
            header = "Stand", 
            txt = "Er du en pussy?",
            params = {
                event = "BLACKJACK:client:stand",
                args = {
                    
                }
            }
        },
    })
end)

RegisterNetEvent('casino:context:hit&doubledown', function() 
    exports['qb-menu']:openMenu({
        {
            header = "Diamond Casino Blackjack",
            isMenuHeader = true,
        },
        {
            header = "Hit", 
            txt = "Få et kort mere",
            params = {
                event = "BLACKJACK:client:hit",
                args = {
                    
                }
            }
        },
        {
            header = "Stand", 
            txt = "Er du en pussy?",
            params = {
                event = "BLACKJACK:client:stand",
                args = {
                    
                }
            }
        },
        {
            header = "Double Down", 
            txt = "2x dit nuværende bet",
            params = {
                event = "BLACKJACK:client:double",
                args = {
                    
                }
            }
        },
    })
end)

RegisterNetEvent('casino:context:hit&split', function()
    exports['qb-menu']:openMenu({
        {
            header = "Diamond Casino Blackjack",
            isMenuHeader = true,
        },
        {
            header = "Hit", 
            txt = "Få et kort mere",
            params = {
                event = "BLACKJACK:client:hit",
                args = {

                }
            }
        },
        {
            header = "Stand", 
            txt = "Er du en pussy?",
            params = {
                event = "BLACKJACK:client:stand",
                args = {

                }
            }
        },
        {
            header = "Split",
            txt = "Split",
            params = {
                event = "BLACKJACK:client:split",
                args = {

                }
            }
        },
    })
end)

RegisterNetEvent('qb-casino:context:casinoChipMenu', function()
    --TriggerEvent('drawtextui:HideUI')
    --TriggerEvent('nh-context:sendMenu', {
        exports['qb-menu']:openMenu({
        {
            header = "Diamond Casino",
            isMenuHeader = true,
        },
        {
            header = "Sælg alle hvide kasinochips", 
            txt = "Nuværende værdi: 1 DKK pr. chip",
            params = {
                event = "qb-casino:client:WhiteSell",
                args = {

                }
            }
        },
        {
            header = "Sælg alle røde kasinochips", 
            txt = "Nuværende værdi: 5 DKK pr. chip",
            params = {
                event = "qb-casino:client:RedSell",
                args = {

                }
            }
        },
        {
            header = "Sælg alle blå kasinochips", 
            txt = "Nuværende værdi: 10 DKK pr. chip",
            params = {
                event = "qb-casino:client:BlueSell", 
                args = {

                }
            }
        },
        {
            header = "Sælg alle sorte kasinochips", 
            txt = "Nuværende værdi: 50 DKK pr. chip",
            params = {
                event = "qb-casino:client:BlackSell",
                args = {

                }
            }
        },
        {
            header = "Sælg alle guld kasinochips", 
            txt = "Nuværende værdi: 100 DKK pr. chip",
            params = {
                event = "qb-casino:client:GoldSell",
                args = {

                }
            }
        },
    })
end)

local QBCore = exports['qb-core']:GetCoreObject()

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
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

Config = Config or {}
Config.BillingCommissions = { -- This is a percentage (0.10) == 10%
    mechanic = 0.10
}
Config.RepeatTimeout = 2000
Config.Webhook = 'https://discord.com/api/webhooks/901766539710193735/WohHYQ6RWRrm_jm2114C_MXbVDL6U7hOiqfFQa21SDh_9f_eBIjYbhqB_OWUbRAaiCjV'
Config.CallRepeats = 10
Config.OpenPhone = 244
Config.PhoneApplications = {
    ["phone"] = {
        app = "phone",
        color = "#04b543",
        icon = "fa fa-phone-alt",
        tooltipText = "Telefon",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 1,
        Alerts = 0,
    },
    ["whatsapp"] = {
        app = "whatsapp",
        color = "#25d366",
        icon = "fab fa-whatsapp",
        tooltipText = "Whatsapp",
        tooltipPos = "top",
        style = "font-size: 2.8vh";
        job = false,
        blockedjobs = {},
        slot = 2,
        Alerts = 0,
    },
    ["settings"] = {
        app = "settings",
        color = "#636e72",
        icon = "fa fa-cog",
        tooltipText = "Indstillinger",
        tooltipPos = "top",
        style = "padding-right: .08vh; font-size: 2.3vh";
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
    },
    ["twitter"] = {
        app = "twitter",
        color = "#1da1f2",
        icon = "fab fa-twitter",
        tooltipText = "Twitter",
        tooltipPos = "top",
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
    },
    ["garage"] = {
        app = "garage",
        color = "#575fcf",
        icon = "fas fa-warehouse",
        tooltipText = "Køretøjer",
        job = false,
        blockedjobs = {},
        slot = 5,
        Alerts = 0,
    },
    ["mail"] = {
        app = "mail",
        color = "#ff002f",
        icon = "fas fa-envelope",
        tooltipText = "Mail",
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0,
    },
    ["advert"] = {
        app = "advert",
        color = "#ff8f1a",
        icon = "fas fa-ad",
        tooltipText = "Reklamer",
        job = false,
        blockedjobs = {},
        slot = 7,
        Alerts = 0,
    },
    ["bank"] = {
        app = "bank",
        color = "#9c88ff",
        icon = "fas fa-university",
        tooltipText = "Bank",
        job = false,
        blockedjobs = {},
        slot = 8,
        Alerts = 0,
    },
    ["crypto"] = {
        app = "crypto",
        color = "#004682",
        icon = "fas fa-chart-pie",
        tooltipText = "Crypto",
        job = false,
        blockedjobs = {},
        slot = 9,
        Alerts = 0,
    },
    ["racing"] = {
        app = "racing",
        color = "#353b48",
        icon = "fas fa-flag-checkered",
        tooltipText = "Race",
        job = false,
        blockedjobs = {},
        slot = 10,
        Alerts = 0,
    },
    ["houses"] = {
        app = "houses",
        color = "#27ae60",
        icon = "fas fa-home",
        tooltipText = "Boliger",
        job = false,
        blockedjobs = {},
        slot = 11,
        Alerts = 0,
    },
    ["meos"] = {
        app = "meos",
        color = "#004682",
        icon = "fas fa-ad",
        tooltipText = "MDT",
        job = "police",
        blockedjobs = {},
        slot = 13,
        Alerts = 0,
    },
    ["lawyers"] = {
        app = "lawyers",
        color = "#26d4ce",
        icon = "fas fa-user-tie",
        tooltipText = "Offentlig service",
        tooltipPos = "bottom",
        job = false,
        blockedjobs = {},
        slot = 12,
        Alerts = 0,
    },
    -- ["store"] = {
    --     app = "store",
    --     color = "#27ae60",
    --     icon = "fas fa-cart-arrow-down",
    --     tooltipText = "App Store",
    --     tooltipPos = "right",
    --     style = "padding-right: .3vh; font-size: 2.2vh";
    --     job = false,
    --     blockedjobs = {},
    --     slot = 14,
    --     Alerts = 0,
    -- },
     ["trucker"] = {
         app = "trucker",
         color = "#cccc33",
         icon = "fas fa-truck-moving",
         tooltipText = "Dumbo",
         tooltipPos = "right",
         job = false,
         blockedjobs = {},
         slot = 17,
         Alerts = 0,
     },
}
Config.MaxSlots = 20

Config.StoreApps = {
    ["territory"] = {
         app = "territory",
         color = "#353b48",
         icon = "fas fa-globe-europe",
         tooltipText = "Territorium",
         tooltipPos = "right",
         style = "";
         job = false,
         blockedjobs = {},
         slot = 15,
         Alerts = 0,
         password = true,
         creator = "QBCore",
         title = "Territory",
    },
}

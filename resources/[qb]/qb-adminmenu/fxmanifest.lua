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

fx_version 'cerulean'
game 'gta5'

description 'QB-AdminMenu'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    '@menuv/menuv.lua',
    'client/noclip.lua',
    'client/blipsnames.lua',
    'client/client.lua',
    'client/events.lua'
}

shared_script '@qb-core/import.lua'

server_script 'server/server.lua'

files { -- Credits to https://github.com/LVRP-BEN/bl_coords for clipboard copy method
    'html/index.html',
    'html/index.js'
}

--dependencies {
--    'menuv',
--    'qb-drugs'
--}

dependency 'menuv'
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

description 'QB-ATM'
version '1.0.0'

shared_script 'config.lua'
server_script 'server/main.lua'
client_scripts 'client/main.lua'

ui_page 'nui/index.html'

files {
  'nui/images/logo1.png',
  'nui/images/logo.png',
  'nui/images/visa.png',
  'nui/images/mastercard.png',
  'nui/scripting/jquery-ui.css',
  'nui/scripting/external/jquery/jquery.js',
  'nui/scripting/jquery-ui.js',
  'nui/style.css',
  'nui/index.html',
  'nui/qb-atms.js'
}

lua54 'yes'
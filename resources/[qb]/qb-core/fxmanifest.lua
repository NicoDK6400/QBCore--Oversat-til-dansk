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

description 'QB-Core'
version '1.0.0'

shared_scripts { 
	'import.lua',
	'config.lua',
	'shared.lua'
}

client_scripts {
	'client/main.lua',
	'client/functions.lua',
	'client/loops.lua',
	'client/events.lua',
	'client/debug.lua'
}

server_scripts {
	'server/main.lua',
	'server/functions.lua',
	'server/loops.lua',
	'server/player.lua',
	'server/events.lua',
	'server/commands.lua',
	'server/debug.lua'
}

ui_page {
	'html/ui.html'
}

lua54 'yes'

files {
	'html/ui.html',
	'html/css/main.css',
	'html/js/app.js'
}

dependencies {
	'progressbar',
	'connectqueue'
}
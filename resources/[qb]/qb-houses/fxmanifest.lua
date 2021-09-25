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

description 'QB-Houses'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'client/gui.lua',
	'client/decorate.lua'
}

server_script 'server/main.lua'

files {
	'html/index.html',
	'html/reset.css',
	'html/style.css',
	'html/script.js',
	'html/img/dynasty8-logo.png'
}

server_export {
	'hasKey'
}

dependencies {
	'qb-core',
	'qb-interior',
	'qb-clothing',
	'qb-weathersync'
}
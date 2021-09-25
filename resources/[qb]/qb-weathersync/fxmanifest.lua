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

fx_version 'bodacious'
game 'gta5'

description 'vSyncRevamped'
version '1.0.2'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua',
}

server_scripts {
	'locale.lua',
	'locales/en.lua',
	'server/server.lua'
}

client_scripts {
	'locale.lua',
	'locales/en.lua',
	'client/client.lua'
}

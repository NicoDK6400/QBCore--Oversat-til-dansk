fx_version 'cerulean'
game 'gta5'

description 'QB-GangMenu'
version '1.0.0'

client_scripts {
    '@menuv/menuv.lua',
    'config.lua',
    'client.lua'
}

shared_script '@qb-core/import.lua'
server_script 'server.lua'

server_export 'GetAccount'
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

Config = {}

Config.RestrictedChannels = {
  [482] = {
    police = true
  },
  [470] = {
    ambulance = true
  },
  [858] = {
    police = true,
    ambulance = true
  }
} 

Config.MaxFrequency = 500

Config.messages = {
  ['not_on_radio'] = 'You\'re not connected to a signal',
  ['on_radio'] = 'You\'re already connected to this signal',
  ['joined_to_radio'] = 'You\'re connected to: ',
  ['restricted_channel_error'] = 'You can not connect to this signal!',
  ['invalid_radio'] = 'This frequency is not available.',
  ['you_on_radio'] = 'You\'re already connected to this channel',
  ['you_leave'] = 'You left the channel.'
}

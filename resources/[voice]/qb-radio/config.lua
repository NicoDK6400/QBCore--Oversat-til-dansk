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
  ['not_on_radio'] = 'Du er ikke forbundet til en kanal',
  ['on_radio'] = 'Du er allerede forbundet til kanalen',
  ['joined_to_radio'] = 'Du er forbundet til: ',
  ['restricted_channel_error'] = 'Du kan ikke forbindes til frekvensen!',
  ['invalid_radio'] = 'Denne frekvens er ikke ledig',
  ['you_on_radio'] = 'Du er allerede forbundet til kanalen',
  ['you_leave'] = 'Du forlod kanalen.'
}

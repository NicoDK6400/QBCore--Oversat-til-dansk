
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
  ['you_leave'] = 'Du forlod kanalen.',
  ['volume_radio'] = 'Ny lydstyrke ',
  ['decrease_radio_volume'] = 'Radio lydstyrken er allerede sat på maks',
  ['increase_radio_volume'] = 'Radio lydstryken kan ikke være lavere',
  ['increase_decrease_radio_channel'] = 'Ny kanal ',
}

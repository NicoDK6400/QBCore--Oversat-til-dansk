/*
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
*/

export default {
  defaultTemplateId: 'default', //This is the default template for 2 args1
  defaultAltTemplateId: 'defaultAlt', //This one for 1 arg
  templates: { //You can add static templates here
    'default': '<b>{0}</b>: {1}',
    'defaultAlt': '{0}',
    'print': '<pre>{0}</pre>',
    'example:important': '<h1>^2{0}</h1>'
  },
  fadeTimeout: 7000,
  suggestionLimit: 5,
  style: {
    background: 'rgba(52, 73, 94, 0.7)',
    width: '38vw',
    height: '22%',
  }
};

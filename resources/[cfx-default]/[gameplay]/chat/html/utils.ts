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

export function post(url: string, data: any) {
    var request = new XMLHttpRequest();
    request.open('POST', url, true);
    request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
    request.send(data);
}

function emulate(type: string, detail = {}) {
    const detailRef = {
        type,
        ...detail
    };

    window.dispatchEvent(new CustomEvent('message', {
        detail: detailRef
    }));
}

(window as any)['emulate'] = emulate;

(window as any)['demo'] = () => {
    emulate('ON_MESSAGE', {
        message: {
            args: [ 'me', 'hello!' ]
        }
    })

    emulate('ON_SCREEN_STATE_CHANGE', {
        shouldHide: false
    });
};
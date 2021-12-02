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

// Returns whether we are in browser or not
export const isEnvBrowser = () => !window.invokeNative;

/**
 * Real simple wrapper around fetch api for NUI focus
 * it will return the mockData param if we are in browser. So we don't
 * make a useless request to a hostname that doesn't exist.
 * @param evName {string} - The callback event name/type
 * @param data {any} - Optional `body` data JSON stringified & passed with the request
 * @param mockData {any} - Mock data to return if this is running in browser
 * @return Promise
 **/
export const fetchNui = async (evName, data, mockData = null) => {
  if (isEnvBrowser()) return mockData;

  const resourceName = window.GetParentResourceName();

  const rawResp = await fetch(`https://${resourceName}/${evName}`, {
    body: JSON.stringify(data),
    headers: {
      "Content-Type": "application/json; charset=UTF8",
    },
    method: "POST",
  });

  return await rawResp.json();
};
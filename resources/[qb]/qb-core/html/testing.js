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

// Will register dev utilities on window
export const registerWindowMethods = () => {
    window.SendNotification = (data) => {
      window.dispatchEvent(
        new MessageEvent("message", {
          data: {
            action: "notify",
            ...data,
          },
        })
      );
    };
  };
  
  // Used for browser env handling
  export const BrowserMockConfigData = {
    NotificationStyling: {
      group: true,
      position: "top-right",
      progress: true,
    },
    VariantDefinitions: {
      success: {
        classes: "success",
        icon: "done",
      },
      primary: {
        classes: "primary",
        icon: "info",
      },
      error: {
        classes: "error",
        icon: "dangerous",
      },
      police: {
        classes: "police",
        icon: "local_police",
      },
      ambulance: {
        classes: "ambulance",
        icon: "fas fa-ambulance",
      },
    },
  };
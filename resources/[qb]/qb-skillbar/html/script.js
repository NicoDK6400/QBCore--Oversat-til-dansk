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

$(document).ready(function(){
    Skillbar = {};

    Skillbar.Start = function(data) {
        $(".bar-check").css({"right": data.pos + "%"});
        $(".bar-check").css({"width": data.width + "%"});
        $(".bar-container").fadeIn('fast', function() {
            $(".bar-total").stop().css({"width": 0}).animate({
              width: '100%'
            }, {
              duration: parseInt(data.duration),
              easing: 'linear',
              complete: function() {
                var Percentage = Math.round((($(".bar-total").width() / $(".bar-container").width()) * 100));
                $(".bar-check").css({
                    "background-color": "rgba(231, 76, 60, 0.897)"
                });
                $(".bar-total").stop();
                // setTimeout(function(){
                    $(".bar-container").fadeOut('fast', function() {
                        $(".bar-total").css("width", 0);
                        $(".bar-check").css({"background-color": "rgba(65, 65, 65, 0.897)"});
                        $.post('https://qb-skillbar/Check', JSON.stringify({
                            success: false
                        }));
                    });
                // }, 1000);
              }
            });
        });
    }

    Skillbar.Stop = function() {
        $(".bar-container").fadeOut('fast', function() {
            $(".bar-total").css("width", 0);
        })
    }

    Skillbar.Check = function(data) {
        var Percentage = (($(".bar-total").width() / $(".bar-container").width()) * 100);
        var Check = 100 - data.data.pos
        var Minimum = Check - (data.data.width)

        $(".bar-total").stop();
        if (Percentage + 2 >= Minimum && Percentage - 2 <= Check) {
            $(".bar-check").css({
                "background-color": "#9fff78"
            });
            $.post('https://qb-skillbar/Check', JSON.stringify({
                success: true
            }));
        } else {
            $(".bar-check").css({
                "background-color": "rgba(231, 76, 60, 0.897)"
            });
            $.post('https://qb-skillbar/Check', JSON.stringify({
                success: false
            }));
        }

        $(".bar-container").fadeOut('fast', function() {
            $(".bar-total").css("width", 0);
            $(".bar-check").css({"background-color": "rgba(65, 65, 65, 0.897)"});
        });
    }

    window.addEventListener('message', function(event){
        var action = event.data.action;
        switch(action) {
            case "start":
                Skillbar.Start(event.data);
                break;
            case "stop":
                Skillbar.Stop();
                break;
            case "check":
                Skillbar.Check(event.data);
                break;
        }
    });
});
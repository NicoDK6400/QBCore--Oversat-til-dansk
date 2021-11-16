Config = {}

Config.PlayCasinoAmbientNoise = true
Config.SetShowCarOnDisplay = true
Config.VehicleOnDisplay = `demon`

Config.SetAnimatedWalls = true
Config.AnimatedWallNormal = 'CASINO_DIA_PL'
Config.AnimatedWallWin = 'CASINO_WIN_PL'
-- WALLS
-- CASINO_DIA_PL    - Falling Diamonds
-- CASINO_HLW_PL    - Falling Skulls
-- CASINO_SNWFLK_PL - Falling Snowflakes
-- CASINO_WIN_PL    - Falling Confetti

Config.SendWelcomeMail = true
Config.WelcomeMailsender = "Diamond Casino"
Config.WelcomeMailsubject ="Velkommen!"
Config.WelcomeMailmessage = "Velkommen til Diamond Casino, vi har åbent 24/7 og vi tager kun imod elektroniske betalinger"

Config.CasinoMemberships = {
    [1] = { name = "member", price = 500, amount = 5, info = {}, type = "item", slot = 1 },
    [2] = { name = "vip",    price = 750, amount = 5, info = {}, type = "item", slot = 2 }
}


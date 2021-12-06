config = {}

-- How much ofter the player position is updated ?
config.RefreshTime = 100

-- default sound format for interact
config.interact_sound_file = "ogg"

-- is emulator enabled ?
config.interact_sound_enable = false

-- how much close player has to be to the sound before starting updating position ?
config.distanceBeforeUpdatingPos = 40

-- Message list
config.Messages = {
    ["streamer_on"]  = "Streamer mode er sat til. Du vil ikke kunne høre musikken.",
    ["streamer_off"] = "Streamer mode er sat fra. Du vil nu kunne høre andres musik.",

    ["no_permission"] = "Du kan ikke bruge denne command, du har ikke permission til det!",
}

-- Addon list
-- True/False enabled/disabled
config.AddonList = {
    crewPhone = false,
}
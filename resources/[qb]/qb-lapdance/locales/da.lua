Locale                          = Locale or {}

Locale.da = { -- en is the reference that will be used for 'Config.Language'
	StandaloneLapText			= "~r~E~w~ - Spørg efter en lapdance", -- Set the text that will be displayed above marker if 'Config.Framework' is set to 'standalone'
	LapText						= "~r~E~w~ - Køb en lapdance for (~g~" .. Config.LapDanceCost .. "DKK~w~)", -- Set the text that will be displayed above marker
	BoughtLapdance				= "Du har købt dig en lapdance for 100 DKK", -- Notification text when a lap dance is bought
	StripperActive				= "Stripperen er beskæftiget!", -- Notification text if a stripper is already active when you try to buy a lap dance
	StripperPause				= "Stripperen skal hvile sig!", -- Notification text if a player wants to directly buy another lapdance within 10 seconds of finishing their last one
	NotEnoughMoney				= "Du har ikke penge nok. En lapdance koster 100 DKK" -- Notification text if player don't have enough cash
}
QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	["unemployed"] = {
		label = "Arbejdsløs",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Freelancer",
                payment = 10
            },
        },
	},
	["police"] = {
		label = "Politi",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Politi kadet",
                payment = 50
            },
			['1'] = {
                name = "Politibetjent",
                payment = 75
            },
			['2'] = {
                name = "Politiassistent",
                payment = 100
            },
			['3'] = {
                name = "Politiassistent 1. Grad",
                payment = 125
            },
			['4'] = {
                name = "Chief",
                payment = 150
            },
			['5'] = {
                name = "Politikommissær",
                payment = 125
            },
			['6'] = {
                name = "Vicepolitiinspektør",
				isboss = true,
                payment = 150
            },
			['7'] = {
				name = "Politiinspektør",
				isboss = true,
				payment = 150
			},
        },
	},
	["ambulance"] = {
		label = "EMS",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Rekrut",
                payment = 50
            },
			['1'] = {
                name = "Raramediciner",
                payment = 75
            },
			['2'] = {
                name = "Læge",
                payment = 100
            },
			['3'] = {
                name = "Kirug",
                payment = 125
            },
			['4'] = {
                name = "Overlæge",
				isboss = true,
                payment = 150
            },
        },
	},
	["realestate"] = {
		label = "Ejendomsmæglere",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Rekrut",
                payment = 50
            },
			['1'] = {
                name = "Bolig salg",
                payment = 75
            },
			['2'] = {
                name = "Erhvervs salg",
                payment = 100
            },
			['3'] = {
                name = "Mægler",
                payment = 125
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 150
            },
        },
	},
	["taxi"] = {
		label = "Taxi",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Rekrut",
                payment = 50
            },
			['1'] = {
                name = "Fører",
                payment = 75
            },
			['2'] = {
                name = "Event fører",
                payment = 100
            },
			['3'] = {
                name = "Salg",
                payment = 125
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 150
            },
        },
	},
	["cardealer"] = {
		label = "Bilforhandler",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Rekrut",
                payment = 50
            },
			['1'] = {
                name = "Showroom Salg",
                payment = 75
            },
			['2'] = {
                name = "Erhvervs salg",
                payment = 100
            },
			['3'] = {
                name = "Finans",
                payment = 125
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 150
            },
        },
	},
	["mechanic"] = {
		label = "Mekanikere",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Ufaglært",
                payment = 50
            },
			['1'] = {
                name = "Lærling",
                payment = 75
            },
			['2'] = {
                name = "Udlært",
                payment = 100
            },
			['3'] = {
                name = "Senior",
                payment = 125
            },
			['4'] = {
                name = "Manager",
				isboss = true,
                payment = 150
            },
        },
	},
	["judge"] = {
		label = "Retssal",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Dommer",
                payment = 100
            },
        },
	},
	["lawyer"] = {
		label = "Advokat firma",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Medarbejder",
                payment = 50
            },
        },
	},
	["reporter"] = {
		label = "Journalist",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Journalist",
                payment = 50
            },
        },
	},
	["trucker"] = {
		label = "Lastbil chauffør",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Fører",
                payment = 50
            },
        },
	},
	["tow"] = {
		label = "Bugseringsfirma",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Fører",
                payment = 50
            },
        },
	},
	["garbage"] = {
		label = "Skraldemand",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Medarbejder",
                payment = 50
            },
        },
	},
	["vineyard"] = {
		label = "Vingård",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Medarbejder",
                payment = 50
            },
        },
	},
	["hotdog"] = {
		label = "Hotdog",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Sælger",
                payment = 50
            },
        },
	},
	["vanilla"] = {
		label = "Vanilla Unicorn",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = "Medarbejder",
                payment = 50
            },
			['1'] = {
                name = "DJ",
                payment = 80
            },
			['2'] = {
                name = "Chef",
                payment = 50
            },
        },
	},
}
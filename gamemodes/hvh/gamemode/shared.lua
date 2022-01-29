GM.Name = "Hack vs Hack"
GM.Version = "2.0"
GM.Author = "Default"

PLAYER = FindMetaTable("Player")

color = {}
color.orange = Color(255, 102, 0)
color.white = color_white

config = {}
config.ProjectName = "NeverMind"

config.WhitelistEnabled = false
config.WhitelistKickMessage = "Technical works\nServer is currently not avaible"
config.Whitelist = {
	["STEAM_0:0:240757902"] = true, -- Default
}

config.AutoRespawn = true
config.RespawnTime = 1.4

config.ChatSpamCooldown = 90

config.AmmoTypes = {"pistol", "smg1", "AR2", "buckshot", "357"}
config.AmmoAmmount = 9999

config.RussianLanguage = {"RU", "BY", "UA", "KZ"} -- https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
config.Leveling = {
	["StarterXP"] = 60,
	["KillXP"] = 4,
	["DeathXP"] = 4,
}

config.Killstreaks = {
	[3] = {sound = "multikill", str = "did a TRIPLEKILL"},
	[6] = {sound = "dominating", str = "DOMINATING"},
	[10] = {sound = "killingspree", str = "did a KILLINGSPREE"},
	[15] = {sound = "rampage", str = "in RAGE"},
	[20] = {sound = "godlike", str = "GODLIKE"},
	[25] = {sound = "unstoppable", str = "UNSTOPPABLE"},
}

config.QuakeSounds = {
	male = {
		["headshot"] = "quake/male/headshot.mp3",
		["multikill"] = "quake/male/multikill.mp3",
		["dominating"] = "quake/male/dominating.mp3",
		["killingspree"] = "quake/male/killingspree.mp3",
		["rampage"] = "quake/male/rampage.mp3",
		["godlike"] = "quake/male/godlike.mp3",
		["holyshit"] = "quake/male/holyshit.mp3",
		["unstoppable"] = "quake/male/unstoppable.mp3",
		["humiliation"] = "quake/male/humiliation.mp3",
	},
	
	female = {
		["headshot"] = "quake/female/headshot.mp3",
		["multikill"] = "quake/female/multikill.mp3",
		["dominating"] = "quake/female/dominating.mp3",
		["killingspree"] = "quake/female/killingspree.mp3",
		["rampage"] = "quake/female/rampage.mp3",
		["godlike"] = "quake/female/godlike.mp3",
		["holyshit"] = "quake/female/holyshit.mp3",
		["unstoppable"] = "quake/female/unstoppable.mp3",
		["humiliation"] = "quake/female/humiliation.mp3",
	}
}

config.AllowedWeapons = {
	primary = {
		["css_ak47"] = {
			name = "AK47",
			mdl = "models/weapons/w_rif_ak47.mdl"
		},

		["css_galil"] = {
			name = "Galil",
			mdl = "models/weapons/w_rif_galil.mdl"
		},
		
		["css_m4a1"] = {
			name = "M4A1",
			mdl = "models/weapons/w_rif_m4a1.mdl"
		},
		
		["css_aug"] = {
			name = "AUG",
			mdl = "models/weapons/w_rif_aug.mdl"
		},

		["css_famas"] = {
			name = "FAMAS",
			mdl = "models/weapons/w_rif_famas.mdl"
		},
		
		["css_m249"] = {
			name = "M249",
			mdl = "models/weapons/w_mach_m249para.mdl"
		},
		
		["css_mp5"] = {
			name = "MP5",
			mdl = "models/weapons/w_smg_mp5.mdl"
		},
		
		["css_tmp"] = {
			name = "TMP",
			mdl = "models/weapons/w_smg_tmp.mdl"		
		},
	},
	
	secondary = {
		["css_57"] = { 
			name = "FiveSeven",
			mdl = "models/weapons/w_pist_fiveseven.mdl"
		},
		
		["css_deagle"] = {
			name = "Deagle",
			mdl = "models/weapons/w_pist_deagle.mdl"
		},

		["css_usp"] = {
			name = "USP",
			mdl = "models/weapons/w_pist_usp.mdl"
		},
		
		["css_glock"] = {
			name = "Glock",
			mdl = "models/weapons/w_pist_glock18.mdl"
		},
		
		["css_p228"] = {
			name = "P228",
			mdl = "models/weapons/w_pist_p228.mdl"
		},
		
		["css_dualellites"] = {
			name = "Dual Elites",
			mdl = "models/weapons/w_pist_elite.mdl"
		},
	},
}
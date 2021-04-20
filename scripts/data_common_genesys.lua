--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--
--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

-- function isPFRPG()
-- 	return false;
-- end


-- Characteristics (database names)
characteristics = {
	"brawn",
	"agility",
	"intellect",
	"cunning",
	"willpower",
	"presence"
};

characteristics_ltos = {
	["brawn"] = "BR",
	["agility"] = "AG",
	["intellect"] = "IN",
	["cunning"] = "CU",
	["willpower"] = "WI",
	["presence"] = "PR"
};

characteristics_stol = {
	["BR"] = "brawn",
	["AG"] = "agility",
	["IN"] = "intellect",
	["CU"] = "cunning",
	["WI"] = "willpower",
	["PR"] = "presence"
};

	-- This is used by the ruleset to choose which skills to filter and show in the character sheet
	genesys_settings = {
			["Terrinoth"] = {
					shortname = "TERRINOTH" ,
					description = "<p>Terrinoth is a Fantasy Setting.</p>"
				},
			["Android - Shadow of the Beanstalk"] = {
					shortname = "ANDROID",
					description = "<p>Android is a Cyberpunk Setting.</p>"
				},
			["Generic Setting"] = {
				shortname = "GENERIC",
				description = "<p>This is a generic setting...</p>"
			}
	};




skilldata = {
-- GENERAL SKILLS
	["Alchemy"] = {
	    characteristic = "IN",
	    description = "" , category = "General"
	  },
	["Astrocartography"] = {
	    characteristic = "IN",
	    description = "" , category = "General"
	  },
	["Athletics"] = {
	    characteristic = "BR",
	    description = "" , category = "General"
	  },
	["Computers"] = {
	    characteristic = "IN",
	    description = "" , category = "General"
	  },
	["Cool"] = {
	    characteristic = "PR",
	    description = "" , category = "General"
	  },
	["Coordination"] = {
	    characteristic = "AG",
	    description = "" , category = "General"
	  },
	["Discipline"] = {
	    characteristic = "WI",
	    description = "" , category = "General"
	  },
	["Driving"] = {
	    characteristic = "AG",
	    description = "" , category = "General"
	  },
	["Mechanics"] = {
	    characteristic = "IN",
	    description = "" , category = "General"
	  },
	["Medicine"] = {
	    characteristic = "IN",
	    description = "" , category = "General"
	  },
	["Operating"] = {
	    characteristic = "IN",
	    description = "" , category = "General"
	  },
	["Perception"] = {
	    characteristic = "CU",
	    description = "" , category = "General"
	  },
	["Piloting"] = {
	    characteristic = "AG",
	    description = "" , category = "General"
	  },
	["Resilience"] = {
	    characteristic = "BR",
	    description = "" , category = "General"
	  },
	["Riding"] = {
	    characteristic = "AG",
	    description = "" , category = "General"
	  },
	["Skulduggery"] = {
	    characteristic = "CU",
	    description = "" , category = "General"
	  },
	["Stealth"] = {
	    characteristic = "AG",
	    description = "" , category = "General"
	  },
	["Streetwise"] = {
	    characteristic = "CU",
	    description = "" , category = "General"
	  },
	["Survival"] = {
	    characteristic = "CU",
	    description = "" , category = "General"
	  },
	["Vigilance"] = {
	    characteristic = "WI",
	    description = "" , category = "General"
	  },
-- COMBAT SKILLS
	["Brawl"] = {
				characteristic = "BR",
				description = "" , category = "Combat"
			},
		["Gunnery"] = {
				characteristic = "AG",
				description = "" , category = "Combat"
			},
		["Melee"] = {
				characteristic = "BR",
				description = "" , category = "Combat"
			},
		["Melee (Heavy)"] = {
				characteristic = "BR",
				description = "" , category = "Combat"
			},
		["Melee (Light)"] = {
				characteristic = "BR",
				description = "" , category = "Combat"
			},
		["Ranged"] = {
				characteristic = "AG",
				description = "" , category = "Combat"
			},
		["Ranged (Heavy)"] = {
				characteristic = "AG",
				description = "" , category = "Combat"
			},
		["Ranged (Light)"] = {
				characteristic = "AG",
				description = "" , category = "Combat"
			},
-- KNOWLEDGE SKILLS
		["Knowledge"] = {
				characteristic = "IN",
				description = "" , category = "Knowledge"
		},
-- SOCIAL SKILLS
["Charm"] = {
		characteristic = "PR",
		description = "" , category = "Social"
	},
["Coercion"] = {
		characteristic = "WI",
		description = "" , category = "Social"
	},
["Deception"] = {
		characteristic = "CU",
		description = "" , category = "Social"
	},
["Leadership"] = {
		characteristic = "PR",
		description = "" , category = "Social"
	},
["Negotiation"] = {
		characteristic = "PR",
		description = "" , category = "Social"
	},

-- MAGIC SKILLS
	["Arcana"] = {
			characteristic = "IN",
			description = "" , category = "Magic"
		},
	["Divine"] = {
			characteristic = "WI",
			description = "" , category = "Magic"
		},
	["Primal"] = {
			characteristic = "CU",
			description = "" , category = "Magic"
		},
	["Runes"] = {
			characteristic = "IN",
			description = "" , category = "Magic"
		},
	["Verse"] = {
			characteristic = "PR",
			description = "" , category = "Magic"
		}
	};




	critical_injury_result_data = {
		["Minor Nick"] = {
				d100_start = 1,
				d100_end = 5,
				name = "Minor Nick",
				description = "Target suffers 1 strain.",
				severity = 1,
			},
		["Slowed Down"] = {
				d100_start = 6,
				d100_end = 10,
				name = "Slowed Down",
				description = "The target can only act during the last allied initiative slot on their next turn.",
				severity = 1,
			},
		["Sudden Jolt"] = {
				d100_start = 11,
				d100_end = 15,
				name = "Sudden Jolt",
				description = "The target drops whatever is in hand.",
				severity = 1,
			},
		["Distracted"] = {
				d100_start = 16,
				d100_end = 20,
				name = "Distracted",
				description = "The target cannot perform a free maneuver during their next turn.",
				severity = 1,
			},
		["Off-Balance"] = {
				d100_start = 21,
				d100_end = 25,
				name = "Off-Balance",
				description = "Add [S] to the target's next skill check.",
				severity = 1,
			},
		["Discouraging Wound"] = {
				d100_start = 26,
				d100_end = 30,
				name = "Discouraging Wound",
				description = "Move one player pool Story Point to the Game Master pool (reverse if NPC).",
				severity = 1,
			},
		["Stunned"] = {
				d100_start = 31,
				d100_end = 35,
				name = "Stunned",
				description = "The target is staggered until the end of their next turn.",
				severity = 1,
			},
		["Stinger"] = {
				d100_start = 36,
				d100_end = 40,
				name = "Stinger",
				description = "Increase the difficulty of the target's next check by one.",
				severity = 1,
			},
		["Bowled Over"] = {
				d100_start = 41,
				d100_end = 45,
				name = "Bowled Over",
				description = "The target is knocked prone and suffers 1 strain.",
				severity = 2,
			},
		["Head Ringer"] = {
				d100_start = 46,
				d100_end = 50,
				name = "Head Ringer",
				description = "The target increases the difficulty of all Intellect and Cunning checks by one until this Critical Injury is healed.",
				severity = 2,
			},
		["Fearsome Wound"] = {
				d100_start = 51,
				d100_end = 55,
				name = "Fearsome Wound",
				description = "The target increases the difficulty of all Presence and Willpower checks by one until this Critical Injury is healed.",
				severity = 2,
			},
		["Agonizing Wound"] = {
				d100_start = 56,
				d100_end = 60,
				name = "Agonizing Wound",
				description = "The target increases the difficulty of all Brawn and Agility checks by one until this Critical Injury is healed.",
				severity = 2,
			},
		["Slightly Dazed"] = {
				d100_start = 61,
				d100_end = 65,
				name = "Slightly Dazed",
				description = "The target is disoriented until this Critical Injury is healed.",
				severity = 2,
			},
		["Scattered Senses"] = {
				d100_start = 66,
				d100_end = 70,
				name = "Scattered Senses",
				description = "The target removes all [B] from skill checks until this Critical Injury is healed.",
				severity = 2,
			},
		["Hamstrung"] = {
				d100_start = 71,
				d100_end = 75,
				name = "Hamstrung",
				description = "The target loses their free maneuver until this Critical Injury is healed.",
				severity = 2,
			},
		["Overpowered"] = {
				d100_start = 76,
				d100_end = 80,
				name = "Overpowered",
				description = "The target leaves themself open, and the attacker may immediately attempt another attack against them as an incidental, using the exact same pool as the original attack.",
				severity = 2,
			},
		["Winded"] = {
				d100_start = 81,
				d100_end = 85,
				name = "Winded",
				description = "The target cannot voluntarily suffer strain to activate any abilities or gain additional maneuvers until this Critical Injury is healed.",
				severity = 2,
			},
		["Compromised"] = {
				d100_start = 86,
				d100_end = 90,
				name = "Compromised",
				description = "Increase difficulty of all skill checks by one until this Critical Injury is healed.",
				severity = 2,
			},
		["At the Brink"] = {
				d100_start = 91,
				d100_end = 95,
				name = "At the Brink",
				description = "The target suffers 2 strain each time they perform an action until this Critical Injury is healed.",
				severity = 3,
			},
		["Crippled"] = {
				d100_start = 96,
				d100_end = 100,
				name = "Crippled",
				description = "One of the target's limbs (selected by the GM) is impaired until this Critical Injury is healed. Increase difficulty of all checks that require use of that limb by one.",
				severity = 3,
			},
		["Maimed"] = {
				d100_start = 101,
				d100_end = 105,
				name = "Maimed",
				description = "One of the target's limbs (selected by the GM) is permanently lost. Unless the target has a cybernetic or prosthetic replacement, the target cannot perform actions that would require the use of that limb. All other actions gain [S] until this Critical Injury is healed.",
				severity = 3,
			},
		["Horrific Injury"] = {
				d100_start = 106,
				d100_end = 110,
				name = "Horrific Injury",
				description = "Roll 1d10 to determine which of the target's characteristics is affected: 1–3 for Brawn, 4–6 for Agility, 7 for Intellect, 8 for Cunning, 9 for Presence, 10 for Willpower. Until this Critical Injury is healed, treat that characteristic as one point lower.",
				severity = 3,
			},
		["Temporarily Disabled"] = {
				d100_start = 111,
				d100_end = 115,
				name = "Temporarily Disabled",
				description = "The target is immobilized until this Critical Injury is healed.",
				severity = 3,
			},
		["Blinded"] = {
				d100_start = 116,
				d100_end = 120,
				name = "Blinded",
				description = "The target can no longer see. Upgrade the difficulty of all checks twice, and upgrade the difficulty of Perception and Vigilance checks three times, until this Critical Injury is healed.",
				severity = 3,
			},
		["Knocked Senseless"] = {
				d100_start = 121,
				d100_end = 125,
				name = "Knocked Senseless",
				description = "The target is staggered until this Critical Injury is healed.",
				severity = 3,
			},
		["Gruesome Injury"] = {
				d100_start = 126,
				d100_end = 130,
				name = "Gruesome Injury",
				description = "Roll 1d10 to determine which of the target's characteristics is affected: 1–3 for Brawn, 4–6 for Agility, 7 for Intellect, 8 for Cunning, 9 for Presence, 10 for Willpower. That characteristic is permanently reduced by one, to a minimum of 1.",
				severity = 4,
			},
		["Bleeding Out"] = {
				d100_start = 131,
				d100_end = 140,
				name = "Bleeding Out",
				description = "Until this Critical Injury is healed, every round, the target suffers 1 wound and 1 strain at the beginning of their turn. For every 5 wounds they suffer beyond their wound threshold, they suffer one additional Critical Injury. Roll on the chart, suffering the injury (if they suffer this result a second time due to this, roll again).",
				severity = 4,
			},
		["The End is Nigh"] = {
				d100_start = 141,
				d100_end = 150,
				name = "The End is Nigh",
				description = "The target dies after the last Initiative slot during the next round unless this Critical Injury is healed.",
				severity = 4,
			},
		["Dead"] = {
				d100_start = 151,
				d100_end = 9999,
				name = "Dead",
				description = "Complete, obliterated death.",
				severity = 999,
			}
	};


	critical_vehicle_result_data = {
		["Rattled"] = {
				d100_start = 1,
				d100_end = 18,
				name = "Rattled",
				description = "The vehicle suffers 3 system strain, and its pilot and each occupant suffer 3 strain.",
				severity = 1,
			},
		["Shrapnel Spray"] = {
				d100_start = 19,
				d100_end = 36,
				name = "Shrapnel Spray",
				description = "Chunks of metal or wood are hurled at the occupants at deadly velocity. The pilot and occupants must each make a Hard ([D][D][D]) Resilience or Vigilance check or suffer 1 wound, plus 1 additional wound per (F) on the check; you may spend (T)(T)(T) or (D) from this check to inflict a Critical Injury on the character.",
				severity = 1,
			},
		["Hull Damaged"] = {
				d100_start = 37,
				d100_end = 54,
				name = "Hull Damaged",
				description = "The vehicle's hull is compromised (see Vehicle Components on page 221 of the Genesys Core Rulebook).",
				severity = 1,
			},
		["Navigation Damaged"] = {
				d100_start = 55,
				d100_end = 63,
				name = "Navigation Damaged",
				description = "The vehicle's navigation is compromised (see Vehicle Components, on page 221 of the Genesys Core Rulebook).",
				severity = 2,
			},
		["Propulsion Damaged"] = {
				d100_start = 64,
				d100_end = 72,
				name = "Propulsion Damaged",
				description = "The vehicle's propulsion is compromised (see Vehicle Components, on page 221 of the Genesys Core Rulebook).",
				severity = 2,
			},
		["Defenses Damaged"] = {
				d100_start = 73,
				d100_end = 81,
				name = "Defenses Damaged",
				description = "The vehicle's defenses are compromised (see Vehicle Components, on page 221 of the Genesys Core Rulebook).",
				severity = 2,
			},
		["Weapons Damaged"] = {
				d100_start = 82,
				d100_end = 108,
				name = "Weapons Damaged",
				description = "One of the vehicle's weapons of the attacker's choice is compromised (see Vehicle Components, on page 221 of the Genesys Core Rulebook).",
				severity = 3,
			},
		["Brakes Damaged"] = {
				d100_start = 109,
				d100_end = 126,
				name = "Brakes Damaged",
				description = "The vehicle's brakes are compromised (see Vehicle Components, on page 221 of the Genesys Core Rulebook).",
				severity = 3,
			},
		["All Systems Down"] = {
				d100_start = 127,
				d100_end = 138,
				name = "All Systems Down",
				description = "All of the vehicle's components are compromised (see Vehicle Components, on page 221 of the Genesys Core Rulebook).",
				severity = 4,
			},
		["Fire!"] = {
				d100_start = 139,
				d100_end = 144,
				name = "Fire!",
				description = "The vehicle catches on fire. While the vehicle is on fire, each occupant suffers damage as discussed on page 111 of the Genesys Core Rulebook. A fire can be put out with a Hard ([D][D][D]) Cool or Athletics check (or multiple checks for big vehicles).",
				severity = 4,
			},
		["Breaking Up"] = {
				d100_start = 145,
				d100_end = 153,
				name = "Breaking Up",
				description = "The vehicle begins to come apart at its seams, disintegrating around the occupants. At the end of the following round, it is completely destroyed, and the surrounding environment is littered with debris. Anyone aboard the vehicle has one round to dive for the nearest door before they are lost.",
				severity = 4,
			},
		["Vaporized"] = {
				d100_start = 154,
				d100_end = 9999,
				name = "Vaporized",
				description = "The vehicle is completely destroyed, consumed in a large and dramatic fireball. Nothing survives.",
				severity = 999,
			}
	};

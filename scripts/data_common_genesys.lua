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
	--
	-- Please see the license.html file included with this distribution for
	-- attribution and copyright information.
	--

--[[ JOHN: This is from Star Wars... left heere temporarily, I might reactivate later or use to create an extension

	basicskilldata = {
		["Astrogation"] = {
				characteristic = "IN",
				description = "<p>The Astrogation skill represents a character's ability to use his knowledge of the galaxy to most efficiently program the hyperspace coordinates for any jump.</p>"
			},
		["Athletics"] = {
				characteristic = "BR"
			},
		["Charm"] = {
				characteristic = "PR"
			},
		["Coercion"] = {
				characteristic = "WI"
			},
		["Computers"] = {
				characteristic = "IN"
			},
		["Cool"] = {
				characteristic = "PR"
			},
		["Coordination"] = {
				characteristic = "AG",
				description = "<p></p>"
			},
		["Deception"] = {
				characteristic = "CU",
				description = "<p></p>"
			},
		["Discipline"] = {
				characteristic = "WI",
				description = "<p></p>"
			},
		["Leadership"] = {
				characteristic = "PR",
				description = "<p></p>"
			},
		["Mechanics"] = {
				characteristic = "IN",
				description = "<p></p>"
			},
		["Medicine"] = {
				characteristic = "IN",
				description = "<p></p>"
			},
		["Negotiation"] = {
				characteristic = "PR",
				description = "<p></p>"
			},
		["Perception"] = {
				characteristic = "CU",
				description = "<p></p>"
			},
		["Pilot - Planet"] = {
				characteristic = "AG",
				description = "<p></p>"
			},
		["Pilot - Space"] = {
				characteristic = "AG",
				description = "<p></p>"
			},
		["Resilience"] = {
				characteristic = "BR",
				description = "<p></p>"
			},
		["Skulduggery"] = {
				characteristic = "CU",
				description = "<p></p>"
			},
		["Stealth"] = {
				characteristic = "AG",
				description = "<p></p>"
			},
		["Streetwise"] = {
				characteristic = "CU",
				description = "<p></p>"
			},
		["Survival"] = {
				characteristic = "CU",
				description = "<p></p>"
			},
		["Vigilance"] = {
				characteristic = "WI",
				description = "<p></p>"
			}
	};

	knowledgeskilldata = {
		["Core Worlds"] = {
				characteristic = "IN",
				description = "<p>Knowledge of the culture, planets and systems of the Core Worlds.</p>",
				knowledge = 1,
			},
		["Educations"] = {
				characteristic = "IN",
				description = "<p>Indication of the general level of the character's education.  Reading, mathmatics, basic sciences and engineering, etc..</p>",
				knowledge = 1,
			},
		["Lore"] = {
				characteristic = "IN",
				description = "<p>Deciphering ancient script and knowledge of ancient legends.</p>",
				knowledge = 1,
			},
		["Outer Rim"] = {
				characteristic = "IN",
				description = "<p>Knowledge of the culture, planets and systems of the Outer Rim</p>",
				knowledge = 1,
			},
		["Underworld"] = {
				characteristic = "IN",
				description = "<p>Knowledge of illegal activities and the criminal hotspot lcoations.</p>",
				knowledge = 1,
			},
		["Xenology"] = {
				characteristic = "IN",
				description = "<p>Knowledge of the different alien species; including culture, habits and physical traits.</p>",
				knowledge = 1,
			}
	};

	combatskilldata = {
		["Brawl"] = {
				characteristic = "BR",
				description = "<p>Unarmed combat is governed by the Brawl skill and deals damage equal to the character's Brawn characteristic.</p>",
				advanced = 1,
			},
		["Melee"] = {
				characteristic = "BR",
				description = "<p>The training to use weapons to deadly effect while engaged with an enemy makes up the Melee skill. Uses Brawn characteristic.</p>",
				advanced = 1,
			},
		["Ranged(Hvy)(Ag)"] = {
				characteristic = "AG",
				description = "<p>Ranged weapons requiring two hands to wield or aim, including blaster rifles and large thrown weapons such as spears and throwing axes, rely on this skill.</p>",
				advanced = 1,
			},
		["Ranged(Light)(Ag)"] = {
				characteristic = "AG",
				description = "<p>Ranged weapons requiring one hand to wield or aim, including blaster pistols and small thrown weapons such as grenades, rely on this skill.</p>",
				advanced = 1,
			},
		["Gunnery"] = {
				characteristic = "AG",
				description = "<p>This skill covers heavy mounted weapons as well as starship weapons. These weapons are too heavy to carry.</p>",
				advanced = 1,
			}
	};

	forceanddestiny_skilldata = {
		["Lightsaber"] = {
				characteristic = "BR",
				description = "<p>Weapon Skill from Force and Destiny(tm).</p>",
				advanced = 1,
			}
	};

	ageofrebellion_skilldata = {
		["Warfare"] = {
				characteristic = "IN",
				description = "<p>Knowledge skill from Age of Rebellion(tm).</p>",
				knowledge = 1,
			}
	};

	critical_injury_result_data = {
		["Minor Nick"] = {
				d100_start = 1,
				d100_end = 5,
				name = "Minor Nick (1)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 1,
			},
		["Slowed Down"] = {
				d100_start = 6,
				d100_end = 10,
				name = "Slowed Down (1)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 1,
			},
		["Sudden Jolt"] = {
				d100_start = 11,
				d100_end = 15,
				name = "Sudden Jolt (1)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 1,
			},
		["Distracted"] = {
				d100_start = 16,
				d100_end = 20,
				name = "Distracted (1)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 1,
			},
		["Off-Balance"] = {
				d100_start = 21,
				d100_end = 25,
				name = "Off-Balance (1)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 1,
			},
		["Discouraging Wound"] = {
				d100_start = 26,
				d100_end = 30,
				name = "Discouraging Wound (1)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 1,
			},
		["Stunned"] = {
				d100_start = 31,
				d100_end = 35,
				name = "Stunned (1)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 1,
			},
		["Stinger"] = {
				d100_start = 36,
				d100_end = 40,
				name = "Stinger (1)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 1,
			},
		["Bowled Over"] = {
				d100_start = 41,
				d100_end = 45,
				name = "Bowled Over (2)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 2,
			},
		["Head Ringer"] = {
				d100_start = 46,
				d100_end = 50,
				name = "Head Ringer (2)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 2,
			},
		["Fearsome Wound"] = {
				d100_start = 51,
				d100_end = 55,
				name = "Fearsome Wound (2)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 2,
			},
		["Agonizing Wound"] = {
				d100_start = 56,
				d100_end = 60,
				name = "Agonizing Wound (2)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 2,
			},
		["Slightly Dazed"] = {
				d100_start = 61,
				d100_end = 65,
				name = "Slightly Dazed (2)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 2,
			},
		["Scattered Senses"] = {
				d100_start = 66,
				d100_end = 70,
				name = "Scattered Senses (2)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 2,
			},
		["Hamstrung"] = {
				d100_start = 71,
				d100_end = 75,
				name = "Hamstrung (2)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 2,
			},
		["Overpowered"] = {
				d100_start = 76,
				d100_end = 80,
				name = "Overpowered (2)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 2,
			},
		["Winded"] = {
				d100_start = 81,
				d100_end = 85,
				name = "Winded (2)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 2,
			},
		["Compromised"] = {
				d100_start = 86,
				d100_end = 90,
				name = "Compromised (2)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 2,
			},
		["At the Brink"] = {
				d100_start = 91,
				d100_end = 95,
				name = "At the Brink (3)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 3,
			},
		["Crippled"] = {
				d100_start = 96,
				d100_end = 100,
				name = "Crippled (3)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 3,
			},
		["Maimed"] = {
				d100_start = 101,
				d100_end = 105,
				name = "Maimed (3)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 3,
			},
		["Horrific Injury"] = {
				d100_start = 106,
				d100_end = 110,
				name = "Horrific Injury (3)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 3,
			},
		["Temporarily Lame"] = {
				d100_start = 111,
				d100_end = 115,
				name = "Temporarily Lame (3)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 3,
			},
		["Blinded"] = {
				d100_start = 116,
				d100_end = 120,
				name = "Blinded (3)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 3,
			},
		["Knocked Senseless"] = {
				d100_start = 121,
				d100_end = 125,
				name = "Knocked Senseless (3)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 3,
			},
		["Gruesome Injury"] = {
				d100_start = 126,
				d100_end = 130,
				name = "Gruesome Injury (4)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 4,
			},
		["Bleeding Out"] = {
				d100_start = 131,
				d100_end = 140,
				name = "Bleeding Out (4)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 4,
			},
		["The End is Nigh"] = {
				d100_start = 141,
				d100_end = 150,
				name = "The End is Nigh (4)",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 4,
			},
		["Dead"] = {
				d100_start = 151,
				d100_end = 9999,
				name = "Dead",
				description = "<p>See page 115 Genesys Core Rulebook.</p>",
				severity = 999,
			}
	};

	critical_vehicle_result_data = {
		["Mechanical Stress"] = {
				d100_start = 1,
				d100_end = 9,
				name = "Mechanical Stress (1)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 1,
			},
		["Jostled"] = {
				d100_start = 10,
				d100_end = 18,
				name = "Jostled (1)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 1,
			},
		["Losing Power to Shields"] = {
				d100_start = 19,
				d100_end = 27,
				name = "Losing Power to Shields (1)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 1,
			},
		["Knocked Off Course"] = {
				d100_start = 28,
				d100_end = 36,
				name = "Knocked Off Course (1)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 1,
			},
		["Tailspin"] = {
				d100_start = 37,
				d100_end = 45,
				name = "Tailspin (1)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 1,
			},
		["Component Hit"] = {
				d100_start = 46,
				d100_end = 54,
				name = "Component Hit (1)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 1,
			},
		["Failing"] = {
				d100_start = 55,
				d100_end = 63,
				name = "Shields Failing (2)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 2,
			},
		["Navicomputer Failure"] = {
				d100_start = 64,
				d100_end = 72,
				name = "Navicomputer Failure (2)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 2,
			},
		["Power Fluctuations"] = {
				d100_start = 73,
				d100_end = 81,
				name = "Power Fluctuations (2)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 2,
			},
		["Shields Down"] = {
				d100_start = 82,
				d100_end = 90,
				name = "Shields Down (3)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 3,
			},
		["Engine Damaged"] = {
				d100_start = 91,
				d100_end = 99,
				name = "Engine Damaged (3)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 3,
			},
		["Shield Overload"] = {
				d100_start = 100,
				d100_end = 108,
				name = "Shield Overload (3)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 3,
			},
		["Engines Down"] = {
				d100_start = 109,
				d100_end = 117,
				name = "Engines Down (3)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 3,
			},
		["Major System Failure"] = {
				d100_start = 118,
				d100_end = 126,
				name = "Major System Failure (3)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 3,
			},
		["Gruesome Injury"] = {
				d100_start = 127,
				d100_end = 133,
				name = "Major Hull Breach (4)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 4,
			},
		["Destabilized"] = {
				d100_start = 134,
				d100_end = 138,
				name = "Destabilized (4)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 4,
			},
		["Fire!"] = {
				d100_start = 139,
				d100_end = 144,
				name = "Fire! (4)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 4,
			},
		["Breaking Up"] = {
				d100_start = 145,
				d100_end = 153,
				name = "Breaking Up (4)",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 4,
			},
		["Vaporized"] = {
				d100_start = 154,
				d100_end = 9999,
				name = "Vaporized",
				description = "<p>See page 244 Edge of the Empire(tm) or page 258 Age of Rebellion(tm).</p>",
				severity = 999,
			}
	};

]]





--[[
-- Abilities (database names)
abilities = {
	"strength",
	"dexterity",
	"constitution",
	"intelligence",
	"wisdom",
	"charisma"
};

ability_ltos = {
	["strength"] = "STR",
	["dexterity"] = "DEX",
	["constitution"] = "CON",
	["intelligence"] = "IN",
	["wisdom"] = "WIS",
	["charisma"] = "CHA"
};

ability_stol = {
	["STR"] = "strength",
	["DEX"] = "dexterity",
	["CON"] = "constitution",
	["IN"] = "intelligence",
	["WIS"] = "wisdom",
	["CHA"] = "charisma"
};

-- Saves
save_ltos = {
	["fortitude"] = "FORT",
	["reflex"] = "REF",
	["WI"] = "WI"
};

save_stol = {
	["FORT"] = "fortitude",
	["REF"] = "reflex",
	["WI"] = "WI"
};

-- Values for wound comparison
healthstatusfull = "healthy";
healthstatushalf = "bloodied";
healthstatuswounded = "wounded";

-- Values for alignment comparison
alignment_lawchaos = {
	["lawful"] = 1,
	["chaotic"] = 3,
	["lg"] = 1,
	["ln"] = 1,
	["le"] = 1,
	["cg"] = 3,
	["cn"] = 3,
	["ce"] = 3,
};
alignment_goodevil = {
	["good"] = 1,
	["evil"] = 3,
	["lg"] = 1,
	["le"] = 3,
	["ng"] = 1,
	["ne"] = 3,
	["cg"] = 1,
	["ce"] = 3,
};
alignment_neutral = "n";

-- Values for size comparison
creaturesize = {
	["fine"] = -4,
	["diminutive"] = -3,
	["tiny"] = -2,
	["small"] = -1,
	["medium"] = 0,
	["large"] = 1,
	["huge"] = 2,
	["gargantuan"] = 3,
	["colossal"] = 4,
	["f"] = -4,
	["d"] = -3,
	["t"] = -2,
	["s"] = -1,
	["m"] = 0,
	["l"] = 1,
	["h"] = 2,
	["g"] = 3,
	["c"] = 4,
};

-- Values for creature type comparison
creaturedefaulttype = "humanoid";
creaturehalftype = "half-";
creaturehalftypesubrace = "human";
creaturetype = {
	"aberration",
	"animal",
	"construct",
	"dragon",
	"elemental",
	"fey",
	"giant",
	"humanoid",
	"magical beast",
	"monstrous humanoid",
	"ooze",
	"outsider",
	"plant",
	"undead",
	"vermin",
};
creaturesubtype = {
	"air", -- Monster subtypes
	"angel",
	"aquatic",
	"archon",
	"augmented",
	"chaotic",
	"cold",
	"demon",
	"devil",
	"earth",
	"evil",
	"extraplanar",
	"fire",
	"good",
	"incorporeal",
	"lawful",
	"living construct",
	"native",
	"psionic",
	"shapechanger",
	"swarm",
	"water",
	"aquatic", -- Humanoid subtypes
	"dwarf",
	"elf",
	"gnoll",
	"gnome",
	"goblinoid",
	"gnoll",
	"halfling",
	"human",
	"orc",
	"reptilian",
};

-- Values supported in effect conditionals
conditionaltags = {
};

-- Conditions supported in effect conditionals and for token widgets
-- NOTE: From rules, missing dying, staggered and disabled
conditions = {
	"blinded",
	"climbing",
	"confused",
	"cowering",
	"dazed",
	"dazzled",
	"deafened",
	"entangled",
	"exhausted",
	"fascinated",
	"fatigued",
	"flat-footed",
	"frightened",
	"grappled",
	"helpless",
	"incorporeal",
	"invisible",
	"kneeling",
	"nauseated",
	"panicked",
	"paralyzed",
	"petrified",
	"pinned",
	"prone",
	"rebuked",
	"running",
	"shaken",
	"sickened",
	"sitting",
	"slowed",
	"squeezing",
	"stable",
	"stunned",
	"turned",
	"unconscious"
};

-- Bonus/penalty effect types for token widgets
bonuscomps = {
	"INIT",
	"ABIL",
	"AC",
	"ATK",
	"CMB",
	"CMD",
	"DMG",
	"DMGS",
	"HEAL",
	"SAVE",
	"SKILL",
	"STR",
	"CON",
	"DEX",
	"IN",
	"WIS",
	"CHA",
	"FORT",
	"REF",
	"WI"
};

-- Condition effect types for token widgets
condcomps = {
	["blinded"] = "cond_blinded",
	["confused"] = "cond_confused",
	["cowering"] = "cond_frightened",
	["dazed"] = "cond_dazed",
	["dazzled"] = "cond_dazed",
	["deafened"] = "cond_deafened",
	["entangled"] = "cond_restrained",
	["exhausted"] = "cond_weakened",
	["fascinated"] = "cond_charmed",
	["fatigued"] = "cond_weakened",
	["flat-footed"] = "cond_surprised",
	["flatfooted"] = "cond_surprised",
	["frightened"] = "cond_frightened",
	["grappled"] = "cond_grappled",
	["helpless"] = "cond_helpless",
	["incorporeal"] = "cond_incorporeal",
	["invisible"] = "cond_invisible",
	["nauseated"] = "cond_sickened",
	["panicked"] = "cond_frightened",
	["paralyzed"] = "cond_paralyzed",
	["petrified"] = "cond_paralyzed",
	["pinned"] = "cond_pinned",
	["prone"] = "cond_prone",
	["rebuked"] = "cond_turned",
	["shaken"] = "cond_frightened",
	["sickened"] = "cond_sickened",
	["slowed"] = "cond_slowed",
	["stunned"] = "cond_stunned",
	["turned"] = "cond_turned",
	["unconscious"] = "cond_unconscious",
	-- Similar to conditions
	["ca"] = "cond_advantage",
	["grantca"] = "cond_disadvantage",
	["conc"] = "cond_conceal",
	["tconc"] = "cond_conceal",
	["cover"] = "cond_cover",
	["scover"] = "cond_cover",
};

-- Other visible effect types for token widgets
othercomps = {
	["CONC"] = "cond_conceal",
	["TCONC"] = "cond_conceal",
	["COVER"] = "cond_cover",
	["SCOVER"] = "cond_cover",
	["NLVL"] = "cond_penalty",
	["IMMUNE"] = "cond_immune",
	["RESIST"] = "cond_resistance",
	["VULN"] = "cond_vulnerable",
	["REGEN"] = "cond_regeneration",
	["FHEAL"] = "cond_regeneration",
	["DMGO"] = "cond_bleed",
};

-- Effect components which can be targeted
targetableeffectcomps = {
	"CONC",
	"TCONC",
	"COVER",
	"SCOVER",
	"AC",
	"CMD",
	"SAVE",
	"ATK",
	"CMB",
	"DMG",
	"IMMUNE",
	"VULN",
	"RESIST"
};

connectors = {
	"and",
	"or"
};

-- Range types supported
rangetypes = {
	"melee",
	"ranged"
};

-- Damage types supported
energytypes = {
	"acid",  		-- ENERGY DAMAGE TYPES
	"cold",
	"electricity",
	"fire",
	"sonic",
	"force",  		-- OTHER SPELL DAMAGE TYPES
	"positive",
	"negative"
};

immunetypes = {
	"acid",  		-- ENERGY DAMAGE TYPES
	"cold",
	"electricity",
	"fire",
	"sonic",
	"nonlethal",	-- SPECIAL DAMAGE TYPES
	"critical",
	"poison",		-- OTHER IMMUNITY TYPES
	"sleep",
	"paralysis",
	"petrification",
	"charm",
	"sleep",
	"fear",
	"disease",
	"mind-affecting",
};

dmgtypes = {
	"acid",  		-- ENERGY DAMAGE TYPES
	"cold",
	"electricity",
	"fire",
	"sonic",
	"force",  		-- OTHER SPELL DAMAGE TYPES
	"positive",
	"negative",
	"adamantine", 	-- WEAPON PROPERTY DAMAGE TYPES
	"bludgeoning",
	"cold iron",
	"epic",
	"Magic",
	"piercing",
	"silver",
	"slashing",
	"chaotic",		-- ALIGNMENT DAMAGE TYPES
	"evil",
	"good",
	"lawful",
	"nonlethal",	-- SPECIAL DAMAGE TYPES
	"spell",
	"critical",
	"precision",
};

basicdmgtypes = {
	"acid",  		-- ENERGY DAMAGE TYPES
	"cold",
	"electricity",
	"fire",
	"sonic",
	"force",  		-- OTHER SPELL DAMAGE TYPES
	"positive",
	"negative",
	"bludgeoning", 	-- WEAPON PROPERTY DAMAGE TYPES
	"piercing",
	"slashing",
};

specialdmgtypes = {
	"nonlethal",
	"spell",
	"critical",
	"precision",
};

-- Bonus types supported in power descriptions
bonustypes = {
	"alchemical",
	"armor",
	"circumstance",
	"competence",
	"deflection",
	"dodge",
	"enhancement",
	"insight",
	"luck",
	"morale",
	"natural",
	"profane",
	"racial",
	"resistance",
	"sacred",
	"shield",
	"size",
	"trait",
};

stackablebonustypes = {
	"circumstance",
	"dodge"
};

-- Armor class bonus types
-- (Map text types to internal types)
actypes = {
	["dex"] = "dex",
	["armor"] = "armor",
	["shield"] = "shield",
	["natural"] = "natural",
	["dodge"] = "dodge",
	["deflection"] = "deflection",
	["size"] = "size",
};
acarmormatch = {
	"padded",
	"padded armor",
	"padded barding",
	"leather",
	"leather armor",
	"leather barding",
	"studded leather",
	"studded leather armor",
	"studded leather barding",
	"chain shirt",
	"chain shirt barding",
	"hide",
	"hide armor",
	"hide barding",
	"scale mail",
	"scale mail barding",
	"chainmail",
	"chainmail barding",
	"breastplate",
	"breastplate barding",
	"splint mail",
	"splint mail barding",
	"banded mail",
	"banded mail barding",
	"half-plate",
	"half-plate armor",
	"half-plate barding",
	"full plate",
	"full plate armor",
	"full plate barding",
	"plate barding",
	"bracers of armor",
	"mithral chain shirt",
};
acshieldmatch = {
	"buckler",
	"light shield",
	"light wooden shield",
	"light steel shield",
	"heavy shield",
	"heavy wooden shield",
	"heavy steel shield",
	"tower shield",
};
acdeflectionmatch = {
	"ring of protection"
};

-- Spell effects supported in spell descriptions
spelleffects = {
	"blinded",
	"confused",
	"cowering",
	"dazed",
	"dazzled",
	"deafened",
	"entangled",
	"exhausted",
	"fascinated",
	"frightened",
	"helpless",
	"invisible",
	"panicked",
	"paralyzed",
	"shaken",
	"sickened",
	"slowed",
	"stunned",
	"unconscious"
};

-- NPC damage properties
weapondmgtypes = {
	["axe"] = "slashing",
	["battleaxe"] = "slashing",
	["bolas"] = "bludgeoning,nonlethal",
	["chain"] = "piercing",
	["club"] = "bludgeoning",
	["crossbow"] = "piercing",
	["dagger"] = "piercing,slashing",
	["dart"] = "piercing",
	["falchion"] = "slashing",
	["flail"] = "bludgeoning",
	["glaive"] = "slashing",
	["greataxe"] = "slashing",
	["greatclub"] = "bludgeoning",
	["greatsword"] = "slashing",
	["guisarme"] = "slashing",
	["halberd"] = "piercing,slashing",
	["hammer"] = "bludgeoning",
	["handaxe"] = "slashing",
	["javelin"] = "piercing",
	["kama"] = "slashing",
	["kukri"] = "slashing",
	["lance"] = "piercing",
	["longbow"] = "piercing",
	["longspear"] = "piercing",
	["longsword"] = "slashing",
	["mace"] = "bludgeoning",
	["morningstar"] = "bludgeoning,piercing",
	["nunchaku"] = "bludgeoning",
	["pick"] = "piercing",
	["quarterstaff"] = "bludgeoning",
	["ranseur"] = "piercing",
	["rapier"] = "piercing",
	["sai"] = "bludgeoning",
	["sap"] = "bludgeoning,nonlethal",
	["scimitar"] = "slashing",
	["scythe"] = "piercing,slashing",
	["shortbow"] = "piercing",
	["shortspear"] = "piercing",
	["shuriken"] = "piercing",
	["siangham"] = "piercing",
	["sickle"] = "slashing",
	["sling"] = "bludgeoning",
	["spear"] = "piercing",
	["sword"] = {["short"] = "piercing", ["*"] = "slashing"},
	["trident"] = "piercing",
	["urgrosh"] = "piercing,slashing",
	["waraxe"] = "slashing",
	["warhammer"] = "bludgeoning",
	["whip"] = "slashing"
}

naturaldmgtypes = {
	["arm"] = "bludgeoning",
	["bite"] = "piercing,slashing,bludgeoning",
	["butt"] = "bludgeoning",
	["claw"] =  "piercing,slashing",
	["foreclaw"] =  "piercing,slashing",
	["gore"] = "piercing",
	["hoof"] = "bludgeoning",
	["hoove"] = "bludgeoning",
	["horn"] = "piercing",
	["pincer"] = "bludgeoning",
	["quill"] = "piercing",
	["ram"] = "bludgeoning",
	["rock"] = "bludgeoning",
	["slam"] = "bludgeoning",
	["snake"] = "piercing,slashing,bludgeoning",
	["spike"] = "piercing",
	["stamp"] = "bludgeoning",
	["sting"] = "piercing",
	["swarm"] = "piercing,slashing,bludgeoning",
	["tail"] = "bludgeoning",
	["talon"] =  "piercing,slashing",
	["tendril"] = "bludgeoning",
	["tentacle"] = "bludgeoning",
	["wing"] = "bludgeoning",
}

-- Skill properties
sensesdata = {
	["Listen"] = {
			stat = "wisdom"
		},
	["Spot"] = {
			stat = "wisdom"
		},
}

skilldata = {
	["Appraise"] = {
			stat = "intelligence"
		},
	["Balance"] = {
			stat = "dexterity",
			armorcheckmultiplier = 1
		},
	["Bluff"] = {
			stat = "charisma"
		},
	["Climb"] = {
			stat = "strength",
			armorcheckmultiplier = 1
		},
	["Concentration"] = {
			stat = "constitution"
		},
	["Craft"] = {
			sublabeling = true,
			stat = "intelligence"
		},
	["Decipher Script"] = {
			stat = "intelligence",
			trainedonly = 1
		},
	["Diplomacy"] = {
			stat = "charisma"
		},
	["Disable Device"] = {
			stat = "intelligence",
			trainedonly = 1
		},
	["Disguise"] = {
			stat = "charisma"
		},
	["Escape Artist"] = {
			stat = "dexterity",
			armorcheckmultiplier = 1
		},
	["Forgery"] = {
			stat = "intelligence"
		},
	["Gather Information"] = {
			stat = "charisma"
		},
	["Handle Animal"] = {
			stat = "charisma",
			trainedonly = 1
		},
	["Heal"] = {
			stat = "wisdom"
		},
	["Hide"] = {
			stat = "dexterity",
			armorcheckmultiplier = 1
		},
	["Intimidate"] = {
			stat = "charisma"
		},
	["Jump"] = {
			stat = "strength",
			armorcheckmultiplier = 1
		},
	["Knowledge"] = {
			sublabeling = true,
			stat = "intelligence",
			trainedonly = 1
		},
	["Listen"] = {
			stat = "wisdom"
		},
	["Move Silently"] = {
			stat = "dexterity",
			armorcheckmultiplier = 1
		},
	["Open Lock"] = {
			stat = "dexterity",
			trainedonly = 1
		},
	["Perform"] = {
			sublabeling = true,
			stat = "charisma"
		},
	["Profession"] = {
			sublabeling = true,
			stat = "wisdom",
			trainedonly = 1
		},
	["Ride"] = {
			stat = "dexterity"
		},
	["Search"] = {
			stat = "intelligence"
		},
	["Sense Motive"] = {
			stat = "wisdom"
		},
	["Sleight of Hand"] = {
			stat = "dexterity",
			armorcheckmultiplier = 1,
			trainedonly = 1
		},
	["Speak Language"] = {
		},
	["Spellcraft"] = {
			stat = "intelligence",
			trainedonly = 1
		},
	["Spot"] = {
			stat = "wisdom"
		},
	["Survival"] = {
			stat = "wisdom"
		},
	["Swim"] = {
			stat = "strength",
			armorcheckmultiplier = 2
		},
	["Tumble"] = {
			stat = "dexterity",
			armorcheckmultiplier = 1,
			trainedonly = 1
		},
	["Use Magic Device"] = {
			stat = "charisma",
			trainedonly = 1
		},
	["Use Rope"] = {
			stat = "dexterity"
		}
}





-- Coin labels
currency = { "PP", "GP", "SP", "CP" };

-- Party sheet drop down list data
psabilitydata = {
	"Strength",
	"Dexterity",
	"Constitution",
	"Intelligence",
	"Wisdom",
	"Charisma"
};

pssavedata = {
	"Fortitude",
	"Reflex",
	"WI"
};

psskilldata = {
	"Bluff",
	"Climb",
	"Diplomacy",
	"Gather Information",
	"Heal",
	"Hide",
	"Jump",
	"Intimidate",
	"Knowledge (Arcana)",
	"Knowledge (Dungeoneering)",
	"Knowledge (Local)",
	"Knowledge (Nature)",
	"Knowledge (Planes)",
	"Knowledge (Religion)",
	"Listen",
	"Move Silently",
	"Search",
	"Spot",
	"Survival"
};

-- PC/NPC Class properties

class_stol = {
	["brb"] = "barbarian",
	["brd"] = "bard",
	["clr"] = "cleric",
	["drd"] = "druid",
	["ftr"] = "fighter",
	["mnk"] = "monk",
	["pal"] = "paladin",
	["rgr"] = "ranger",
	["rog"] = "rogue",
	["sor"] = "sorcerer",
	["wiz"] = "wizard",
};

classdata = {
	-- Core
	["barbarian"] = {
		hd = "d12", bab = "fast", fort = "good", ref = "bad", will = "bad", skillranks = 4,
		skills = "Climb (Str), Craft, Handle Animal (Cha), Intimidate (Cha), Jump (Str), Listen (Wis), Ride (Dex), Survival (Wis), and Swim (Str)",
	},
	["bard"] = {
		hd = "d6", bab = "medium", fort = "bad", ref = "good", will = "good", skillranks = 6,
		skills = "Appraise, Balance (Dex), Bluff (Cha), Climb (Str), Concentration (Con), Craft, Decipher Script, Diplomacy (Cha), Disguise (Cha), Escape Artist (Dex), Gather Information (Cha), Hide (Dex), Jump (Str), Knowledge (all skills, taken individually), Listen (Wis), Move Silently (Dex), Perform (Cha), Profession (Wis), Sense Motive (Wis), Sleight of Hand (Dex), Speak Language (None), Spellcraft, Swim (Str), Tumble (Dex), and Use Magic Device (Cha)",
	},
	["cleric"] = {
		hd = "d8", bab = "medium", fort = "good", ref = "bad", will = "good", skillranks = 2,
		skills = " Concentration (Con), Craft, Diplomacy (Cha), Heal (Wis), Knowledge (arcana), Knowledge (history), Knowledge (religion), Knowledge (the planes), Profession (Wis), and Spellcraft",
	},
	["druid"] = {
		hd = "d8", bab = "medium", fort = "good", ref = "bad", will = "good", skillranks = 4,
		skills = "Concentration (Con), Craft, Diplomacy (Cha), Handle Animal (Cha), Heal (Wis), Knowledge (nature), Listen (Wis), Profession (Wis), Ride (Dex), Spellcraft, Spot (Wis), Survival (Wis), and Swim (Str)",
	},
	["fighter"] = {
		hd = "d10", bab = "fast", fort = "good", ref = "bad", will = "bad", skillranks = 2,
		skills = "Climb (Str), Craft, Handle Animal (Cha), Intimidate (Cha), Jump (Str), Ride (Dex), and Swim (Str)",
	},
	["monk"] = {
		hd = "d8", bab = "medium", fort = "good", ref = "good", will = "good", skillranks = 4,
		skills = "Balance (Dex), Climb (Str), Concentration (Con), Craft, Diplomacy (Cha), Escape Artist (Dex), Hide (Dex), Jump (Str), Knowledge (arcana), Knowledge (religion), Listen (Wis), Move Silently (Dex), Perform (Cha), Profession (Wis), Sense Motive (Wis), Spot (Wis), Swim (Str), and Tumble (Dex)",
	},
	["paladin"] = {
		hd = "d10", bab = "fast", fort = "good", ref = "bad", will = "bad", skillranks = 2,
		skills = "Concentration (Con), Craft, Diplomacy (Cha), Handle Animal (Cha), Heal (Wis), Knowledge (nobility and royalty), Knowledge (religion), Profession (Wis), Ride (Dex), and Sense Motive (Wis)",
	},
	["ranger"] = {
		hd = "d8", bab = "fast", fort = "good", ref = "good", will = "bad", skillranks = 6,
		skills = "Climb (Str), Concentration (Con), Craft, Handle Animal (Cha), Heal (Wis), Hide (Dex), Jump (Str), Knowledge (dungeoneering), Knowledge (geography), Knowledge (nature), Listen (Wis), Move Silently (Dex), Profession (Wis), Ride (Dex), Search, Spot (Wis), Survival (Wis), Swim (Str), and Use Rope (Dex)",
	},
	["rogue"] = {
		hd = "d6", bab = "medium", fort = "bad", ref = "good", will = "bad", skillranks = 8,
		skills = "Appraise, Balance (Dex), Bluff (Cha), Climb (Str), Craft, Decipher Script, Diplomacy (Cha), Disable Device, Disguise (Cha), Escape Artist (Dex), Forgery, Gather Information (Cha), Hide (Dex), Intimidate (Cha), Jump (Str), Knowledge (local), Listen (Wis), Move Silently (Dex), Open Lock (Dex), Perform (Cha), Profession (Wis), Search, Sense Motive (Wis), Sleight of Hand (Dex), Spot (Wis), Swim (Str), Tumble (Dex), Use Magic Device (Cha), and Use Rope (Dex)",
	},
	["sorcerer"] = {
		hd = "d4", bab = "slow", fort = "bad", ref = "bad", will = "good", skillranks = 2,
		skills = "Bluff (Cha), Concentration (Con), Craft, Knowledge (arcana), Profession (Wis), and Spellcraft",
	},
	["wizard"] = {
		hd = "d4", bab = "slow", fort = "bad", ref = "bad", will = "good", skillranks = 2,
		skills = "Concentration (Con), Craft, Decipher Script, Knowledge (all skills, taken individually), Profession (Wis), and Spellcraft",
	},
	-- NPC
	["adept"] = {
		hd = "d6", bab = "slow", fort = "bad", ref = "bad", will = "good", skillranks = 2,
		skills = "Concentration (Con), Craft, Handle Animal (Cha), Heal (Wis), Knowledge (all skills taken individually), Profession (Wis), Spellcraft, and Survival (Wis)",
	},
	["aristocrat"] = {
		hd = "d8", bab = "medium", fort = "bad", ref = "bad", will = "good", skillranks = 4,
		skills = "Appraise, Bluff (Cha), Diplomacy (Cha), Disguise (Cha), Forgery, Gather Information (Cha), Handle Animal (Cha), Intimidate (Cha), Knowledge (all skills taken individually), Listen (Wis), Perform (Cha), Ride (Dex), Sense Motive (Wis), Speak Language (None), Spot (Wis), Swim (Str), and Survival (Wis)",
	},
	["commoner"] = {
		hd = "d4", bab = "slow", fort = "bad", ref = "bad", will = "bad", skillranks = 2,
		skills = "Climb (Str), Craft, Handle Animal (Cha), Jump (Str), Listen (Wis), Profession (Wis), Ride (Dex), Spot (Wis), Swim (Str), and Use Rope (Dex)",
	},
	["expert"] = {
		hd = "d6", bab = "medium", fort = "bad", ref = "bad", will = "good", skillranks = 6,
		skills = "Any 10",
	},
	["warrior"] = {
		hd = "d8", bab = "fast", fort = "good", ref = "bad", will = "bad", skillranks = 2,
		skills = "Climb (Str), Handle Animal (Cha), Intimidate (Cha), Jump (Str), Ride (Dex), and Swim (Str)",
	},
	-- Prestige
	["arcane archer"] = {
		bPrestige = true, hd = "d8", bab = "fast", fort = "good", ref = "good", will = "bad", skillranks = 4,
		skills = "Craft, Hide (Dex). Listen (Wis), Move Silently (Dex), Ride (Dex), Spot (Wis), Survival (Wis), and Use Rope (Dex)",
	},
	["arcane trickster"] = {
		bPrestige = true, hd = "d4", bab = "slow", fort = "bad", ref = "good", will = "good", skillranks = 4,
		skills = "Appraise, Balance (Dex), Bluff (Cha), Climb (Str), Concentration (Con), Craft, Decipher Script, Diplomacy (Cha), Disable Device, Disguise (Cha), Escape Artist (Dex), Gather Information (Cha), Hide (Dex), Jump (Str), Knowledge (all skills taken individually), Listen (Wis), Move Silently (Dex), Open Lock (Dex), Profession (Wis), Search, Sense Motive (Wis), Sleight of Hand (Dex), Speak Language (None), Spellcraft, Spot (Wis), Swim (Str), Tumble (Dex), and Use Rope (Dex)",
	},
	["archmage"] = {
		bPrestige = true, hd = "d4", bab = "slow", fort = "bad", ref = "bad", will = "good", skillranks = 2,
		skills = "Concentration (Con), Craft (alchemy), Knowledge (all skills taken individually), Profession (Wis), Search, and Spellcraft",
	},
	["assassin"] = {
		bPrestige = true, hd = "d6", bab = "medium", fort = "bad", ref = "good", will = "bad", skillranks = 4,
		skills = "Balance (Dex), Bluff (Cha), Climb (Str), Craft, Decipher Script, Diplomacy (Cha), Disable Device, Disguise (Cha), Escape Artist (Dex), Forgery, Gather Information (Cha), Hide (Dex), Intimidate (Cha), Jump (Str), Listen (Wis), Move Silently (Dex), Open Lock (Dex), Search, Sense Motive (Wis), Sleight of Hand (Dex), Spot (Wis), Swim (Str), Tumble (Dex), Use Magic Device (Cha), and Use Rope (Dex)",
	},
	["blackguard"] = {
		bPrestige = true, hd = "d10", bab = "fast", fort = "good", ref = "bad", will = "bad", skillranks = 2,
		skills = "Concentration (Con), Craft, Diplomacy (Cha), Handle Animal (Cha), Heal (Wis), Hide (Dex), Intimidate (Cha), Knowledge (religion), Profession (Wis), and Ride (Dex)",
	},
	["dragon disciple"] = {
		bPrestige = true, hd = "d12", bab = "medium", fort = "good", ref = "bad", will = "good", skillranks = 2,
		skills = "Concentration (Con), Craft, Diplomacy (Cha), Escape Artist (Dex), Gather Information (Cha), Knowledge (all skills, taken individually), Listen (Wis), Profession (Wis), Search, Speak Language (None), Spellcraft, and Spot (Wis)",
	},
	["duelist"] = {
		bPrestige = true, hd = "d10", bab = "fast", fort = "bad", ref = "good", will = "bad", skillranks = 4,
		skills = "Balance (Dex), Bluff (Cha), Escape Artist (Dex), Jump (Str), Listen (Wis), Perform (Cha), Sense Motive (Wis), Spot (Wis), and Tumble (Dex)",
	},
	["dwarven defender"] = {
		bPrestige = true, hd = "d12", bab = "fast", fort = "good", ref = "bad", will = "good", skillranks = 2,
		skills = "Craft, Listen (Wis), Sense Motive (Wis), and Spot (Wis)",
	},
	["eldritch knight"] = {
		bPrestige = true, hd = "d6", bab = "fast", fort = "good", ref = "bad", will = "bad", skillranks = 2,
		skills = "Concentration (Con), Craft, Decipher Script, Jump (Str), Knowledge (arcana), Knowledge (nobility and royalty), Ride (Dex), Sense Motive (Wis), Spellcraft, and Swim (Str)",
	},
	["hierophant"] = {
		bPrestige = true, hd = "d8", bab = "slow", fort = "good", ref = "bad", will = "good", skillranks = 2,
		skills = "Concentration (Con), Craft, Diplomacy (Cha), Heal (Wis), Knowledge (arcana), Knowledge (religion), Profession (Wis), and Spellcraft",
	},
	["horizon walker"] = {
		bPrestige = true, hd = "d8", bab = "fast", fort = "good", ref = "bad", will = "bad", skillranks = 4,
		skills = "Balance (Dex), Climb (Str), Diplomacy (Cha), Handle Animal (Cha), Hide (Dex), Knowledge (geography), Listen (Wis), Move Silently (Dex), Profession (Wis), Ride (Dex), Speak Language (None), Spot (Wis), and Survival (Wis)",
	},
	["loremaster"] = {
		bPrestige = true, hd = "d4", bab = "slow", fort = "bad", ref = "bad", will = "good", skillranks = 4,
		skills = "Appraise, Concentration (Con), Craft (alchemy), Decipher Script, Gather Information (Cha), Handle Animal (Cha), Heal (Wis), Knowledge (all skills taken individually), Perform (Cha), Profession (Wis), Speak Language (None), Spellcraft, and Use Magic Device (Cha)",
	},
	["mystic theurge"] = {
		bPrestige = true, hd = "d4", bab = "slow", fort = "bad", ref = "bad", will = "good", skillranks = 2,
		skills = "Concentration (Con), Craft, Decipher Script, Knowledge (arcana), Knowledge (religion), Profession (Wis), Sense Motive (Wis), and Spellcraft",
	},
	["shadowdancer"] = {
		bPrestige = true, hd = "d8", bab = "medium", fort = "bad", ref = "good", will = "bad", skillranks = 6,
		skills = "Balance (Dex), Bluff (Cha), Decipher Script, Diplomacy (Cha), Disguise (Cha), Escape Artist (Dex), Hide (Dex), Jump (Str), Listen (Wis), Move Silently (Dex), Perform (Cha), Profession (Wis), Search, Sleight of Hand (Dex), Spot (Wis), Tumble (Dex), and Use Rope (Dex)",
	},
	["thaumaturgist"] = {
		bPrestige = true, hd = "d4", bab = "slow", fort = "bad", ref = "bad", will = "good", skillranks = 2,
		skills = "Concentration (Con), Craft, Diplomacy (Cha), Knowledge (religion), Knowledge (the planes), Profession (Wis), Sense Motive (Wis), Speak Language (None), and Spellcraft",
	},
};
]]

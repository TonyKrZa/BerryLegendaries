return {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
			j_blurb_tony = {
				name = 'Tony',
				text = {
					'Create a {C:dark_edition}Negative {C:spectral}Spectral{} if',
					'played hand contains a',
					'{C:attention}Foil{} and an {C:attention}Ace{}'
				}
			},
			j_blurb_stick = {
				name = 'Stick',
				text = {
					'If played hand contains a {C:attention}Straight{},',
					'scored cards gain a random {C:attention}enhancement{}',
					'and this joker gains {X:mult,C:white}X#2#{} Mult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
					'{C:inactive}#3#{}'
				}
			},
			j_blurb_nyala = {
		        name = 'Nyala',
				text = {
					'Played hands turn their respective',
					'held {C:planet}Planets{} into {C:enhanced}Black Holes{}',
					'{X:mult,C:white}X#2#{} Mult for every {C:enhanced}Black Hole{} used',
					'{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
				}
			},
			j_blurb_bread = {
				name = 'b re ad',
				text = {
					'Each {C:attention}drawn card{} has a',
					'{C:green}#1# in #2#{} chance to permanently',
					'{C:attention}double{} its chip value'
				}
			},
			j_blurb_qui = {
				name = 'Qui',
				text = {
					'Each {C:attention}scoring seal card{} creates',
					'a random {C:attention}seal{} card, get {C:money}#1#${}',
					'for every {C:diamonds}Diamond{} drawn'
				}
			},
			j_blurb_fumi = {
				name = 'Fumi',
				text = {
					'This joker will {C:attention}always{} be {C:dark_edition}Negative{}',
					'Gives a {C:dark_edition}Negative{} {C:tarot}Tarot{}',
					'corresponding to the {C:attention}sum of ranks{} scored',
					'{C:inactive}(Aces count as 1 or 11, no-rank cards count as 0){}'
				}
			},
			j_blurb_zohn_00 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'

				},{
					'{C:green}#1# in #2#{} chance to {X:mult,C:white}X#5#{} Mult{} or {X:chips,C:white}X#5#{} Chips{} or {X:mult,C:white}X#6#{} Mult{} or {X:chips,C:white}X#6#{} Chips{}',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn to Polychrome/Holographic/Foil or Negative/Eternal sticker)'
				}},
            },
            j_blurb_zohn_0 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'

				},{
					'{C:inactive,s:0.7}(Previous: #1# in #2# chance to turn all Jokers in hand to this Joker, or permanently add +#8# Chips to all cards in hand)',
					'{C:green}#1# in #2#{} chance to {X:mult,C:white}X#5#{} Mult{} or {X:chips,C:white}X#5#{} Chips{} or {X:mult,C:white}X#6#{} Mult{} or {X:chips,C:white}X#6#{} Chips{}',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn to Polychrome/Holographic/Foil or Negative/Eternal sticker)'
				}},
            },
			j_blurb_zohn_1 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'

				},{
					'{C:inactive,s:0.7}(Previous: #1# in #2# chance to X#5# Mult or X#5# Chips or X#6# Mult or X#6# Chips)',
					'{C:green}#1# in #2#{} chance to turn to {C:attention}Polychrome{}/{C:attention}Holographic{}/{C:attention}Foil{} or {C:dark_edition}Negative{}/{C:tarot}Eternal{} sticker',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn all cards in hand to Steel or Gold)'
				}},
            },
			j_blurb_zohn_2 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'

				},{
					'{C:inactive,s:0.7}(Previous: #1# in #2# chance to turn to Polychrome/Holographic/Foil or Negative/Eternal sticker)',
					'{C:green}#1# in #2#{} chance to turn {C:attention}all cards in hand{} to {C:attention}Steel{} or {C:attention}Gold{}',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn all cards to Aces or 2s)'
				}},
            },
			j_blurb_zohn_3 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'

				},{
					'{C:inactive,s:0.7}(Previous: #1# in #2# chance to turn all cards in hand to Steel or Gold)',
					'{C:green}#1# in #2#{} chance to turn {C:attention}all cards{} to {C:attention}Aces{} or {C:attention}2s{}',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to duplicate all Negative Jokers or Non-Negative Edition Jokers)'
				}},
            },
			j_blurb_zohn_4 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'

				},{
					'{C:inactive,s:0.7}(Previous: #1# in #2# chance to turn all cards to Aces or 2s)',
					'{C:green}#1# in #2#{} chance to {C:attention}duplicate{} all {C:dark_edition}Negative{} Jokers or Non-{C:dark_edition}Negative{} Edition Jokers',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn all cards in shop to Negative Edition Jokers or Polychrome 2s)'
				}},
            },
			j_blurb_zohn_5 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'

				},{
					'{C:inactive,s:0.7}(Previous: #1# in #2# chance to duplicate all Negative Jokers or Non-Negative Edition Jokers)',
					'{C:green}#1# in #2#{} chance to turn {C:attention}all cards in shop{} to {C:dark_edition}Negative{} Edition Jokers or {C:attention}Polychrome 2s{}',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to set Ante to 1 or turn the next Boss Blind into The Wall)',
				}},
            },
			j_blurb_zohn_6 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'

				},{
					'{C:inactive,s:0.7}(Previous: #1# in #2# chance to turn all cards in shop to Negative Edition Jokers or Polychrome 2s)',
					'{C:green}#1# in #2#{} chance to {C:attention}set Ante{} to {C:attention}1{} or turn the next {C:attention}Boss Blind{} into {C:attention}The Wall{}',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to immediately lose the game or play Never Gonna Give You Up)'
				}},
            },
			j_blurb_zohn_7 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'

				},{
					'{C:inactive,s:0.7}(Previous: #1# in #2# chance to set Ante to 1 or turn the next Boss Blind into The Wall)',
					'{C:green}#1# in #2#{} chance to {C:red,E:2}immediately lose the game{} or play {C:attention}Never Gonna Give You Up{}',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to replace all sound effects to Travis Scott falling off stage in London or ^#7# Mult)'
				}},
            },
			j_blurb_zohn_8 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'

				},{
					'{C:inactive,s:0.7}(Previous: #1# in #2# chance to immediately lose the game or play Never Gonna Give You Up)',
					'{C:green}#1# in #2#{} chance to replace all sound effects to {C:attention}Travis Scott falling off stage in London{} or {X:dark_edition,C:white}^#7#{} Mult{}',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn all Jokers in hand to this Joker, or permanently add +#8# Chips to all cards in hand)',
				}},
            },
			j_blurb_zohn_9 = {
                name = 'Zohnathan',
                text = {{
					'{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
					'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
					-- '{C:green}#1# in #2#{} chance to {X:mult,C:white}X#5#{} Mult{} or {X:chips,C:white}X#5#{} Chips{} or {X:mult,C:white}X#6#{} Mult{} or {X:chips,C:white}X#6#{} Chips{}',
					-- '{C:green}#1# in #2#{} chance to turn to {C:attention}Polychrome{}/{C:attention}Holographic{}/{C:attention}Foil{} or {C:dark_edition}Negative{}/{C:tarot}Eternal{} sticker',
					-- '{C:green}#1# in #2#{} chance to turn {C:attention}all cards in hand{} to {C:attention}Steel{} or {C:attention}Gold{}',
					-- '{C:green}#1# in #2#{} chance to turn {C:attention}all cards{} to {C:attention}Aces{} or {C:attention}2s{}',
					-- '{C:green}#1# in #2#{} chance to {C:attention}duplicate{} all {C:dark_edition}Negative{} Jokers or Non-{C:dark_edition}Negative{} Edition Jokers',
					
					-- '{C:green}#1# in #2#{} chance to turn {C:attention}all cards in shop{} to {C:dark_edition}Negative{} Edition Jokers or {C:attention}Polychrome 2s{}',
					-- '{C:green}#1# in #2#{} chance to {C:attention}set Ante{} to {C:attention}1{} or turn the next {C:attention}Boss Blind{} into {C:attention}The Wall{}',
					-- '{C:green}#1# in #2#{} chance to {C:red,E:2}immediately lose the game{} or play {C:attention}Never Gonna Give You Up{}',
					-- '{C:green}#1# in #2#{} chance to replace all sound effects to {C:attention}Travis Scott falling off stage in London{} or {X:dark_edition,C:white}^#7#{} Mult{}',
					-- '{C:green}#1# in #2#{} chance to turn {C:attention}all Jokers in hand{} to this Joker, or permanently add {C:chips}+#8#{} Chips to all cards {C:attention}in hand{}',
					'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
					'{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'
				},{
					'{C:inactive,s:0.7}(Previous: #1# in #2# chance to replace all sound effects to Travis Scott falling off stage in London or ^#7# Mult)',
					'{C:green}#1# in #2#{} chance to turn {C:attention}all Jokers in hand{} to this Joker, or permanently add {C:chips}+#8#{} Chips to all cards {C:attention}in hand{}',
					'{C:inactive,s:0.7}(Next: #1# in #2# chance to X#5# Mult or X#5# Chips or X#6# Mult or X#6# Chips)',
				}},
            },
        },
    },
}
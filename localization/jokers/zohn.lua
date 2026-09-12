local loc_table = {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
            j_blurb_zohn = {
                name = 'Zohnathan',
                text = {
                    '{C:chips}+#3#{} Chips, {X:mult,C:white}X#4#{} Mult{}',
                    'If scoring hand contains an {C:attention}Ace{} or a {C:attention}2{}, {C:attention}trigger{} this Joker',
                    'Add {C:attention}trigger count{} to {X:mult,C:white}XMult{}',
                    '{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} Mult)(Currently {X:mult,C:white}#9#{C:inactive} Triggers)'
                },
            },
        },
    },
}

loc_table.misc = {v_dictionary = {
	zohn = {
		'{C:green}#1# in #2#{} chance to {X:mult,C:white}X#5#{} Mult{} or {X:chips,C:white}X#5#{} Chips{} or {X:mult,C:white}X#6#{} Mult{} or {X:chips,C:white}X#6#{} Chips{}',
		'{C:green}#1# in #2#{} chance to turn to {C:attention}Polychrome{}/{C:attention}Holographic{}/{C:attention}Foil{} or {C:dark_edition}Negative{}/{C:tarot}Eternal{} sticker',
		'{C:green}#1# in #2#{} chance to turn {C:attention}all cards in hand{} to {C:attention}Steel{} or {C:attention}Gold{}',
		'{C:green}#1# in #2#{} chance to turn {C:attention}all cards in hand{} to {C:attention}Aces{} or {C:attention}2s{}',
		'{C:green}#1# in #2#{} chance to {C:attention}duplicate{} all {C:dark_edition}Negative{} Jokers or Non-{C:dark_edition}Negative{} Edition Jokers',
		'{C:green}#1# in #2#{} chance to turn {C:attention}all cards in shop{} to {C:dark_edition}Negative{} Edition Jokers or {C:attention}Polychrome 2s{}',
		'{C:green}#1# in #2#{} chance to {C:attention}set Ante{} to {C:attention}1{} or turn the next {C:attention}Boss Blind{} into {C:attention}The Wall{}',
		'{C:green}#1# in #2#{} chance to {C:red,E:2}immediately lose the game{} or play {C:attention}Never Gonna Give You Up{}',
		'{C:green}#1# in #2#{} chance to replace all sound effects to {C:attention}Travis Scott falling off stage in London{} or {X:dark_edition,C:white}^#7#{} Mult{}',
		'{C:green}#1# in #2#{} chance to turn {C:attention}all Jokers in hand{} to this Joker, or permanently add {C:chips}+#8#{} Chips to all cards {C:attention}in hand{}',
	},
	zohn_prev = {
		'{C:inactive,s:0.7}(Previous: #1# in #2# chance to turn all Jokers in hand to this Joker, or permanently add +#8# Chips to all cards in hand)',
		'{C:inactive,s:0.7}(Previous: #1# in #2# chance to X#5# Mult or X#5# Chips or X#6# Mult or X#6# Chips)',
		'{C:inactive,s:0.7}(Previous: #1# in #2# chance to turn to Polychrome/Holographic/Foil or Negative/Eternal sticker)',
		'{C:inactive,s:0.7}(Previous: #1# in #2# chance to turn all cards in hand to Steel or Gold)',
		'{C:inactive,s:0.7}(Previous: #1# in #2# chance to turn all cards in hand to Aces or 2s)',
		'{C:inactive,s:0.7}(Previous: #1# in #2# chance to duplicate all Negative Jokers or Non-Negative Edition Jokers)',
		'{C:inactive,s:0.7}(Previous: #1# in #2# chance to turn all cards in shop to Negative Edition Jokers or Polychrome 2s)',
		'{C:inactive,s:0.7}(Previous: #1# in #2# chance to set Ante to 1 or turn the next Boss Blind into The Wall)',
		'{C:inactive,s:0.7}(Previous: #1# in #2# chance to immediately lose the game or play Never Gonna Give You Up)',
		'{C:inactive,s:0.7}(Previous: #1# in #2# chance to replace all sound effects to Travis Scott falling off stage in London or ^#7# Mult)',
	},
	zohn_next = {
		'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn to Polychrome/Holographic/Foil or Negative/Eternal sticker)',
		'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn all cards in hand to Steel or Gold)',
		'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn all cards in hand to Aces or 2s)',
		'{C:inactive,s:0.7}(Next: #1# in #2# chance to duplicate all Negative Jokers or Non-Negative Edition Jokers)',
		'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn all cards in shop to Negative Edition Jokers or Polychrome 2s)',
		'{C:inactive,s:0.7}(Next: #1# in #2# chance to set Ante to 1 or turn the next Boss Blind into The Wall)',
		'{C:inactive,s:0.7}(Next: #1# in #2# chance to immediately lose the game or play Never Gonna Give You Up)',
		'{C:inactive,s:0.7}(Next: #1# in #2# chance to replace all sound effects to Travis Scott falling off stage in London or ^#7# Mult)',
		'{C:inactive,s:0.7}(Next: #1# in #2# chance to turn all Jokers in hand to this Joker, or permanently add +#8# Chips to all cards in hand)',
		'{C:inactive,s:0.7}(Next: #1# in #2# chance to X#5# Mult or X#5# Chips or X#6# Mult or X#6# Chips)',
	}
}}

return loc_table
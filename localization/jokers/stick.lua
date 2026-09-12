local loc_table = {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
            j_blurb_stick = {
                name = 'Stick',
                text = {
                    'If played hand contains a {C:attention}Straight{},',
                    'scored cards gain a random {C:attention}enhancement{}',
                    'and this joker gains {X:mult,C:white}X#2#{} Mult{}',
                    '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
                    -- '{C:inactive}#3#{}'
                }
        }},
    },
}

return loc_table
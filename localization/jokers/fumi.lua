local loc_table = {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
            j_blurb_fumi = {
                name = 'Fumi',
                text = {
                    'This joker will {C:attention}always{} be {C:dark_edition}Negative{}',
                    'Gives a {C:dark_edition}Negative{}{C:attention}#1#{} {C:tarot}Tarot{}',
                    'corresponding to the {C:attention}sum of ranks{} scored',
                    '{C:inactive}(Aces count as 1 or 11, no-rank cards count as 0){}',
                    '{C:inactive}(Sum of ranks wrap around)'
                }
        }},
    },
}

return loc_table
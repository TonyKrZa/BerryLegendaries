local loc_table = {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
            j_blurb_qui = {
                name = 'Qui',
                text = {
                    -- 'Each {C:attention}scoring seal card{} creates',
                    -- 'a random {C:attention}seal{} card',
                    -- 'Get {C:money}#1#${} for every {C:diamonds}Diamond{} drawn'
                    'Scoring seals {C:attention}adds seals{}',
                    'to {C:attention}playing cards{} in hand',
                    'Get {C:money}$#1#{} for every {C:diamonds}Diamond{} drawn'
                }
        }},
    },
}

return loc_table
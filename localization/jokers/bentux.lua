local loc_table = {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
            j_blurb_bentux = {
                name = {
                    'Bentux',
                    -- '{s:0.7,C:edition}May the impossible become mundane.'
                },
                text = {
                    '{V:1}#1#{} Jokers and {V:2}#2#{} Jokers',
                    '{C:attention}swap rarities{}',
                    '{C:inactive}(Prices are retained){}',
                },
                flavour = {
                    '{s:0.7,C:inactive}May the impossible become mundane.'
                }
        }},
    },
    misc = {
        dictionary = {
            k_bentux_flipped = "Berry's Commons"
        }
    }
}

return loc_table
local loc_table = {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
            j_blurb_hanya = {
                name = 'Hanya',
                text = {
                    'Played unmodified cards become {C:attention}white{}',
                    'Gain {C:mult}+#1#{} Mult per {C:attention}frames per second{}',
                    '{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult){}'
                }
        }},
    },
}

return loc_table
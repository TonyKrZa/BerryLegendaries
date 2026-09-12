local loc_table = {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
            j_blurb_ado = {
                name = '{V:2}A{V:3}d{V:4}o',
                text = {{
                    'This Joker {C:attention}changes effects{}',
                    'based on one of four colors:',
                    '({C:red}Red{}, {C:blue}Blue{}, {C:purple}Purple{}, and {C:gold}Yellow{})',
                    '{C:inactive}(Color changes every round){}',
                    -- 'Current color: {V:1}#1#{}',
                },{
                    -- '{C:red}Red{}: Retriggers {C:hearts}Heart{} {C:attention}cards{} based on {C:attention}scored{} {C:hearts}Hearts{}',
                    -- 'If no {C:hearts}Hearts{} are scored, set Mult to {C:mult}0{}',
                    -- '{C:blue}Blue{}: {X:chips,C:white}x1.5{} Chips whenever you gain Chips from {C:attention}other Jokers{}',
                    -- '{C:attention}+1{} Ante if no {C:attention}Jokers{} give you Chips',
                    -- '{C:purple}Purple{}: {C:red}Destroyed{} cards give {X:mult,C:white}x5{} Mult',
                    -- '{C:inactive}(Currently {X:mult,C:white}x#2#{}{C:inactive} Mult){}',
                    -- '{C:gold}Yellow{}: Doubles all {C:money}money{} gained at end of round',
                    -- 'if played hand contains {C:attention}scoring{} {C:diamonds}Diamonds{}', 
                    -- 'Lose all {C:attention}interest{} if played hand contains {C:attention}scoring{} {C:hearts}Hearts{}'
                }}
        }},
        Other = {
            blurb_ado_red = {
                name = '#1#Red',
                text = {
                    'Retriggers {C:hearts}Heart{} {C:attention}cards{} for every',
                    '{C:attention}scored{} {C:hearts}Heart{} card',
                    'If no {C:hearts}Hearts{} are scored, set Mult to {C:mult}0{}'
                }
            },
            blurb_ado_blue = {
                name = '#1#Blue',
                text = {
                    'Gain {X:chips,C:white}x1.5{} Chips when',
                    '{C:attention}another Joker{} gains Chips',
                    '{C:attention}+1{} Ante if no {C:attention}Jokers{} give Chips',
                }
            },
            blurb_ado_purple = {
                name = '#1#Purple',
                text = {
                    '{C:red}Destroyed{} cards give {X:mult,C:white}x5{} Mult',
                    '{C:inactive}(Currently {X:mult,C:white}x#2#{}{C:inactive} Mult){}',
                }
            },
            blurb_ado_yellow = {
                name = '#1#Yellow',
                text = {
                    'Doubles all {C:money}money{} gained at end of round if',
                    'played hand contains {C:attention}scoring{} {C:diamonds}Diamonds{}', 
                    'Lose all {C:attention}interest{} if',
                    'played hand contains {C:attention}scoring{} {C:hearts}Hearts{}'
                }
            },
        }
    },
}

return loc_table
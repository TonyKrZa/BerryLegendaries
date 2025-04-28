----------------------------------------------
------------MOD CODE -------------------------

-- I am so sorry for anyoone who has to look through this. Especially me in the future! 

function addEventForAll(cards,dely,func)
	for i,v in ipairs(cards) do
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = dely,func = func(i,v)}))
	end
end

SMODS.Atlas{
    key = 'Jokers',
    path = 'jokers.png',
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'tony',
    loc_txt = {
        name = 'Tony',
        text = {
            'Create a {C:dark_edition}Negative {C:spectral}Spectral{} if',
            'played hand contains a',
            '{C:attention}Foil{} and an {C:attention}Ace{}'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
    end,
    calculate = function(self, card, context)
        if context.cardarea ~= G.jokers or not context.before then return end
        local hasAce = false
        local hasFoiled = false

        for i, v in pairs(context.full_hand) do
            if v:get_id() == 14 then hasAce = true end
        if v.edition and v.edition.key == "e_foil" then hasFoiled = true end
        if hasAce and hasFoiled then break end
        end

        if not hasAce or not hasFoiled then return end

        G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = (function()
                local card = SMODS.add_card({set = 'Spectral', edition = 'e_negative', area = G.consumeables})
                return true
            end)
        }))
        return{
            message = 'Berry!',
            colour = G.C.BLUE,
            card = card
        }
    end
}

SMODS.Joker{
    key = 'stick',
    loc_txt = {
        name = 'Stick',
        text = {
            'If played hand contains a {C:attention}Straight{},',
            'scored cards gain a random {C:attention}enchantment{}',
            'and this joker gains {X:mult,C:white}X#2#{} Mult{}',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = { x_mult = 1, x_mult_gain = 0.5 } },
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_gain}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			return {
				xmult = card.ability.extra.x_mult
			}
		end
        if context.cardarea ~= G.jokers or not context.before then return end

        if next(context.poker_hands['Straight']) and not context.blueprint then
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain

			-- -- First flip
			-- addEventForAll(context.scoring_hand,0.15,function (i,v)
				-- local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
				-- return function()
					-- v:flip()
					-- play_sound('card1', percent);
					-- return true
				-- end
			-- end)
			-- -- Set Enchantment
			-- addEventForAll(context.scoring_hand,0.3,function (i,v)
				-- return function()
					-- v:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})],true)
					-- v:juice_up()
					-- return true
				-- end
			-- end)
			-- -- Second flip
			-- addEventForAll(context.scoring_hand,0.15,function (i,v)
				-- local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
				-- return function()
					-- v:flip()
					-- play_sound('card1', percent);
					-- return true
				-- end
			-- end)
			for k,v in ipairs(context.scoring_hand) do
				local percent = 1.15 - (k-0.999)/(#G.hand.highlighted-0.998)*0.3
				v:flip()
				play_sound('card1',percent)
			end
			for k,v in ipairs(context.scoring_hand) do
				v:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})],true)
				v:juice_up()
			end
			for k,v in ipairs(context.scoring_hand) do
				local percent = 1.15 - (k-0.999)/(#G.hand.highlighted-0.998)*0.3
				v:flip()
				play_sound('card1',percent)
			end

			return{
				message = 'Spin!',
				colour = G.C.MULT,
				card = card,
			} 
        end
		
        if context.post_joker then
			return {
				xmult = card.ability.extra.x_mult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                colour = G.C.MULT
			}
		end
    end
}

SMODS.Joker{
    key = 'nyala',
    loc_txt = {
        name = 'Nyala',
        text = {
            'Played hands turn their respective',
            ' {C:planet}Planets{} into {C:enhanced}Black Holes{}',
            '{X:mult,C:white}X#2#{} Mult for every {C:enhanced}Black Hole{} used',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = { x_mult = 1, x_mult_gain = 0.5 } },
    pos = { x = 2, y = 0 },
    soul_pos = { x = 0, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_gain}}
    end
}

SMODS.Joker{
    key = 'bread',
    loc_txt = {
        name = 'b re ad',
        text = {
            'Each {C:attention}drawn card{} has a',
            '{C:green}#1# in #2#{} chance to permanently',
            '{C:attention}double{} its chip value'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = { odds = 4 } },
    pos = { x = 3, y = 0 },
    soul_pos = { x = 0, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return  { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end
}

SMODS.Joker{
    key = 'qui',
    loc_txt = {
        name = 'Qui',
        text = {
            'Each {C:attention}scoring seal card{} creates a',
            '{C:green}#1# in #2#{} chance to permanently',
            '{C:attention}double{} its chip value'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = { odds = 4 } },
    pos = { x = 4, y = 0 },
    soul_pos = { x = 0, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return  { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end
}

-- Note to Axy: please make this readable for me. You may know the magics beyond but I am but a mere squire. Do not inscibe the runes of madness unto my poor lua file.

SMODS.Joker{
    key = 'axy',
    loc_txt = {
        name = 'Axy',
        text = {
            '{C:inactive}This joker is under construction.',
            '{C:inactive}I have no idea what to say here',
            '{C:inactive}because this scares me.'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = { odds = 4 } },
    pos = { x = 5, y = 0 },
    soul_pos = { x = 5, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return  { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end
}
            




----------------------------------------------
------------MOD CODE END----------------------

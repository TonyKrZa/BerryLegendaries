----------------------------------------------
------------MOD CODE -------------------------

-- I am so sorry for anyone who has to look through this. Especially me in the future! 
BerryLegendaries = {}
assert(SMODS.load_file("atlases.lua", 'berry_leg'))()
assert(SMODS.load_file("sounds.lua", 'berry_leg'))()
assert(SMODS.load_file("helper_funcs.lua", 'berry_leg'))()

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
            'scored cards gain a random {C:attention}enhancement{}',
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

        if context.before and next(context.poker_hands['Straight']) and not context.blueprint then
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
			-- First flip
			BerryLegendaries.addEventForAll(context.scoring_hand,0.15,function (i,v)
				local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
				return function()
					v:flip()
					play_sound('card1', percent);
					return true
				end
			end)
			-- Set Enchantment
			BerryLegendaries.addEventForAll(context.scoring_hand,0.3,function (i,v)
				return function()
					v:juice_up()
					return true
				end
			end)
            for i, v in ipairs(context.scoring_hand) do
                v:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})], true, true)
            end
			-- Second flip / Unflip
			BerryLegendaries.addEventForAll(context.scoring_hand,0.15,function (i,v)
				local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
				return function()
					v:flip()
					play_sound('card1', percent);
					return true
				end
			end)
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
            'held {C:planet}Planets{} into {C:enhanced}Black Holes{}',
            '{X:mult,C:white}X#2#{} Mult for every {C:enhanced}Black Hole{} used',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = {
		x_mult = 1,
		x_mult_gain = 0.5,
		ate_card = 0,
		mapping = {
			-- Vanilla
			["Pluto"] = 'High Card',
			["Mercury"] = 'Pair',
			["Uranus"] = 'Two Pair',
			["Venus"] = 'Three of a Kind',
			["Saturn"] = 'Straight',
			["Jupiter"] = 'Flush',
			["Earth"] = 'Full House',
			["Mars"] = 'Four Of A Kind',
			["Neptune"] = 'Straight Flush',
			["Planet X"] = 'Five Of A Kind',
			["Ceres"] = 'Flush House',
			["Eris"] = 'Flush Five',
			-- Cryptid
			["c_cry_asteroidbelt"] = "Bulwark", -- Asteroid Belt
			["c_cry_void"] = "Clusterfuck", -- Void
			["c_cry_marsmoons"] = "Ultimate Pair", -- Phobos and Deimos
			["c_cry_universe"] = "The Entire Fucking Deck", -- The Universe In Its Fucking Entirety
			["cry-Timantti"] = {"High Card", "Pair", "Two Pair"}, -- Ruutu
			["cry-Klubi"] = {"Three of a Kind", "Straight", "Flush"}, -- Risti
			["cry-Sydan"] = {"Full House", "Four of a Kind", "Straight Flush"}, -- Hertta
			["cry-Lapio"] = {"Five of a Kind", "Flush House", "Flush Five"}, -- Pata
			["cry-Kaikki"] = {"Bulwark", "Clusterfuck", "Ultimate Pair"}, -- Kaikki
			["cry-sunplanet"] = {}, -- ignore Ascended cards for simplicity
		}
		} },
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {
			card.ability.extra.x_mult,
			card.ability.extra.x_mult_gain
			}}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			local count = 0
			for _,v in ipairs(G.consumeables.cards) do
				if self.config.extra.ate_card == 0 and v.ability.set == 'Planet' and BerryLegendaries.isMember(v.ability.name, context.scoring_name, self.config.extra.mapping) then 
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tarot1')
							v.T.r = -0.2
							v:juice_up(0.3, 0.4)
							v.states.drag.is = true
							v.children.center.pinch.x = true
							G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
								func = function()
									G.consumeables:remove_card(v)
									v:remove()
									v = nil
									SMODS.calculate_effect({message = 'Nom',colour = HEX('AD7B5C')}, card)
									return true;
								end}))
							return true;
						end}))
					count = count + 1
				end
			end

			for _=self.config.extra.ate_card+1, count do
				G.E_MANAGER:add_event(Event({
						func = function()
						SMODS.add_card({set = 'Spectral', key = 'c_black_hole'})
						return true; end
					}))
			end
			
			if self.config.extra.ate_card == 0 then self.config.extra.ate_card = count end
			
			return {
				xmult = card.ability.extra.x_mult
			}
		end
		
		if context.using_consumeable and context.consumeable.label == 'Black Hole' then
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
			SMODS.calculate_effect({message = "Upgraded!", colour = G.C.MULT}, card)
		end
		
		if context.after and self.config.extra.ate_card ~= 0 then
			self.config.extra.ate_card = 0
		end
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
    config = { extra = { odds = 3, has_doubled = false } },
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return  { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn and card.ability.extra.has_doubled then
			card.ability.extra.has_doubled = false
			return  {   
					 message = 'awa',
					 colour = G.C.CHIPS,
					 card = card
					}
        end
    end
}

SMODS.Joker{
    key = 'qui',
    loc_txt = {
        name = 'Qui',
        text = {
            'Each {C:attention}scoring seal card{} creates',
            'a random {C:attention}seal{} card, get {C:money}#1#${}',
            'for every {C:diamonds}Diamond{} drawn'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = { dollars = 3, diamond_count = 0, saw_seal = false } },
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return  { vars = {card.ability.extra.dollars, card.ability.extra.diamond_count, card.ability.extra.saw_seal }}
    end,
    calculate = function(self, card, context)
		if context.hand_drawn and card.ability.extra.diamond_count > 0 then
			ease_dollars(card.ability.extra.dollars * card.ability.extra.diamond_count)
			card.ability.extra.diamond_count = 0
			return  {   
					 message = 'nyeom',
					 colour = HEX('ff85ff'),
					 card = card
					}
		end
		if context.before then
			for _,v in ipairs(context.scoring_hand) do
				if v.seal then
					local target_card = (pseudorandom(pseudoseed('stdset'..G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base"
					local target_seal = pseudorandom_element(G.P_CENTER_POOLS['Seal'], pseudorandom('seals'))['key']
					local _card = SMODS.add_card({set = target_card, seal = target_seal, area = G.hand, skip_materialize = true})
					_card.states.visible = nil

					G.E_MANAGER:add_event(Event({
						func = function()
							_card:start_materialize()
							return true
						end
					})) 
					saw_seal = true
				end
			end
			if saw_seal then
				saw_seal = false
				return{
						message = 'Copied!',
						colour = HEX('ff85ff'),
						card = card
					}
			end
		end
	end
}

SMODS.Joker{
    key = 'fumi',
    loc_txt = {
        name = 'Fumi',
        text = {
            'This joker will {C:attention}always{} be {C:dark_edition}Negative{}',
			'Gives a {C:dark_edition}Negative{} {C:tarot}Tarot{}',
			'corresponding to the {C:attention}sum of ranks{} scored',
            '{C:inactive}(Aces count as 1 or 11, no-rank cards count as 0){}'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = {
		tarot_list = {'c_fool','c_magician','c_high_priestess','c_empress','c_emperor','c_heirophant','c_lovers','c_chariot','c_justice','c_hermit','c_wheel_of_fortune','c_strength','c_hanged_man','c_death','c_temperance','c_devil','c_tower','c_star','c_moon','c_sun','c_judgement','c_world'}
	} },
    pos = { x = 6, y = 0 },
    soul_pos = { x = 6, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return  { vars = {}}
    end,
    calculate = function(self, card, context)
		if (not card:get_edition() or card:get_edition().card.edition.type ~= 'negative') and not context.blueprint then
			card:set_edition('e_negative')
			return {
				message = "Hell yeah!",
				colour = G.C.PURPLE,
				card = card,
				sound = 'blurb_fumi'
			}
		end
		
		if context.joker_main then
			local total = 0
			local rank = 0
			local ace_count = 0
			for k, v in ipairs(context.scoring_hand) do
				rank = SMODS.has_no_rank(v) and 0 or math.max(v:get_id(), 0)
				if v:get_id() == 14 then
					ace_count = ace_count + 1
					rank = 1
				end
				total = total + rank
			end
			
			local tarot_array = {total}
			while ace_count > 0 do
				ace_count = ace_count - 1
				total = total + 10
				table.insert(tarot_array, total)
			end
			
			for _,v in ipairs(tarot_array) do
				if v >= 0 and v <= 21 then
					local target_card = self.config.extra.tarot_list[v+1]

					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							local _card = SMODS.add_card({set = 'Tarot', edition = 'e_negative', key = target_card, skip_materialize = true})
							_card.states.visible = nil
							_card:start_materialize()
							return true
						end
					}))
				end
			end
		end
	end
}


----------------------------------------------
------------MOD CODE END----------------------

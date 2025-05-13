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
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
			'{C:inactive}#3#{}'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = {
		x_mult = 1,
		x_mult_gain = 0.5,
		joke_list = {
			'What, am I getting carded now?',
			'Here to compair?',
			'Wait lemme get that straight',
			'Some real branching possibilities…',
			'Takeout for a spin',
			'antisynergy with: trouser',
			'Leverage!',
			'Only a true crank could pull this off',
			'Why is it called Straight when they’re all different colours?',
			'STR? Aight',
			'black and red like your momma’s bed',
			'Still here? Chop-chop',
			'28 Spike!',
			'Eats ramen',
			'I didn’t do anything, your screen’s just dirty',
			'stick is stick',
			'Could’ve ordered that better',
			'Stick spin? More like recon-text-you all eyes at I-on',
			'JIZ LOST',
			'Gonna go in blind?',
			'I’m sticking a round',
			'Dubble Jigsaw Crowbar Special!',
			'It’s two'
		}
	}},
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
		local joke = '"'..pseudorandom_element(self.config.extra.joke_list, pseudoseed('stick'))..'"'
        return { vars = {
			card.ability.extra.x_mult,
			card.ability.extra.x_mult_gain,
			joke
		}}
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
				local eat_card = self.config.extra.ate_card == 0 and v.ability.set == 'Planet' and BerryLegendaries.isMember(v.ability.name, context.scoring_name, self.config.extra.mapping)
				if eat_card then 
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
			
			if count > self.config.extra.ate_card then SMODS.calculate_effect({message = 'Nom!',colour = HEX('AD7B5C')}, card) end
			if self.config.extra.ate_card == 0 then self.config.extra.ate_card = count end
			
			return {
				xmult = card.ability.extra.x_mult
			}
		end
		
		if context.using_consumeable and context.consumeable.label == 'Black Hole' and not context.blueprint then
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
						message = 'Sealed!',
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
				func = function()
					play_sound('blurb_fumi',1,1)
				end
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
	end,
	load = function(self, card, card_table, other_card)
		if not card.edition or card.edition.type ~= 'negative' and not context.blueprint then
			card:set_edition('e_negative')
			SMODS.calculate_effect({
				message = "Hell yeah!",
				colour = G.C.PURPLE,
				card = card,
				func = function()
					play_sound('blurb_fumi',1,1)
				end
			}, card)
		end
	end
}

SMODS.Joker{
    key = 'zohn',
    loc_txt = {
        name = 'Zohnathan',
    },
    atlas = 'Jokers',
    rarity = 4,
	config = { extra = {
		odds = 2,
		trigger_count = 0,
		chips = 50,
		x_mult = 1,
		trigger_1_up = 3,
		trigger_1_down = 0.5,
		trigger_shop = false,
		change_boss = false,
		play_rickroll = false,
		change_sfx = false,
		activate_power_mult = false,
		power_mult = 2,
		final_chip = 69420,
	} },
    pos = { x = 0, y = 2 },
    soul_pos = { x = 0, y = 3},
    cost = 20,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return  { vars = {
				(G.GAME.probabilities.normal or 1),
				card.ability.extra.odds,
				card.ability.extra.chips,
				card.ability.extra.x_mult + card.ability.extra.trigger_count,
				card.ability.extra.trigger_1_up,
				card.ability.extra.trigger_1_down,
				card.ability.extra.power_mult,
				card.ability.extra.final_chip,
				card.ability.extra.trigger_count
			},
			key = card.ability.extra.trigger_count == 0 and self.key..'_00'
				or self.key ..'_'.. card.ability.extra.trigger_count % 10
		}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				xmult = card.ability.extra.x_mult + card.ability.extra.trigger_count,
				emult = card.ability.extra.activate_power_mult and card.ability.extra.power_mult or 1
			}
		end
		
		if card.ability.extra.trigger_shop and context.starting_shop then
			card.ability.extra.trigger_shop = false
			local chances = pseudorandom(pseudoseed(os.time())) < (G.GAME.probabilities.normal / card.ability.extra.odds)
			if chances then -- negative Jokers
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					for i = #G.shop_jokers.cards,1,-1 do
					    local c = G.shop_jokers:remove_card(G.shop_jokers.cards[i])
						c:start_dissolve()
						c = nil
					end
					
					for i = 1, G.GAME.shop.joker_max - #G.shop_jokers.cards do
						local new_shop_card = SMODS.create_card({
							set = "Joker",
							bypass_discovery_center = true,
							discover = true,
							skip_materialize = true,
						})
						new_shop_card:set_edition('e_negative', true, true)
						create_shop_card_ui(new_shop_card, 'Joker', G.shop_jokers)
						new_shop_card.states.visible = false
						G.shop_jokers:emplace(new_shop_card)
						new_shop_card.states.visible = true
					end
					return true
				end
			}))
			else -- polychrome 2s
			G.E_MANAGER:add_event(Event({
				trigger = 'immediate',
				func = function()
					for i = #G.shop_jokers.cards,1,-1 do
					    local c = G.shop_jokers:remove_card(G.shop_jokers.cards[i])
						c:start_dissolve()
						c = nil
					end
					
					for i = 1, G.GAME.shop.joker_max - #G.shop_jokers.cards do
						local new_shop_card = SMODS.create_card({
							set = "Base",
							bypass_discovery_center = true,
							discover = true,
							skip_materialize = true,
						})
						SMODS.change_base(
							new_shop_card,
							pseudorandom_element(SMODS.Suits, pseudorandom(os.time())).key,
							'2'
						)
						new_shop_card:set_edition('e_polychrome', true, true)
						new_shop_card.cost = 2
						create_shop_card_ui(new_shop_card, 'Joker', G.shop_jokers)
						new_shop_card.states.visible = false
						G.shop_jokers:emplace(new_shop_card)
						new_shop_card.states.visible = true
					end
					return true
				end
			}))
			end
		end
		
		if context.before and context.main_eval and not context.blueprint then
			contains_2_or_ace = false
			for _,v in ipairs(context.scoring_hand) do
				if not contains_2_or_ace and (v:get_id() == 14 or v:get_id() == 2) then
					contains_2_or_ace = true
				end
			end
			if not contains_2_or_ace then return end
			
			local _odds = card.ability.extra.odds
			local chances = pseudorandom(pseudoseed(os.time())) < (G.GAME.probabilities.normal / card.ability.extra.odds)
			local chances_2 = pseudorandom(pseudoseed(os.time())) < (G.GAME.probabilities.normal / card.ability.extra.odds)
			local trigger_count = card.ability.extra.trigger_count % 10
			card.ability.extra.trigger_count = card.ability.extra.trigger_count + 1
			card.ability.extra.activate_power_mult = false
			print(tprint({trigger_count,G.GAME.round_resets.ante}))
			if trigger_count == 0 then -- mult up, chip up, mult down, chip down
				if chances then
					if chances_2 then -- mult up
						return {xmult = card.ability.extra.trigger_1_up}
					else -- chip up
						return {xchips = card.ability.extra.trigger_1_up}
					end
				else
					if chances_2 then -- mult down
						return {xmult = card.ability.extra.trigger_1_down}
					else -- chip down
						return {xchips = card.ability.extra.trigger_1_down}
					end
				end
			elseif trigger_count == 1 then -- Polychrome/Holographic/Foil, Negative/Eternal
				if chances then -- Polychrome/Holographic/Foil
					card:set_edition(pseudorandom_element({'e_polychrome', 'e_holo', 'e_foil'}, pseudoseed(os.time())))
				else -- Negative/Eternal
					if chances_2 then -- Negative
						card:set_edition('e_negative')
					else -- Eternal
						SMODS.Stickers['eternal']:apply(card, true)
					end
				end
			elseif trigger_count == 2 then -- all cards in hand to steel or gold
				if chances then
					BerryLegendaries.FlipApply(G.hand.cards, function(i,v)
						v:set_ability(G.P_CENTERS.m_steel, true)
					end)
				else
					BerryLegendaries.FlipApply(G.hand.cards, function(i,v)
						v:set_ability(G.P_CENTERS.m_gold, true)
					end)
				end
			elseif trigger_count == 3 then -- all cards in hand to aces or 2s
				if chances then -- to Aces
					BerryLegendaries.FlipApply(G.hand.cards, function(i,v)
						SMODS.change_base(
							v,
							pseudorandom_element(SMODS.Suits, pseudorandom(os.time())).key,
							'Ace'
						)
					end)
				else -- to 2s
					BerryLegendaries.FlipApply(G.hand.cards, function(i,v)
						SMODS.change_base(
							v,
							pseudorandom_element(SMODS.Suits, pseudorandom(os.time())).key,
							'2'
						)
					end)
				end
			elseif trigger_count == 4 then -- Duplicate all negative Jokers or Non-Negative Edition Jokers
				local target_cards = #G.jokers.cards
				if chances then
					for i=1,target_cards do
						local t = G.jokers.cards[i]
						if t.edition and t.edition.negative then
							SMODS.add_card({set = 'Joker', area = G.jokers, key = t.label, edition = 'e_negative'})
						end
					end
				else
					for i=1,target_cards do
						local t = G.jokers.cards[i]
						if t.edition and t.edition.key ~= 'e_negative' then
							SMODS.add_card({set = 'Joker', area = G.jokers, key = t.label, edition = t.edition.key})
						end
					end
				end
			elseif trigger_count == 5 then -- All cards in shop to negative Jokers or Polychrome 2s
				card.ability.extra.trigger_shop = true
			elseif trigger_count == 6 then -- set Ante to 1 or next Boss Blind is the Wall
				if chances then
					card.ability.extra.change_boss = true
				else
					ease_ante(-G.GAME.round_resets.ante + 1)
				end
			elseif trigger_count == 7 then -- lose the game or play Rickroll song
				if chances then
					card.ability.extra.play_rickroll = true
				else
					G.STATE = G.STATES.GAME_OVER
					G.STATE_COMPLETE = false
				end
			elseif trigger_count == 8 then -- all sfx to Travis Scott or ^2 mult
				if chances then
					card.ability.extra.activate_power_mult = true
				else
					card.ability.extra.change_sfx = true
				end
			elseif trigger_count == 9 then -- all jokers into this joker, or +69,420 Chips to all cards in hand
				if chances then
					for _,v in pairs(G.jokers.cards) do
						if v.ability.name ~= "j_blurb_zohn" then
							v:set_ability(G.P_CENTERS.j_blurb_zohn)
						end
					end
				else
					for _,v in pairs(G.hand.cards) do
						v.ability = v.ability or {}
						v.ability.perma_bonus = (v.ability.perma_bonus or 0) + card.ability.extra.final_chip
					end
				end
			end
		end
	end
}

-- Zohnathan hook for SFX trigger
local play_sound_original = play_sound
function play_sound(sound_code, per, vol)
	local cards = BerryLegendaries and SMODS.find_card('j_blurb_zohn') or nil
	for _,v in pairs(cards) do
		if v.ability.extra.change_sfx == true then
			sound_code = 'blurb_zohn_travis'
			break
		end
	end
	
	local orig = play_sound_original(sound_code, per, vol)
end

-- Zohnathan hook for boss trigger
local get_new_boss_original = get_new_boss
function get_new_boss()
	local cards = BerryLegendaries and SMODS.find_card('j_blurb_zohn') or nil
	for _,v in pairs(cards) do
		if v.ability.extra.change_boss == true then
			v.ability.extra.change_boss = false
			return 'bl_wall'
		end
	end
	
	return get_new_boss_original()
end

SMODS.Joker{
    key = 'hanya',
    loc_txt = {
        name = 'Hanya',
        text = {
            'Scored unmodified cards become white'
        }
    },
    atlas = 'Jokers',
    rarity = 4,
    pos = { x = 7, y = 0 },
    soul_pos = { x = 0, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
    end,
    calculate = function(self, card, context)
        if context.joker_main then

			for i, v in pairs(context.full_hand) do
				-- if v:get_id() == 14 then hasAce = true end
				if not (v.edition or next(SMODS.get_enhancements(v))) then
					print(tprint(v))
					-- draw blank sprite on front/center?
				end
			end

			-- G.E_MANAGER:add_event(Event({
					-- trigger = 'after',
					-- func = (function()
					-- local card = SMODS.add_card({set = 'Spectral', edition = 'e_negative', area = G.consumeables})
					-- return true
				-- end)
			-- }))
			return{
				message = 'Hanya',
				colour = G.C.WHITE,
				card = card
			}
		end
    end
}
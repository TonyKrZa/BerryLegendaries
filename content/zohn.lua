SMODS.Joker{
    key = 'zohn',
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
		dupe_triggered = false
	} },
    pos = { x = 0, y = 2 },
    soul_pos = { x = 0, y = 3},
    cost = 20,
    blueprint_compat = false,
	eternal_compat = true,
    loc_vars = function(self, info_queue, card)
		local the_vars = {
			(G.GAME.probabilities.normal or 1),
			card.ability.extra.odds,
			card.ability.extra.chips,
			card.ability.extra.x_mult + card.ability.extra.trigger_count,
			card.ability.extra.trigger_1_up,
			card.ability.extra.trigger_1_down,
			card.ability.extra.power_mult,
			card.ability.extra.final_chip,
			card.ability.extra.trigger_count
		}

		return {
			vars = the_vars
		}
	end,
	generate_ui = function (self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if not card then
			card = self:create_fake_card()
		end
		full_UI_table.name = localize{type = 'name', set = self.set, key = self.key, nodes = full_UI_table.name}

		local the_vars = self.loc_vars(self, info_queue, card).vars

		-- Gets joker descriptions
		local joker_description = {
			G.localization.misc.v_dictionary.zohn_prev,
			G.localization.misc.v_dictionary.zohn,
			G.localization.misc.v_dictionary.zohn_next
		}
		local text = {}
		local result_nodes = {{
				n = G.UIT.C,
				config = {colour = G.C.CLEAR, align = "cm", padding = 0.067 },
				-- sex sevennnn
				nodes = text
		}}
		local text_table = loc_parse_string("{}")
		local current_position = card.ability.extra.trigger_count % 10 + 1
		for i,v in ipairs(joker_description) do
			if not (card.ability.extra.trigger_count == 0 and i == 1) then
				text_table = loc_parse_string(v[current_position])
				
				text[#text+1] = {
					n=G.UIT.R,
					config={ colour = G.C.CLEAR, align = "cm" },
					nodes=SMODS.localize_box(text_table, {vars = the_vars})
				}
			end
		end

		-- Sets joker descriptions
		if not specific_vars.debuffed then
			localize{type = 'descriptions', set = self.set, key = self.key, nodes = full_UI_table.main, AUT = full_UI_table, vars = the_vars}
			full_UI_table.multi_box = {{result_nodes}}
			-- print(serialize(full_UI_table.multi_box))
		else
			localize{type = 'other', key = 'debuffed_'..(specific_vars.playing_card and 'playing_card' or 'default'), nodes = desc_nodes}
		end
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				xmult = card.ability.extra.x_mult + card.ability.extra.trigger_count,
				emult = card.ability.extra.activate_power_mult and card.ability.extra.power_mult or 1
			}
		end

		if context.after then
			self.config.extra.dupe_triggered = false
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
							pseudorandom_element(SMODS.Suits, pseudorandom('zohn')).key,
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
			local contains_2_or_ace = false
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
						-- SMODS.Stickers['eternal']:apply(card, true)
						card:set_eternal(true)
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
							pseudorandom_element(SMODS.Suits, pseudorandom('zohn')).key,
							'Ace'
						)
					end)
				else -- to 2s
					BerryLegendaries.FlipApply(G.hand.cards, function(i,v)
						SMODS.change_base(
							v,
							pseudorandom_element(SMODS.Suits, pseudorandom('zohn')).key,
							'2'
						)
					end)
				end
			elseif trigger_count == 4 and not self.config.extra.dupe_triggered then -- Duplicate all negative Jokers or Non-Negative Edition Jokers
				local target_cards = #G.jokers.cards
				
				for i=1,target_cards do
					local t = G.jokers.cards[i]
					self.config.extra.dupe_triggered = true
					if chances and t.edition and t.edition.negative then
						-- local copied_joker = copy_card(t)
						-- copied_joker:add_to_deck()
						-- G.jokers:emplace(copied_joker)
						SMODS.add_to_deck(t, {area = G.jokers})
					elseif not chances and t.edition and not t.edition.negative then
						SMODS.add_to_deck(t, {area = G.jokers})
						-- local copied_joker = copy_card(t)
						-- copied_joker:add_to_deck()
						-- G.jokers:emplace(copied_joker)
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
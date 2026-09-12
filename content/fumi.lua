SMODS.Joker{
    key = 'fumi',
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
        return  {
			vars = {
				not BerryLegendaries.mod.config.fumi.modded_tarots and ' Vanilla' or '',
			}, -- TODO: Put created cards here for JokerDisplay?
			key = self.key
		}
    end,
	generate_ui = function (self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		SMODS.Joker.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		if not BerryLegendaries.mod.config.fumi.wrap_around then
			full_UI_table.main[#full_UI_table.main] = nil
		end
	end,
    calculate = function(self, card, context)
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
			
			local tarot_list = BerryLegendaries.mod.config.fumi.modded_tarots and G.P_CENTER_POOLS.Tarot or self.config.extra.tarot_list
			for _,v in ipairs(tarot_array) do
				if not BerryLegendaries.mod.config.fumi.wrap_around and v >= #tarot_list then break end
				if v >= 0 then
					local target_card = tarot_list[(v % #tarot_list) + 1]
					if BerryLegendaries.mod.config.fumi.modded_tarots then
						target_card = target_card.key
					end
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						func = function()
							local _card = SMODS.add_card({
								set = 'Tarot',
								edition = 'e_negative',
								key = target_card,
								skip_materialize = true
								})
							_card.states.visible = nil
							_card:start_materialize()
							return true
						end
					}))
				end
			end
		end
	end,
	update = function(self, card, dt)
		if not (card.edition and card.edition.negative) then
			card:set_edition('e_negative', true, true)
			card.ability.extra.to_negative = true
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		SMODS.calculate_effect{
				message = "Hell yeah!",
				colour = G.C.PURPLE,
				card = card,
				func = function()
					play_sound('blurb_fumi',1,1)
				end
			}
	end,
	joker_options = function()
		local target = {
        -- {n=G.UIT.T, config={text = 'become ', colour = G.C.UI.TEXT_LIGHT, scale = 0.24}},
			create_toggle({
			label = 'Ranks wrap around',
			ref_table = BerryLegendaries.mod.config.fumi,
			ref_value = "wrap_around"
			}),
			create_toggle({
				label = 'Include Modded Tarots',
				ref_table = BerryLegendaries.mod.config.fumi,
				ref_value = "modded_tarots"
			})
		}
	target[1].config.align = "cr"
	target[2].config.align = "cr"
	return target
	end
}
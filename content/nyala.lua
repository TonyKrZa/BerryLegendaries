SMODS.Joker{
    key = 'nyala',
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = {
		x_mult = 1,
		x_mult_gain = 0.5,
		ate_card = 0,
		} },
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {
			card.ability.extra.x_mult,
			card.ability.extra.x_mult_gain
			}, key = self.key}
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			local count = 0
			for _,v in ipairs(G.consumeables.cards) do
				-- Check if planet card is eaten already, or consumable is a planet card to be eaten
				local eat_card = self.config.extra.ate_card == 0 and v.ability.set == 'Planet'
				-- Check if current scored hand matches target planet
				eat_card = eat_card and ( next(SMODS.deepfind(v.ability, context.scoring_name, 'value', false)) or ((v.label == 'cry-sunplanet' and G.GAME.current_round.current_hand.cry_asc_num > 0)) )
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
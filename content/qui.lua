SMODS.Joker{
    key = 'qui',
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = { dollars = 3, numerator = 6, denominator = 10 } },
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return  {
			vars = {card.ability.extra.dollars, card.ability.extra.saw_seal },
			key = self.key
		}
    end,
    calculate = function(self, card, context)
		-- if context.berry_card_drawn and context.other_card.base.suit == 'Diamonds' and not context.other_card.debuff then
		-- 	card.ability.extra.diamond_count = card.ability.extra.diamond_count + 1
		-- end
		-- if context.hand_drawn and card.ability.extra.diamond_count > 0 then
		-- 	ease_dollars(card.ability.extra.dollars * card.ability.extra.diamond_count)
		-- 	card.ability.extra.diamond_count = 0
		-- 	return  {
		-- 			 message = 'nyeom',
		-- 			 colour = HEX('ff85ff'),
		-- 			 card = card
		-- 			}
		-- end
		if context.hand_drawn or context.other_drawn then
			local diamond_count = 0
			for _,v in pairs(context.hand_drawn or context.other_drawn) do
				if v:is_suit("Diamonds") then diamond_count = diamond_count + 1 end
			end

			if diamond_count > 0 then
				ease_dollars(card.ability.extra.dollars * diamond_count)
				return {
					message = 'nyeom',
					colour = HEX('ff85ff'),
					card = card
				}
			end
		end
		
		if context.before then
			local saw_seal = false
			for _,v in pairs(context.scoring_hand) do
				local target_card = pseudorandom_element(G.hand.cards, pseudoseed(self.key), {
					in_pool = function(v, args)
						return not v:get_seal(true)
					end
				})

				if v:get_seal(false) and target_card then
					saw_seal = true

					-- local target_card = SMODS.pseudorandom_probability(card, self.key, card.ability.extra.numerator, card.ability.extra.denominator) and "Enhanced" or "Base"

					-- local target_seal = pseudorandom_element(G.P_CENTER_POOLS['Seal'], self.key, {
					-- 	in_pool = function(v, args)
					-- 		return true
					-- 	end,
					-- }).key
					-- local _card = SMODS.add_card({set = target_card, seal = target_seal, area = G.hand, skip_materialize = true})
					-- _card.states.visible = nil

					-- G.E_MANAGER:add_event(Event({
					-- 	func = function()
					-- 		_card:start_materialize()
					-- 		return true
					-- 	end
					-- }))
					target_card:set_seal(v:get_seal(false))
				end
			end
			if saw_seal then
				return {
					message = 'Sealed!',
					colour = HEX('ff85ff'),
					card = card
				}
			end
		end
	end
}
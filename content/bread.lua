SMODS.Font{
    key = "ComicSands",
    path = "pixel-comic-sans-font.ttf",
    render_scale = 200,
    FONTSCALE = 0.1,
    TEXT_HEIGHT_SCALE = 0.83,
    TEXT_OFFSET = {x=0,y=0},
    squish = 1,
    DESCSCALE = 1
}

SMODS.Joker{
    key = 'bread',
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = { numerator = 1, odds = 2 } },
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return {
        key = self.key,
        vars = {
          card.ability.extra.numerator,
          card.ability.extra.odds
        },
      }
    end,
    calculate = function(self, card, context)
		-- if context.berry_card_drawn and (pseudorandom(pseudoseed('bread')) < (G.GAME.probabilities.normal / card.ability.extra.odds)) then
		-- 	local target = context.other_card.ability
		-- 	target.perma_bonus = target.perma_bonus + context.other_card:get_chip_bonus()
		-- 	SMODS.calculate_effect({
		-- 		 message = 'awa',
		-- 		 colour = G.C.CHIPS,
		-- 		 card = card
		-- 		}, card)
    --     end
      if context.hand_drawn or context.other_drawn then
        local success = false
        for _,v in pairs(context.hand_drawn or context.other_drawn) do
          if SMODS.pseudorandom_probability(card, self.key, card.ability.extra.numerator, card.ability.extra.odds) then
            SMODS.scale_card(v, {
              ref_table = v.ability,
              ref_value = 'perma_bonus',
              scalar_factor = v:get_chip_bonus(),
              operation = '+',
              no_message = true,
            })
            success = true
          end
        end

        if success then
          return {
            message = 'awa',
            colour = G.C.CHIPS,
            card = card
          }
        end
      end
    end
}
SMODS.Joker{
    key = 'tony',
    atlas = 'Jokers',
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1},
    pronouns = "he_him",
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
		return {
			key = self.key
		}
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
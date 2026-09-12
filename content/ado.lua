SMODS.current_mod.optional_features = function()
    return {
        post_trigger = true,
    }
end

SMODS.Joker{
    key = 'ado',
    atlas = 'Jokers',
    rarity = 4,
    pos = { x = 8, y = 0 },
    soul_pos = { x = 0, y = 1},
    pronouns = "he_him",
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local current_color = string.lower(card.ability.extra.colors[card.ability.extra.current_color])
        local next_color = string.lower(card.ability.extra.colors[card.ability.extra.next_color])
        info_queue[#info_queue+1] = {set = 'Other', key = 'blurb_ado_'..current_color,
            -- specific_vars = {"Current color: ", card.ability.extra.destroyed_cards_xmult},
            vars = {"Current color: ", card.ability.extra.destroyed_cards_xmult},
        }
        info_queue[#info_queue+1] = {set = 'Other', key = 'blurb_ado_'..next_color,
        -- specific_vars = {"Current color: ", card.ability.extra.destroyed_cards_xmult},
            vars = {"Next color: ", card.ability.extra.destroyed_cards_xmult}
        }

        local colors = {G.C.RED, G.C.BLUE, G.C.PURPLE, G.C.GOLD}
        local randomized_colors = {}
        randomized_colors[#randomized_colors + 1] = table.remove(colors, card.ability.extra.current_color)
        while #colors > 0 do
            randomized_colors[#randomized_colors + 1] = table.remove(colors, pseudorandom(self.key, 1, #colors))
        end

		return {
			key = self.key,
            vars = {
                card.ability.extra.colors[card.ability.extra.current_color],
                card.ability.extra.destroyed_cards_xmult,
                colours = randomized_colors,
            }
		}
    end,
    -- generate_ui = function (self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    --     SMODS.Joker.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    --     -- os.execute("cls")
    --     -- print(inspectDepth(card.children,0,4))
    --     -- print(inspect(self))
    --     -- print(inspectDepth(SMODS.deepfind(specific_vars,'Red',"v"), 0, -2))
    -- end,
    config = { extra = {
        current_color = 1, -- 1,2,3,4
        next_color = 2, -- 1,2,3,4
        colors = {'Red', 'Blue', 'Purple', 'Yellow'},
        number_of_hearts = 0,
        has_chips = false,
        destroyed_cards_xmult = 1,
    }},
    calculate = function(self, card, context)
        -- Ado:
        -- This Joker changes effects based on one of four colors (Red, Blue, Purple, and Yellow)
        -- (Color changes every round, current color: [color])
        -- - Red: Retriggers cards based on scored Hearts, if no Hearts are scored, set Mult to 0
        -- - Blue: x1.5 Chips whenever you gain chips from other Jokers, if no Jokers give you chips, increase Ante by 1
        -- - Purple: Destroyed cards give 5x Mult (Currently 1x Mult)
        -- - Yellow: Double all money gained at end of round if scored hand contains Diamonds, lose all Interest if scored hand contains Hearts
        if context.post_trigger and card.ability.extra.current_color == 2 then -- Blue effect for Jokers
            local has_chips =
                context.other_card:has_attribute('chips') or
                context.other_card:has_attribute('xchips') or
                context.other_card:has_attribute('swap')
            if has_chips then
                card.ability.extra.has_chips = true
                return {xchips = 1.5}
            end
        end

        if context.before then -- reset for Red effect for Hearts
            card.ability.extra.number_of_hearts = 0
            for _,v in pairs(context.scoring_hand) do
                if v:is_suit("Hearts") then card.ability.extra.number_of_hearts = card.ability.extra.number_of_hearts + 1 end
            end
        end
        if context.repetition and context.cardarea == G.play and card.ability.extra.current_color == 1 then -- Red effect for Hearts
            if context.other_card:is_suit("Hearts") then
                return {repetitions = card.ability.extra.number_of_hearts}
            end
        end

        if context.final_scoring_step and card.ability.extra.current_color == 1 then -- Red effect for no Hearts
            local has_hearts = false
            for _,v in pairs(context.scoring_hand) do
                if v:is_suit("Hearts") then
                    has_hearts = true
                    break
                end
            end

            if not has_hearts then
                return {
                    mult = -1 * SMODS.Scoring_Parameters.mult.current,
                    message = ":adopat:"
                }
            end
        end

        if context.final_scoring_step and card.ability.extra.current_color == 2 then -- Blue effect for no Chips
            if not card.ability.extra.has_chips then
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + 1
                ease_ante(1)
            end
            card.ability.extra.has_chips = false
        end

        if context.modify_final_cashout and context.main_eval and card.ability.extra.current_color == 4 then -- Yellow effect for cards
            local has_diamonds = false
            local has_hearts = false
            for _,v in pairs(SMODS.last_hand.scoring_hand) do
                if has_diamonds and has_hearts then break end
                if v:is_suit("Diamonds") then has_diamonds = true end
                if v:is_suit("Hearts") then has_hearts = true end
            end
            local has_interest = (G.GAME.interest_amount * math.min(math.floor(G.GAME.dollars/5), G.GAME.interest_cap/5))

            local effects = {}
            if has_diamonds then
                table.insert(effects, {modify = context.amount, cashout_row = {name = 'custom_ado_diamonds', text = 'Had Diamonds', text_colour = G.C.MONEY}})
                if has_hearts and has_interest > 0 then
                    context.amount = context.amount + context.amount
                end
            end
            if has_hearts and has_interest > 0 then
                table.insert(effects, {modify = -1 * has_interest, cashout_row = {name = 'custom_ado_hearts', text = 'Had Hearts', text_colour = G.C.RED}})
            end
            return SMODS.merge_effects(effects)
        end

        if context.remove_playing_cards or context.joker_type_destroyed then -- Purple effect for destroying cards
            if card.ability.extra.current_color == 3 then
                card.ability.extra.destroyed_cards_xmult = card.ability.extra.destroyed_cards_xmult + (5 * (context.removed and #context.removed or 1))
            end
        end

        if context.joker_main then
            return {xmult = card.ability.extra.destroyed_cards_xmult}
        end

        if context.ending_shop then
            -- card.ability.extra.current_color = (card.ability.extra.current_color % 4) + 1
            card.ability.extra.current_color = card.ability.extra.next_color
            card.ability.extra.next_color = pseudorandom_element({1,2,3,4}, self.key, {
                in_pool = function(v, args)
                    return v ~= card.ability.extra.current_color
                end,
            })
        end
    end,
    calc_nearest_color = function(self, color, colors)

    end,
    add_to_deck = function (self, card, from_debuff)
        card.ability.extra.current_color = pseudorandom(self.key, 1, #card.ability.extra.colors)
        card.ability.extra.next_color = pseudorandom_element({1,2,3,4}, self.key, {
            in_pool = function(v, args)
                return v ~= card.ability.extra.current_color
            end
        })
    end
}

-- adapted from Eremel's Ortalab util/artists.lua, objects/decks.lua
-- The artist tooltips have colors on them somehow
-- Second version from Fish and Chips, Radiation and Eremel's submission, Treasure Clam popup_hook
local popup_hook = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
    -- Needed if we used specific_vars instead of vars, in the info_queue tooltip
    -- if card.config and card.config.center and card.config.center.key == 'j_blurb_ado' then
    --     for k,v in ipairs(card.ability_UIBox_table.info) do
    --         v.name_styled = nil
    --     end
    -- end
    local ret = popup_hook(card)
    if card.area and card.area.config.collection and not card.config.center.discovered then return ret end

    if card.config and card.config.center and card.config.center.key == 'j_blurb_ado' then
        local colors = {G.C.RED, G.C.BLUE, G.C.PURPLE, G.C.GOLD}
        ret.nodes[1].nodes[1].config.colour = colors[card.ability.extra.current_color]

        ret.nodes[1].config.ref_table[1].nodes[1].nodes[1].nodes[1].config.colour = colors[card.ability.extra.current_color]
        ret.nodes[1].config.ref_table[1].nodes[1].nodes[1].nodes[1].nodes[1].config.colour = adjust_alpha(darken(colors[card.ability.extra.current_color], 0.6), 0.7)

        ret.nodes[1].config.ref_table[1].nodes[1].nodes[2].nodes[1].config.colour = colors[card.ability.extra.next_color]
        ret.nodes[1].config.ref_table[1].nodes[1].nodes[2].nodes[1].nodes[1].config.colour = adjust_alpha(darken(colors[card.ability.extra.next_color], 0.6), 0.7)
    end
	return ret
end
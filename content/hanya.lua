SMODS.Joker{
    key = 'hanya',
    atlas = 'Jokers',
    rarity = 4,
    pos = { x = 7, y = 0 },
    soul_pos = { x = 0, y = 1 },
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.mult_per_frame,
            love.timer.getFPS()
        }}
    end,
    config = { extra = {
        mult_per_frame = 1,
        current_fps = love.timer.getFPS()
    }},
    joker_display_def = function (JokerDisplay)
        ---@type JDJokerDefinition
        return { -- Red Card
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "current_fps" }
            },
            text_config = { colour = G.C.MULT },
            calc_function = function (card)
                card.joker_display_values.current_fps = love.timer.getFPS()
            end
        }
    end,
    calculate = function(self, card, context)
        if context.initial_scoring_step and not context.blueprint then
            local whitened = nil
			for i, v in pairs(context.full_hand) do
				if not (v.edition or next(SMODS.get_enhancements(v))) and (v.ability and v.ability.blurb_hanya == nil) then
                    v.ability = v.ability or {}
                    v.ability.blurb_hanya = true
                    whitened = true
				end
			end
            
            if whitened then
                return {
                    message = 'Hanya',
                    colour = G.C.WHITE,
                    card = card,
                }
            end
		end

        if context.joker_main then
            return {
                mult = love.timer.getFPS()
            }
        end

        -- for testing
        if context.stay_flipped and context.other_card.ability.blurb_hanya == true and context.from_area == G.play and context.to_area == G.discard then
            return {modify = {to_area = G.hand}}
        end
    end,
    remove_from_deck = function (self, card, from_debuff)
        if not from_debuff and #SMODS.find_card(self.key, true) < 1 then
            for _,v in pairs(G.playing_cards or {}) do
                if v.ability.blurb_hanya == true then
                    v.ability.blurb_hanya = nil
                end
            end
        end
    end
}

local old_should_hide_front_ref = Card.should_hide_front
Card.should_hide_front = function(self)
    if self.ability.blurb_hanya then
        return true
    end

    return old_should_hide_front_ref(self)
end

-- local old_hover_ref = Node.hover
-- Node.hover = function(self)
--     if self.ability and self.ability.blurb_hanya then return end
--     old_hover_ref(self)

--     -- Trying to make a '??? of ???' style h_popup, with '???' in the main box
--     -- if self.ability and self.ability.blurb_hanya then
--     --     os.execute("cls")
--     --     self.children.h_popup.definition.nodes[1].nodes[1].nodes[1].nodes[1].nodes[2].config.text = "??? of"
--     --     print(inspectDepth(self.children.h_popup.definition.nodes[1].nodes[1].nodes[1].nodes[1].nodes[2], 0, -2))
--     --     -- print(self.children.h_popup_config)
--     --     -- print(self.children.h_popup_2)
--     --     -- print(self.children.h_popup_2_config)
--     --     return
--     -- end
-- end

local old_parse_highlighted_ref = CardArea.parse_highlighted
CardArea.parse_highlighted = function(self)
    old_parse_highlighted_ref(self)

    for k, v in pairs(self.highlighted) do
        if v.ability and v.ability.blurb_hanya then
            update_hand_text({immediate = true, nopulse = nil, delay = 0}, {handname='????', level='?', mult = '?', chips = '?'})
            for name, parameter in pairs(SMODS.Scoring_Parameters) do
                update_hand_text({immediate = true, nopulse = nil, delay = 0}, {[name] = '?'})
            end
        end
    end
end


-- From Fish and Chips, Radiation and Eremel's submission, Treasure Clam popup_hook
local popup_hook = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
    if card.ability and card.ability.blurb_hanya then
        for k,v in ipairs(card.ability_UIBox_table.info) do
            v.name_styled = nil
        end
    end
    local ret = popup_hook(card)
    if card.area and card.area.config.collection and not card.config.center.discovered then return ret end

    if card.ability and card.ability.blurb_hanya then
        -- ret.nodes[1].nodes[1].config.colour = colors[card.ability.extra.current_color]

        -- ret.nodes[1].config.ref_table[1].nodes[1].nodes[1].nodes[1].config.colour = colors[card.ability.extra.current_color]
        -- ret.nodes[1].config.ref_table[1].nodes[1].nodes[1].nodes[1].nodes[1].config.colour = adjust_alpha(darken(colors[card.ability.extra.current_color], 0.6), 0.7)

        -- ret.nodes[1].config.ref_table[1].nodes[1].nodes[2].nodes[1].config.colour = colors[card.ability.extra.next_color]
        -- ret.nodes[1].config.ref_table[1].nodes[1].nodes[2].nodes[1].nodes[1].config.colour = adjust_alpha(darken(colors[card.ability.extra.next_color], 0.6), 0.7)

        -- change nodes[1] and nodes[2] in here, those are the name and middle boxes for the card
        -- print(inspectDepth(ret.nodes[1].nodes[1].nodes[1].nodes, 0, -2))
        print(inspectDepth(ret.nodes[1].nodes[1].nodes[1].nodes[1], 0, -2))
        print(inspectDepth(ret.nodes[1].nodes[1].nodes[1].nodes[2], 0, -2))
    end
	return ret
end
SMODS.Joker{
    key = 'bentux',
    atlas = 'Jokers',
    rarity = 4,
    pos = { x = 9, y = 0 },
    soul_pos = { x = 0, y = 1},
    pronouns = "he_him",
    is_flipped = false,
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local text_one, text_two, colour_one, colour_two
        text_one = not self.is_flipped and "Legendary" or "Common"
        text_two = not self.is_flipped and "Common" or "Legendary"
        colour_one = not self.is_flipped and G.C.RARITY.Legendary or G.C.RARITY.Common
        colour_two = not self.is_flipped and G.C.RARITY.Common or G.C.RARITY.Legendary

        -- local flavour_text = loc_parse_string("meow")
		-- local result_nodes =
        -- { n = G.UIT.C, config = { colour = G.C.CLEAR, align = "cm", padding = 0.067 }, nodes = {
        --     { n = G.UIT.R, config = { colour = G.C.CLEAR, align = "cm" }, nodes = {
        --         -- { n = G.UIT.C, config = { colour = G.C.CLEAR, align = "cm" }, nodes = SMODS.localize_box(flavour_text, {}) }
        --         { n = G.UIT.T, config = { text = "meow", colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } }
        --     }}
        -- }}

        -- local text = { {
        --     n = G.UIT.R,
        --     config = { colour = G.C.CLEAR, align = "cm" },
        --     nodes = { { n = G.UIT.T, config = { text = " ", colour = G.C.CLEAR, scale = 0.256 } } }
        -- } }
        -- text = {}
        -- local flavor_nodes = { {
        --     n = G.UIT.C,
        --     config = { colour = G.C.CLEAR, align = "cm" },
        --     nodes = text
        -- } }


        -- local final_line = SMODS.localize_box(self.fac_flavour_parsed, {})
        -- text[#text + 1] = {
        --     n = G.UIT.R,
        --     config = { colour = G.C.CLEAR, align = "cm" },
        --     nodes = final_line
        -- }


		return {
			vars = {
                text_one,
                text_two,
                colours = {
                    colour_one,
                    colour_two
                }
            },
            -- main_start = flavor_nodes
		}
    end,
    generate_ui = function (self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		SMODS.Joker.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        -- os.execute("cls")

        local flavor_text = {}
        table.insert(flavor_text, {n=G.UIT.T, config={text = 'May the ', colour = G.C.UI.TEXT_LIGHT, scale = 0.24}})
        table.insert(flavor_text, {n=G.UIT.T, config={
            text = not self.is_flipped and 'impossible ' or 'mundane ',
            colour = not self.is_flipped and G.C.RARITY.Legendary or G.C.RARITY.Common,
            scale = 0.24}})
        table.insert(flavor_text, {n=G.UIT.T, config={text = 'become ', colour = G.C.UI.TEXT_LIGHT, scale = 0.24}})
        table.insert(flavor_text, {n=G.UIT.T, config={
            text = not self.is_flipped and 'mundane' or 'impossible',
            colour = not self.is_flipped and G.C.RARITY.Common or G.C.RARITY.Legendary,
            scale = 0.24}})
        table.insert(flavor_text, {n=G.UIT.T, config={text = '.', colour = G.C.UI.TEXT_LIGHT, scale = 0.24}})

        table.insert(full_UI_table.name,
            {n=G.UIT.R, config = {align = 'cm', padding = 0.05}, nodes = {
				{n=G.UIT.C, config={align = "m", colour = G.C.CLEAR, r = 0.05, res = 0.45}, nodes = flavor_text }
			}}
        )

    end,
    add_to_deck = function (self, card, from_debuff)
        blurb_swap_joker_rarities("Legendary", "Common")
    end,
    remove_from_deck = function (self, card, from_debuff)
        blurb_swap_joker_rarities("Legendary", "Common")
    end,
}

local create_mod_badge_ref = SMODS.create_mod_badge
function SMODS.create_mod_badge(mod, obj, width, text_height)
    if mod.display_name == BerryLegendaries.mod.display_name then
        if G.P_CENTERS['j_blurb_bentux'].is_flipped then
            local fakemod = SMODS.shallow_copy(mod)
            fakemod.display_name = "Berry's Commons"
            return create_mod_badge_ref(fakemod, obj, width, text_height)
        end
    end
    return create_mod_badge_ref(mod, obj, width, text_height)
end

local start_run_ref = Game.start_run
function Game:start_run(args)
    -- print("in start run")
    start_run_ref(self, args)

    local is_flipped = (#SMODS.find_card('j_blurb_bentux', false) % 2 == 1) -- odd number of bentuxes
    -- print(is_flipped)
    if is_flipped then
        blurb_swap_joker_rarities("Legendary", "Common")
    end
end

local blurb_delete_run_ref = Game.delete_run
function Game:delete_run()
    -- print("in delete function")
    if G.P_CENTERS['j_blurb_bentux'].is_flipped then
        -- print("in delete and is flipped")
        blurb_swap_joker_rarities("Legendary", "Common")
    end
    blurb_delete_run_ref(self)
end

-- Takes labels "Common", "Uncommon", "Rare", "Legendary".
-- Internally swaps the Joker Rarities.
function blurb_swap_joker_rarities(from, to)
    -- iterate over all centers and switch rarities, rare to legendary and vice versa
    -- self.config.center.rarity holds the rarity of a card, see lines 3665 (Card:is_rarity(rarity)) and 4210 (SMODS.get_card_type_text_colour) in utils.lua, in lovely/dump/SMODS/_/src/utils.lua
    local vanilla_rarities = {["Common"] = 1, ["Uncommon"] = 2, ["Rare"] = 3, ["Legendary"] = 4}
    local from_rarity = vanilla_rarities[from] or from
    local to_rarity = vanilla_rarities[to] or to
    for _,v in pairs(G.P_CENTER_POOLS.Joker) do
        -- local rarity = (({"Common", "Uncommon", "Rare", "Legendary"})[v.rarity] or v.rarity)
        local rarity = v.rarity
        if rarity == from_rarity then
            SMODS.Joker:take_ownership(v.key, {
                rarity = to_rarity,
                discovered = v.discovered
            }, true)
        elseif rarity == to_rarity then
            SMODS.Joker:take_ownership(v.key, {
                rarity = from_rarity,
                discovered = v.discovered
            }, true)
        end

    end

    local temp = G.P_JOKER_RARITY_POOLS[to_rarity]
    G.P_JOKER_RARITY_POOLS[to_rarity] = G.P_JOKER_RARITY_POOLS[from_rarity]
    G.P_JOKER_RARITY_POOLS[from_rarity] = temp

    G.P_CENTERS['j_blurb_bentux'].is_flipped = not G.P_CENTERS['j_blurb_bentux'].is_flipped or false
    -- print("swapping to:")
    -- print(G.P_CENTERS['j_blurb_bentux'].is_flipped)
end
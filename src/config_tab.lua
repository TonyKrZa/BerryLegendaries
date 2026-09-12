-- local BerryLegendaries = SMODS.current_mod
-- From JokerDisplay config_tab.lua
BerryLegendaries.init_cardarea_config = function()
  G.berrylegendaries_config_card_area = CardArea(G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h, 1.03 * G.CARD_W, 1.03 * G.CARD_H, { card_limit = 1, type = 'title', highlight_limit = 0, })
  local center = G.P_CENTERS['j_blurb_' .. string.lower(BerryLegendaries.mod.config.jokers[BerryLegendaries.mod.config.config_joker or 1] or 'tony')]
  local card = Card(G.berrylegendaries_config_card_area.T.x + G.berrylegendaries_config_card_area.T.w / 2, G.berrylegendaries_config_card_area.T.y, G.CARD_W, G.CARD_H, nil, center)
  -- card.bypass_discovery_ui = true
  -- card.bypass_discovery_center = true
	-- card.bypass_lock = true
  G.berrylegendaries_config_card_area:emplace(card)
  if SMODS.find_mod('JokerDisplay') and center.discovered and center.joker_display_def then
    G.berrylegendaries_config_card_area.cards[1]:update_joker_display()
    G.berrylegendaries_config_card_area.cards[1].joker_display_values.disabled = false
  end

  local old_remove = G.berrylegendaries_config_card_area.remove
  function G.berrylegendaries_config_card_area:remove()
      old_remove(self)
      if G.berrylegendaries_config_card_area == self then
          G.berrylegendaries_config_card_area = nil
      end
  end
end

BerryLegendaries.create_joker_options = function(joker)
  local node_array = {
        simple_text_container('blurb_no_joker_options',{colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true})
    }
  local ret = {n = G.UIT.R, config = {minh = 0.2, align = "cm"}, nodes = {}}
  -- localize{set = 'Other', key = 'blurb_no_joker_options', nodes = ret.nodes}
  -- ret.nodes = transparent_multiline_text(ret.nodes)

  -- Set options based on choice
  local target = 'j_blurb_' .. string.lower(BerryLegendaries.mod.config.jokers[joker] or 'tony')
  if G.P_CENTERS[target] and G.P_CENTERS[target].discovered == false then
    node_array = {simple_text_container('blurb_undiscovered_joker_options',{colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true})}
  elseif G.P_CENTERS[target] and G.P_CENTERS[target].joker_options and type(G.P_CENTERS[target].joker_options) == 'function' then
    node_array = G.P_CENTERS[target].joker_options()
  end

  for _,v in ipairs(node_array) do
    table.insert(ret.nodes, v)
  end

  return {n=G.UIT.ROOT, config={align = "cm", colour = G.C.BLACK}, nodes={ret}}
end

BerryLegendaries.mod.config_tab = function()
  local root = {n = G.UIT.ROOT, config = {
  -- config values here, see 'Building a UI' page
    minw = 4,
    minh = 4,
    padding = 0.2,
    colour = G.C.BLACK,
    r = 0.1,
    align = "cm",
    id = 'blurb_config_tab_root'
  }, nodes = {
  -- work your UI wizardry here, see 'Building a UI' page
  }}

  table.insert(root.nodes, {
    n = G.UIT.R, nodes = {}, config = {
      align = "cm"
  }})

  -- Make card in card_area
  BerryLegendaries.init_cardarea_config()
  table.insert(root.nodes[1].nodes, {
    n=G.UIT.C, config={
      colour = G.C.CLEAR,
      no_fill = true,
      padding = 0.3,
    },
      nodes = {
        {n=G.UIT.O, config = { object = G.berrylegendaries_config_card_area }}
    }
  })

  -- Make checkboxes for each card
  local my_menu = UIBox({
    definition = BerryLegendaries.create_joker_options(BerryLegendaries.mod.config.config_joker or 1),
    config = {minh = 0.2, align = "cm"}
  })

  table.insert(root.nodes[1].nodes, {
    n=G.UIT.C, config={minh = 0.2, padding = 0.3}, nodes = {
      {n = G.UIT.O, config = {
        object = my_menu,
        id = 'blurb_joker_config_options',
        minh = 0.2
      }}
    },
    instance_type = "CARD"
  })

  -- Make option cycle element, respecting discovery
  table.insert(root.nodes, {
    n = G.UIT.R, nodes = {}, config = {
      align = "cm",
      colour = G.C.BLACK,
      r = 0.1
  }})

  -- print(BerryLegendaries.config.jokers)
  local my_options = {'Tony', 'Stick', 'Nyala', 'Bread', 'Qui', 'Fumi', 'Zohnathan', 'Hanya', 'Ado', 'Bentux'}
  local my_jokers = {'tony', 'stick', 'nyala', 'bread', 'qui', 'fumi', 'zohn', 'hanya', 'ado', 'bentux'}
  for i,v in ipairs(my_jokers) do
    local _card = G.P_CENTERS['j_blurb_' .. v]
    if _card and not _card.discovered then
      my_options[i] = '???'
    end
  end
  table.insert(root.nodes[2].nodes, {
    n = G.UIT.C, config = {align = 'cm'}, nodes = {
        create_option_cycle({
            label = 'Jokers',
            scale = 0.8,
            options = my_options,
            jokers = my_jokers,
            current_option = BerryLegendaries.mod.config.config_joker or 1,
            opt_callback = 'blurb_set_config_joker',
            cycle_shoulders = true
        })
    },
    instance_type = "NODE"
  })
  return root
end

G.FUNCS.blurb_set_config_joker = function(args)
	-- update card in existing cardarea
	BerryLegendaries.mod.config.config_joker = args.to_key
	SMODS.save_mod_config(BerryLegendaries.mod)
	G.berrylegendaries_config_card_area.cards[1]:remove()
	-- SMODS.add_card({
	-- 	area = G.berrylegendaries_config_card_area,
	-- 	bypass_discovery_center = true,
	-- 	key = 'j_blurb_' .. string.lower(BerryLegendaries.config.jokers[BerryLegendaries.config.config_joker]) or 'tony',
	-- 	no_edition = true
	-- })
	local center = G.P_CENTERS['j_blurb_' .. string.lower(args.cycle_config.jokers[args.to_key or 1] or 'tony')]
  local card = Card(
    G.berrylegendaries_config_card_area.T.x + G.berrylegendaries_config_card_area.T.w / 2,
    G.berrylegendaries_config_card_area.T.y,
    G.CARD_W,
    G.CARD_H,
    nil,
    center
  )
  G.berrylegendaries_config_card_area:emplace(card)
  if SMODS.find_mod('JokerDisplay') and center.discovered and center.joker_display_def then
    G.berrylegendaries_config_card_area.cards[1]:update_joker_display()
    G.berrylegendaries_config_card_area.cards[1].joker_display_values.disabled = false
  end

  -- update options
  local my_menu_uibox = G.OVERLAY_MENU:get_UIE_by_ID('blurb_joker_config_options')
  local menu_wrap = my_menu_uibox.parent

  my_menu_uibox.config.object:remove()
  my_menu_uibox.config.object = UIBox({
    definition = BerryLegendaries.create_joker_options(args.to_key or 1),
    config = {parent = menu_wrap, minh = 0.2, align = "cm"}
  })
  menu_wrap.UIBox:recalculate()
  G.OVERLAY_MENU:recalculate()
end
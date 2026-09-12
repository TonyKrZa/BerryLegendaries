SMODS.Joker{
    key = 'stick',
    atlas = 'Jokers',
    rarity = 4,
    config = { extra = {
		x_mult = 1,
		x_mult_gain = 0.25,
		joke_list = {
			"What, am I getting carded now?",
			"Here to compair?",
			"Wait lemme get that straight",
			"Some real branching possibilities…",
			"Takeout for a spin",
			"antisynergy with: trouser",
			"Leverage!",
			"Only a true crank could pull this off",
			"Why is it called Straight when they're all different colours?",
			"STR? Aight",
			"black and red like your momma's bed",
			"Still here? Chop-chop",
			"28 Spike!",
			"Eats ramen",
			"I didn't do anything, your screen's just dirty",
			"stick is stick",
			"Could've ordered that better",
			"Stick spin? More like recon-text-you all eyes at I-on",
			"JIZ LOST",
			"Gonna go in blind?",
			"I'm sticking a round",
			"Dubble Jigsaw Crowbar Special!",
			"It's two",
			"mancomicstick",
			"comicmanstick",
			"stickcomicman",
			"manstickcomic",
			"comicstickman",
			"You read? What are you, a sightoid?",
			"Expotential scaling!",
			"Adds to 10!",
			"Wait wrong game",
			"Add these cards, your deck will 10K me for it",
			"lemme ex-plain",
			"Discards? Why not Doscards?",
			"first I eat dim sum, then I eat ur mum",
			"wtf get off",
			"it's a number line",
			"I showed you my stick, please respond",
			"Vampire's stake",
			"it's a backscratcher",
			"it's runny",
			"Sequential sequences!",
			"Tony applied thermal paste to this joker",
			"Legendary? more like hand-begin-stone",
			"Flips and Shuffles all Playing Cards",
			"linear growth",
			"mental gymnasticks",
		}
	}},
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1},
    cost = 20,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
		-- local joke = '"'..pseudorandom_element(self.config.extra.joke_list, pseudoseed('stick'))..'"'
        return { vars = {
			card.ability.extra.x_mult,
			card.ability.extra.x_mult_gain,
			-- joke
		}, key = self.key}
    end,
    generate_ui = function (self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
		SMODS.Joker.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

        local flavor_text = {}
		local joke = pseudorandom_element(self.config.extra.joke_list, pseudoseed('stick'))
        table.insert(flavor_text, {n=G.UIT.T, config={text = joke, colour = G.C.UI.TEXT_LIGHT, scale = 0.25 + ((G.GAME.round_resets.ante - 1) / G.GAME.win_ante) * 0.75}})

        table.insert(full_UI_table.name,
            {n=G.UIT.R, config = {align = 'cm', padding = 0.05}, nodes = {
				{n=G.UIT.C, config={align = "m", colour = G.C.CLEAR, r = 0.05, res = 0.45}, nodes = flavor_text }
			}}
        )
    end,
    calculate = function(self, card, context)

        if context.joker_main then
			return {
				xmult = card.ability.extra.x_mult,
				-- message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                -- colour = G.C.MULT,
				-- remove_default_message = true
			}
		end
		
        if context.initial_scoring_step and next(context.poker_hands['Straight']) and not context.blueprint then
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
			BerryLegendaries.FlipApply(context.scoring_hand, function(i,v)
				for i, v in ipairs(context.scoring_hand) do
					v:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})], false, true)
				end
			end, true)
			return {
				message = 'Spin!',
				colour = G.C.MULT,
				card = card,
			} 
        end
    end
}
----------------------------------
--	Helper Funcs for main.lua	--
----------------------------------
BerryLegendaries.addEventForAll = function(cards,_delay,func)
	for i,v in ipairs(cards) do
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = _delay,func = func(i,v)}))
	end
end

-- Function to check for membership in an array of strings
BerryLegendaries.isMember = function(key, value, myTable)
	local array = myTable[key] -- Get the array corresponding to the key
    if type(array) == 'table' then
        for _, v in ipairs(array) do
            if v == value then
                return true
            end
        end
    end
    return array == value
end

BerryLegendaries.FlipApply = function(target_cards, func, immediate)
immediate = immediate or false
BerryLegendaries.addEventForAll(target_cards,0.15,function (i,v)
	local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
	return function()
		v:flip()
		play_sound('card1', percent);
		return true
	end
end)
-- Set Enchantment
if immediate == true then
	func(i,v)
end
BerryLegendaries.addEventForAll(target_cards,0.3,function (i,v)
	return function()
		-- v:set_base(pseudorandom_element({G.P_CARDS.H_A,G.P_CARDS.D_A,G.P_CARDS.C_A,G.P_CARDS.S_A}))
		if immediate == false then
			func(i,v)
		end
		v:juice_up()
		return true
	end
end)
-- Second flip / Unflip
BerryLegendaries.addEventForAll(target_cards,0.15,function (i,v)
	local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
	return function()
		v:flip()
		play_sound('card1', percent);
		return true
	end
end)
end

-- from https://github.com/SleepyG11/TwitchBlinds/blob/637aa8ec648be390952e43cb4bd901e92f6d4eff/core/blinds.lua#L212
--- Set game blind safely
--- @param blind_type 'Small' | 'Big' | 'Boss' Blind to replace
--- @param blind_name string Blind key to set
function G.replace_blind(blind_type, blind_name)
	local blind_type_lower = string.lower(blind_type)
	stop_use()
	G.CONTROLLER.locks.boss_reroll = true
	G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		func = function()
			play_sound("other1")
			G.blind_select_opts[blind_type_lower]:set_role({ xy_bond = "Weak" })
			G.blind_select_opts[blind_type_lower].alignment.offset.y = 20
			return true
		end,
	}))
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.3,
		func = function()
			local par = G.blind_select_opts[blind_type_lower].parent
			G.GAME.round_resets.blind_choices[blind_type] = blind_name
			G.blind_select_opts[blind_type_lower]:remove()
			G.blind_select_opts[blind_type_lower] = UIBox({
				T = { par.T.x, 0, 0, 0 },
				definition = {
					n = G.UIT.ROOT,
					config = { align = "cm", colour = G.C.CLEAR },
					nodes = {
						UIBox_dyn_container(
							{ create_UIBox_blind_choice(blind_type) },
							false,
							get_blind_main_colour(blind_type),
							mix_colours(G.C.BLACK, get_blind_main_colour(blind_type), 0.8)
						),
					},
				},
				config = {
					align = "bmi",
					offset = { x = 0, y = G.ROOM.T.y + 9 },
					major = par,
					xy_bond = "Weak",
				},
			})
			par.config.object = G.blind_select_opts[blind_type_lower]
			par.config.object:recalculate()
			G.blind_select_opts[blind_type_lower].parent = par
			G.blind_select_opts[blind_type_lower].alignment.offset.y = 0

			G.E_MANAGER:add_event(Event({
				blocking = false,
				trigger = "after",
				delay = 0.5,
				func = function()
					G.CONTROLLER.locks.boss_reroll = nil
					return true
				end,
			}))

			save_run()
			return true
		end,
	}))
end
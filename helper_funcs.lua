----------------------------------
--	Helper Funcs for main.lua	--
----------------------------------
BerryLegendaries = {}
BerryLegendaries.addEventForAll = function(cards,_delay,func)
	for i,v in ipairs(cards) do
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = _delay,func = func(i,v)}))
	end
end
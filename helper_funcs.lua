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
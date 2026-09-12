local loc_table = {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {},
		Other = {},
    },
	misc = {
		v_dictionary = {},
		dictionary = {
			blurb_no_joker_options = {
				'No options available',
				'for this Joker'
			},
			blurb_undiscovered_joker_options = {
				'Discover this Joker',
				'to enable options'
			}
		},
	}
}

local jokers = {'tony', 'stick', 'nyala', 'bread', 'qui', 'fumi', 'zohn', 'hanya', 'ado', 'bentux'}
local target_file
for _,v in ipairs(jokers) do
	target_file = assert(SMODS.load_file("localization/jokers/" .. v .. ".lua", "berry_leg"))()

	if target_file.descriptions and target_file.descriptions.Joker then
		loc_table.descriptions.Joker = SMODS.merge_defaults(loc_table.descriptions.Joker, target_file.descriptions.Joker)
	end
	if target_file.descriptions and target_file.descriptions.Other then
		loc_table.descriptions.Other = SMODS.merge_defaults(loc_table.descriptions.Other, target_file.descriptions.Other)
	end
	if target_file.misc and target_file.misc.dictionary then
		loc_table.misc.dictionary = SMODS.merge_defaults(loc_table.misc.dictionary, target_file.misc.dictionary)
	end
	if target_file.misc and target_file.misc.v_dictionary then
		loc_table.misc.v_dictionary = SMODS.merge_defaults(loc_table.misc.v_dictionary, target_file.misc.v_dictionary)
	end
end

return loc_table
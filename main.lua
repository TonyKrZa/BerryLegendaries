BerryLegendaries = BerryLegendaries or {}
BerryLegendaries.mod = SMODS.current_mod

-- PotatoPatchUtils.load_files(BerryLegendaries.mod.path .. '/src')
assert(SMODS.load_file("src/atlases.lua"))()
assert(SMODS.load_file("src/sounds.lua"))()
assert(SMODS.load_file("src/helper_funcs.lua"))()
assert(SMODS.load_file("src/ui.lua"))()
-- PotatoPatchUtils.load_files(BerryLegendaries.mod.path .. '/content')

--#region Jokers
local jokers = {'tony', 'stick', 'nyala', 'bread', 'qui', 'fumi', 'zohn', 'hanya', 'ado', 'bentux'}
-- local jokers = {'hanya', 'ado', 'bentux', 'tony', 'stick', 'nyala', 'bread', 'qui', 'fumi', 'zohn',}
for _,v in ipairs(jokers) do
    assert(SMODS.load_file('content/' .. v .. '.lua'))()
end
--#endregion

SMODS.load_mod_localization(BerryLegendaries.mod.path, BerryLegendaries.mod.id)

assert(SMODS.load_file("src/config_tab.lua"))()
-- G.SETTINGS[G.SETTINGS.profile].meow = 'meow'
-- G:save_settings()

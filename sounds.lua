SMODS.Sound({
	key = 'fumi',
	path = 'fumi_hell_yeah_vorbis.ogg',
	vol = 1,
	pitch = 1,
})

-- Travis Scott for Zohn
SMODS.Sound({
	key = "zohn_travis",
	path = "travis.ogg",
})

-- Rickroll
SMODS.Sound({
	key = "zohn_rickroll_music",
	path = "rickroll.ogg",
	sync = false,
	pitch = 1,
	select_music_track = function()
		for _,v in pairs(SMODS.find_card('j_blurb_zohn')) do
			if v.ability.extra.play_rickroll == true then
			-- return G.BERRY.config.rickroll_music -- see Prism and its config and main lua, probably good idea with this card
			return true
			and 6 -- This number sets the priority of the music, higher means more priority
			end
		end
		-- return false and -1
	end,
})
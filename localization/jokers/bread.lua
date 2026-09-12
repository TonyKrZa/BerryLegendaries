local loc_table = {
    descriptions = {
        -- this key should match the set ("object type") of your object,
        -- e.g. Voucher, Tarot, or the key of a modded consumable type
        Joker = {
            j_blurb_bread = {
                name = '{f:blurb_ComicSands}b re ad',
                text = {
                    '{f:blurb_ComicSands}Each {f:blurb_ComicSands,C:attention}drawn card{}{f:blurb_ComicSands} has a',
                    '{f:blurb_ComicSands,C:green}#1# in #2#{}{f:blurb_ComicSands} chance to permanently',
                    '{f:blurb_ComicSands,C:attention}double{}{f:blurb_ComicSands} its chip value'
                }
        }},
    },
}

return loc_table
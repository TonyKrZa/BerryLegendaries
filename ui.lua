
-- todo: figure out how to add a sprite since this isn't working
-- SMODS.Atlas{
--     key = 'Jokers',
--     path = 'jokers.png',
--     px = 71,
--     py = 95
-- }
-- local sprite = Sprite(0, 0, 71, 71, G.ASSET_ATLAS["j_blurb_tony"], {x = 0, y = 1})
-- Credits!
SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = 'Credits',
            tab_definition_function = function()
                return {
                    n = G.UIT.ROOT,
                    config = { r = 0.1, minw = 10, minh = 6.5, align = "tm", padding = 0.2, colour = G.C.BLACK },
                    nodes = { {
                        n = G.UIT.R,
                        config = { minw = 10, minh = 6 },
                        nodes = { {
                            n = G.UIT.C,
                            config = { r = 0.1, minw = 3.33, minh = 6, padding = 0.2 },
                            nodes = { {
                                n = G.UIT.R,
                                config = { r = 0.1, colour = G.C.GREEN, minh = 0.75, minw = 2.8, align = "cm", hover = true, shadow = true },
                                nodes = { {
                                    n = G.UIT.T, config = { text = "Programmers", colour = G.C.WHITE, scale = 0.5, hover = true, shadow = true }

                                } }
                            },
                                {
                                    n = G.UIT.R,
                                    nodes = { {
                                        n = G.UIT.T, config = { text = "TonyKrZa", colour = HEX("0081D6FF"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                    } }
                                },
                                {
                                    n = G.UIT.R,
                                    nodes = { {
                                        n = G.UIT.T, config = { text = "Axyraandas", colour = HEX("3E993EFF"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                    } }
                                },
                                {
                                    n = G.UIT.R,
                                    nodes = { {
                                        n = G.UIT.T, config = { text = "fumiko_239", colour = HEX("6CF5FFFF"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                    } }
                                },
                                {
                                    n = G.UIT.R, config = { minh = 0.5, minw = 3.33 }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { r = 0.1, colour = G.C.BLUE, minh = 0.75, minw = 2.8, align = "cm", hover = true, shadow = true },
                                    nodes = { {
                                        n = G.UIT.T, config = { text = "Artists", colour = G.C.WHITE, scale = 0.5, hover = true, shadow = true }

                                    } }
                                },
                                {
                                    n = G.UIT.R,
                                    nodes = { {
                                        n = G.UIT.T, config = { text = "TonyKrZa", colour = HEX("0081D6"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                    } }
                                },
                                {
                                    n = G.UIT.R,
                                    nodes = { {
                                        n = G.UIT.T, config = { text = "Breadcrumb5550", colour =  HEX("FFA01C"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                    } }
                                },
                                {
                                    n = G.UIT.R,
                                    nodes = { {
                                        n = G.UIT.T, config = { text = "Quiyuan", colour = HEX("FF84F9"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                    } }
                                }

                            }
                        },
                            {
                                n = G.UIT.C,
                                config = { align = "cm", r = 0.1, minw = 3.33, minh = 6, padding = 0.2 }, nodes = { { 
                                    n = G.UIT.O, config = { hover = true, shadow = true, object = Sprite(0, 0, 3*(71/95), 3, G.ASSET_ATLAS["blurb_Jokers"], {x = 0, y = 1})}
                                }}
                            },
                            {
                                n = G.UIT.C,
                                config = { r = 0.1, minw = 3.33, minh = 6, padding = 0.2 },
                                nodes = { {
                                    n = G.UIT.R,
                                    config = { r = 0.1, colour = G.C.RED, minh = 0.75, minw = 2.8, align = "cm", hover = true, shadow = true },
                                    nodes = { {
                                        n = G.UIT.T, config = { text = "Special Thanks", colour = G.C.WHITE, scale = 0.5, hover = true, shadow = true }

                                    } }
                                },
                                    {
                                        n = G.UIT.R, config = { align = "cr"},
                                        nodes = { {
                                            n = G.UIT.T, config = { text = "Koishukaze", colour = HEX("DB8F00"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                        } }
                                    },
                                    {
                                        n = G.UIT.R, config = { align = "cr"},
                                        nodes = { {
                                            n = G.UIT.T, config = { text = "stickmancomic", colour = HEX("FF5555"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                        } }
                                    },
                                    {
                                        n = G.UIT.R, config = { align = "cr"},
                                        nodes = { {
                                            n = G.UIT.T, config = { text = "zqr_", colour = HEX("5f7377"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                        } }
                                    },
                                    {
                                        n = G.UIT.R, config = { align = "cr"},
                                        nodes = { {
                                            n = G.UIT.T, config = { text = "Lifeline / Messy Bookshelf", colour = HEX("FFD900"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                        } }
                                    },
                                    {
                                        n = G.UIT.R, config = { align = "cr"},
                                        nodes = { {
                                            n = G.UIT.T, config = { text = "Bentux", colour = HEX("3CFF00"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                        } }
                                    },
                                    {
                                        n = G.UIT.R, config = { align = "cr"},
                                        nodes = { {
                                            n = G.UIT.T, config = { text = "Hanya", colour = G.C.WHITE, emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                        } }
                                    },
                                    {
                                        n = G.UIT.R, config = { align = "cr"},
                                        nodes = { {
                                            n = G.UIT.T, config = { text = "The Balatro Discords", colour = HEX("9700BD"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                        } }
                                    },
                                    {
                                        n = G.UIT.R, config = { align = "cr"},
                                        nodes = { {
                                            n = G.UIT.T, config = { text = "...and you!", colour = G.C.DARK_EDITION, emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                        } }
                                    },
                                    {
                                        n = G.UIT.R, config = { align = "cr"},
                                        nodes = { {
                                            n = G.UIT.T, config = { text = "(...and more to come!)", colour = HEX("FFFFFF40"), emboss = 0.05, scale = 0.35, hover = true, shadow = true }

                                        } }
                                    }
                                }
                            } }
                    }

                    }
                }
            end,
        }
    }
end

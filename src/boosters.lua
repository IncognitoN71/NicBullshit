SMODS.Booster{
    key = 'teto_booster',
    loc_txt = {
        name = "Teto Pack",
        text= {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Teto{} cards",
        },
        group_name = {
            "Teto Pack"
        }
    },
    atlas = 'nicboosters',
    pos = {x = 0,y = 0},
    discovered = true,
    weight = 0,
    cost = 4,
    config = {
        extra = 3,
        choose = 1
    },
    loc_vars = function(self,info_queue,center)
        return {
            vars = {
                center.ability.choose,
                center.ability.extra
            }
        }
    end,
    create_card = function(self, card)
        ease_background_colour(HEX("000000"))
        play_sound("nic_tetoohmygodmypenis")
        return { 
            set = "tetojokers", 
            area = G.pack_cards,
        }
    end,
}

SMODS.ObjectType{
    key = "tetojokers",
    default = 'j_nic_kasanejokto',
    cards = {
        ['j_nic_kasanejokto'] = true,
        ['j_nic_ambassadorteto'] = true,
        ['j_nic_pear'] = true,
        ['j_nic_pearto'] = true,
    },
}
-- Common

SMODS.Joker{ -- Button
    key = "button",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'nicjokers',
    rarity = 1,
    cost = 3,
    pos = {x = 2, y = 1},
    config = { extra = { xmult = 0.05, odds = 100 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.xmult } }
    end,
    
    calculate = function(self, card, context)
        if context.key_press_space then
            if pseudorandom('j_nic_button') < G.GAME.probabilities.normal / card.ability.extra.odds then
                card:start_dissolve({G.C.RED})
                card:juice_up(10, 10)
                return { play_sound("nic_explosion"), message = "BOOM!", colour = G.C.RED }
            else
                card.ability.extra.xmult = (card.ability.extra.xmult) + 0.05
                card:juice_up(0.5, 0.5)
                return { play_sound("nic_click") }
            end
        end
        if context.key_press_d then
            card:juice_up(0.5, 0.5)
            return { play_sound("nic_duck") }
        end

        if context.joker_main then
            return { 
                xmult = card.ability.extra.xmult 
            }
        end
    end
}

SMODS.Joker{ -- Sly Cooper
    key = "slycooper",
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'nicjokers',
    rarity = 1,
    cost = 3,
    pos = {x = 3, y = 1},
    config = { extra = { oldshopsize = 3, slycooper_remaining = 1, odds = 4 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { 
            (G.GAME and G.GAME.probabilities.normal or 1), 
            card.ability.extra.odds, 
            localize { type = 'variable', key = (card.ability.extra.slycooper_remaining == 0 and 'nic_slycooper_active' or 'nic_slycooper_inactive'), vars = { card.ability.extra.slycooper_remaining } }, 
            card.ability.extra.oldshopsize } 
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.slycooper_remaining = 0
            return { message = "ACTIVE!", colour = G.C.RED }
        end
        if card.ability.extra.slycooper_remaining == 0 then
            if (context.buying_card or context.nic_buying_booster or context.nic_buying_voucher) and context.card.cost > 0 then
                card.ability.extra.slycooper_remaining = 1
                if pseudorandom('j_nic_button') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    context.card.cost = context.card.cost * 2
                    SMODS.calculate_effect({
                        message = 'CAUGHT!',
                        colour = G.C.RED,
                        play_sound('nic_metalalert'),
                    },context.card)
                else 
                    context.card.cost = 0
                    SMODS.calculate_effect({
                        message = 'SNATCH!',
                        colour = G.C.GREEN,
                    },context.card)
                end
            end
        end
    end
}

-- Uncommon

SMODS.Joker{ -- Kasane Jokto
    key = "kasanejokto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'nicjokers',
    rarity = 2,
    cost = 5,
    pos = {x = 3, y = 0},
    config = { extra = { repetitions = 9 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if context.other_card:get_id() == 2 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.repetitions,
                    card = card,
                }
            end
        end
    end
}

-- Rare

SMODS.Joker{ -- Technoblade
    key = "technoblade",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 2, y = 0},
    config = { extra = { mult = 0, chips = 0, scoreReq = 50 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.scoreReq } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].ability.eternal and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.mult = card.ability.extra.mult + sliced_card.sell_cost * 3
                        card.ability.extra.chips = card.ability.extra.chips + sliced_card.sell_cost * 4
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                return { message = "THE BLADE", colour = G.C.RED }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end

        if context.end_of_round and context.game_over and context.main_eval then
            if to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big(card.ability.extra.scoreReq / 100) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('nic_technoblade')
                        card:start_dissolve()
                        return true
                    end
                }))
                return {
                    message = "TECHNOBLADE NEVER DIES!",
                    saved = 'ph_nic_technoblade',
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker{ -- Stalagmite
    key = "stalagmite",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 4, y = 1},
    config = { extra = { chips = 50, mult = 50, extra = 2 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone

        local stone_tally = 0
        if G.hand then
            if G.hand.cards then
                for _, v in ipairs(G.hand.cards) do
                    if SMODS.has_enhancement(v, 'm_stone') then stone_tally = stone_tally + 1 end
                end
            end
        end
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.chips * stone_tally, card.ability.extra.mult * stone_tally, card.ability.extra } }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                card.ability.extra.chips = card.ability.extra.chips + 25
                card.ability.extra.mult = card.ability.extra.mult + 25
                local other_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        other_card:juice_up()
                        other_card:set_edition('e_negative')
                        play_sound("nic_dripstone")
                        return true
                    end
                }))
            end
        end

        if context.individual and context.cardarea == "unscored" and G.GAME.current_round.hands_left == 0 then
            local other_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    other_card:juice_up()
                    other_card:set_ability('m_stone')
                    play_sound("nic_dripstone")
                    return true
                end
            }))
        end

        if context.joker_main then
            local stone_tally = 0
            for _, v in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(v, 'm_stone') then stone_tally = stone_tally + 1 end
            end
            return {
                chips = card.ability.extra.chips * stone_tally,
                mult = card.ability.extra.mult * stone_tally
            }
        end
    end
}

SMODS.Joker{ -- Machinedramon
    key = "machinedramon",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 4, y = 0},
    config = { extra = { mult = 0, xmult = 1, odds = 4 } },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.mult, card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[1] and not context.blueprint and G.GAME.current_round.hands_left == 0 then
			for k, v in ipairs(G.hand.cards) do
				v:set_ability('m_steel', nil, true)
				G.E_MANAGER:add_event(Event({
					func = function()
						v:juice_up()
                        play_sound("nic_machinedramon")
						return true
					end
				}))
			end
		end

        if context.individual and context.cardarea == G.play and not context.end_of_round and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, 'm_steel') then
                context.other_card.should_destroy = true
                card.ability.extra.mult = (card.ability.extra.mult) + 15
                card.ability.extra.xmult = (card.ability.extra.xmult) + 0.5
                return { message = "ASSEMBLE!", colour = G.C.BLACK }
            end
        end

        if context.joker_main then
            return { 
                mult = card.ability.extra.mult, 
                xmult = card.ability.extra.xmult 
            }
        end
	end
}

-- Legendary

SMODS.Joker{ -- Incognito
    key = "incognito",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'nicjokers',
    rarity = 4,
    cost = 20,
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = { extra = { xmult = 1, odds = 7 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.xmult } }
    end,
    
    calculate = function(self, card, context)
        if context.cry_press and card.states.hover.is == true then
            card.ability.extra.xmult = (card.ability.extra.xmult) + 1
        end
            
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            if not (context.other_card:is_suit("Spades")) then
                if pseudorandom('j_nic_incognito') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    context.other_card.should_destroy = true
                    card.ability.extra.xmult = (card.ability.extra.xmult) + 1
                    return { message = "SWOON!", colour = HEX("d0d0d0") }
                else
                    return { message = "NOPE!", colour = G.C.BLACK }
                end
            end
        end  
        
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit("Spades") then
                return {
                    message = "71!", 
                    colour = HEX("d0d0d0"),
                    xmult = card.ability.extra.xmult,  
                }
            end
        end
    end
}
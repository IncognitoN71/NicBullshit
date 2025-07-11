SMODS.current_mod.set_debuff = function(card)
    if next(SMODS.find_card("j_nic_incognito")) and card.playing_card and card:is_suit("Spades") then
        return "prevent_debuff"
    end
end

-- card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "71!", colour = HEX("d0d0d0")})

-- Common

SMODS.Joker{ -- Button
    key = "button",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'nicjokers',
    rarity = 1,
    cost = 3,
    pos = {x = 2, y = 1},
    config = { extra = { xmult = 0.01, odds = 1000 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.xmult } }
    end,
    
    calculate = function(self, card, context)
        if context.cry_press and card.states.hover.is == true then
            if pseudorandom('j_nic_button') < G.GAME.probabilities.normal / card.ability.extra.odds then
                card.ability.extra.xmult = 0.01
                card:juice_up(10, 10)
                return { play_sound("nic_explosion") }
            else
                card.ability.extra.xmult = (card.ability.extra.xmult) + 0.01
            end
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
    discovered = false,
    atlas = 'nicjokers',
    rarity = 1,
    cost = 3,
    pos = {x = 3, y = 1},
    config = { extra = { rerolls = 1, slycooper_remaining = 1 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { localize { type = 'variable', key = (card.ability.extra.slycooper_remaining == 0 and 'nic_slycooper_active' or 'nic_slycooper_inactive'), vars = { card.ability.extra.slycooper_remaining } }, card.ability.extra.rerolls } }
    end,

    add_to_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(card.ability.extra.rerolls)
    end,

    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(-card.ability.extra.rerolls)
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.slycooper_remaining = 0
        end
        if card.ability.extra.slycooper_remaining == 0 and context.buying_card and context.card.cost > 0 then
            card.ability.extra.slycooper_remaining = 1
            context.card.cost = 0
            return { message = "SNATCH!", colour = G.C.RED }
        end
    end
}

-- Uncommon

SMODS.Joker{ -- Kasane Jokto
    key = "kasanejokto",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
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
    discovered = false,
    atlas = 'nicjokers',
    rarity = 3,
    cost = 8,
    pos = {x = 2, y = 0},
    config = { extra = { mult = 0, chips = 0, scoreReq = 50 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.scoreReq } }
    end,

    calculate = function(self, card, context)
        if not to_big then
            function to_big(x) return x end
        end
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

SMODS.Joker{ -- Machinedramon
    key = "machinedramon",
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
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
    discovered = false,
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

local lcpref = Controller.L_cursor_press -- Cryptid
function Controller:L_cursor_press(x, y)
    lcpref(self, x, y)
    if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
        SMODS.calculate_context({ cry_press = true })
    end
end
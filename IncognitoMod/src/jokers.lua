SMODS.current_mod.set_debuff = function(card)
    if next(SMODS.find_card("j_nic_incognito")) and card.playing_card and card:is_suit("Spades") then
        return "prevent_debuff"
    end
end

SMODS.Joker{ -- Incognito
    name = "Incognito",
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
        if context.destroy_card and context.destroy_card.should_destroy and not context.blueprint then
            return { remove = true }
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            if pseudorandom('j_nic_incognito') < G.GAME.probabilities.normal / card.ability.extra.odds then
                if not (context.other_card:is_suit("Spades")) then
                    context.other_card.should_destroy = true
                    card.ability.extra.xmult = (card.ability.extra.xmult) + 1
                    return { message = "SWOON!", colour = HEX("d0d0d0") }
                end
            else
                if not (context.other_card:is_suit("Spades")) then
                    return { message = "NOPE!", colour = G.C.BLACK }
                end
            end
        end  
        
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit("Spades") then
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "71!", colour = HEX("d0d0d0")})
                return { xmult = card.ability.extra.xmult }
            end
        end
    end
}

SMODS.Joker{ -- Technoblade
    name = "Technoblade",
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
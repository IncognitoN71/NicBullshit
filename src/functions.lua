SMODS.current_mod.set_debuff = function(card) -- Debuff
    if next(SMODS.find_card("j_nic_incognito")) and card.playing_card and card:is_suit("Spades") then
        return "prevent_debuff"
    end
    if next(SMODS.find_card("j_nic_doctorkidori")) and card.playing_card and card:get_id() == 4 then
        return "prevent_debuff"
    end
end

to_big = to_big or function(num)
    return num
end

local getidref = Card.get_id -- Cards are Considered Rank
function Card:get_id()
	if not getiduse then
		getiduse = true
		local id = getidref(self) or self.base.id
		if next(SMODS.find_card('j_nic_doctorkidori')) and id >= 2 then id = 4 end
		getiduse = false
		return id
	else
		getiduse = false
		return getidref(self)
	end
end

nic = {} -- Vouchers/Boosters

function nic_ctx(context)
    if context.nic_buying_voucher then return 'buy a voucher' end
    if context.nic_buying_booster then return 'buy a booster pack' end
end

nic.hooks = {}

nic.hooks.Card_open = Card.open
function Card:open()
    if self.ability.set == "Booster" then
        SMODS.calculate_context({nic_buying_booster = true, card = self})
    end
    return nic.hooks.Card_open(self)
end

nic.hooks.Card_redeem = Card.redeem
function Card:redeem()
    if self.ability.set == "Voucher" then
        SMODS.calculate_context({nic_buying_voucher = true, card = self})
    end
    return nic.hooks.Card_redeem(self)
end

local lcpref = Controller.L_cursor_press -- Cryptid
function Controller:L_cursor_press(x, y)
    lcpref(self, x, y)
    if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
        SMODS.calculate_context({ cry_press = true })
    end
end

local nicmodpress = love.keypressed
function love.keypressed(key)
    if key == "space" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_space = true })
        end
    end
    if key == "d" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_d = true })
        end
    end
    if key == "f1" then
        if G and G.jokers and G.jokers.cards and not G.SETTINGS.paused then
            SMODS.calculate_context({ key_press_f1 = true })
        end
    end
    return (nicmodpress(key))
end

-- card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "71!", colour = HEX("d0d0d0")})
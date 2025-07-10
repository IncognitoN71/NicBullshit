SMODS.Challenge { -- OOPS? ALL SWOONS!
    key = 'incognito',
    rules = {
        custom = {
            { id = "nic_incognito1" },
            { id = "nic_incognito2" },
            { id = "nic_incognito3" }
        },
        modifiers = {
            { id = 'joker_slots', value = 3 },
            { id = 'hands', value = 3 },
        },
    },
    jokers = {
        { id = 'j_nic_incognito', eternal = true, edition = 'negative' },
        { id = 'j_oops', eternal = true, edition = 'negative' },
        { id = 'j_oops', eternal = true, edition = 'negative' },
        { id = 'j_oops', eternal = true, edition = 'negative' },
    },
    restrictions = {
        banned_cards = {
            { id = 'j_gros_michel' },
            { id = 'j_cavendish' },
            { id = 'j_8_ball' },
            { id = 'j_business' },
            { id = 'j_space' },
            { id = 'j_hallucination' },
            { id = 'j_reserved_parking' },
            { id = 'j_lucky_cat' },
            { id = 'j_bloodstone' },
            { id = 'c_wheel_of_fortune' },
            { id = 'c_temperance' },
            { id = 'c_soul' },
        }
    },
    deck = {
        cards = {
            { s = 'C', r = 'A' },
            { s = 'D', r = 'A' },
            { s = 'H', r = 'A' },
            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'C', r = 'Q' },
            { s = 'D', r = 'Q' },
            { s = 'H', r = 'Q' },
            { s = 'C', r = 'J' },
            { s = 'D', r = 'J' },
            { s = 'H', r = 'J' },
            { s = 'C', r = 'T' },
            { s = 'D', r = 'T' },
            { s = 'H', r = 'T' },
            { s = 'C', r = '9' },
            { s = 'D', r = '9' },
            { s = 'H', r = '9' },
            { s = 'C', r = '8' },
            { s = 'D', r = '8' },
            { s = 'H', r = '8' },
            { s = 'C', r = '7' },
            { s = 'D', r = '7' },
            { s = 'H', r = '7' },
            { s = 'C', r = '6' },
            { s = 'D', r = '6' },
            { s = 'H', r = '6' },
            { s = 'C', r = '5' },
            { s = 'D', r = '5' },
            { s = 'H', r = '5' },
            { s = 'C', r = '4' },
            { s = 'D', r = '4' },
            { s = 'H', r = '4' },
            { s = 'C', r = '3' },
            { s = 'D', r = '3' },
            { s = 'H', r = '3' },
            { s = 'C', r = '2' },
            { s = 'D', r = '2' },
            { s = 'H', r = '2' },
        }
    }
}

SMODS.Challenge { -- THE FUTURE WILL BE PAVED WITH METAL!
    key = 'machinedramon',
    rules = {
        custom = {
            { id = "nic_machinedramon1" },
        },
        modifiers = {
            { id = 'joker_slots', value = 6 },
            { id = 'hands', value = 2 },
            { id = 'discards', value = 5 },
            { id = 'hand_size', value = 12 },
        },
    },
    jokers = {
        { id = 'j_nic_machinedramon', eternal = true },
    },
    restrictions = {
        banned_cards = {
            { id = 'j_abstract' },
            { id = 'j_midas_mask' },
            { id = 'j_ticket' },
            { id = 'c_devil' },
        }
    }
}
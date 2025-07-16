return {
    descriptions = {
        Back={},
        Blind={
            bl_nic_monarch = {
                name = "The Monarch",
                text = {
                    "Fuck Your Kings",
                }
            }
        },
        Edition={},
        Enhanced={},
        Joker = {
            j_nic_incognito = {
                name = "Incognito",
                text = {
                    {"Each Non {C:spades}Spades{} Suits held in hand",
                    "have a {C:green}#1# in #2#{} chance to be",
                    "Destroyed and Gains {X:mult,C:white}X1{}"},
                    {"{C:spades}Spades{} Can't Be Debuffed"},
                    {"Each {C:spades}Spades{} held in hand Give",
                    "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)"},
                }
            },
            j_nic_technoblade = {
                name = "Technoblade",
                text = {
                    {"Prevents Death if chips scored",
                    "are at least {C:attention}50%{} of required chips ",
                    "{S:1.1,C:red,E:2}self destructs{}"},
                    {"Plays {C:red}Pigstep{} by {C:attention}Lena Raine{}"},
                    {"When {C:attention}Blind{} is selected, destroy",
                    "Joker to the right and permanently",
                    "Gains {C:attention}triple{} its sell value to {C:mult}Mult",
                    "Gains {C:attention}quadruple{} its sell value to {C:chips}Chips",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"},
                }
            },
            j_nic_kasanejokto = {
                name = "Kasane Jokto",
                text = {
                    "{C:attention}Retrigger{} played {C:attention}2s{}",
                    "an additional {C:attention}nine{} times"
                }
            },
            j_nic_machinedramon = {
                name = "Machinedramon",
                text = {
                    {"All cards held in hand turn into",
                    "{C:attention}Steel cards{} on {C:attention}final hand{} of round"},
                    {"Played {C:attention}Steel cards{} get ",
                    "Destroyed and Gains",
                    "{C:mult}+15{} Mult and {X:mult,C:white}X0.5{} Mult",
                    "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult)",
                    "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"},
                }
            },
            j_nic_button = {
                name = "Button",
                text = {
                    {"When {C:attention}Clicked or Space{} is Pressed,",
                    "Gains {X:mult,C:white}X0.05{} Mult",
                    "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult}"},
                    {"{C:attention}Button{} has a {C:green}#1# in #2#{} chance",
                    "to delete itself :3"},
                }
            },
            j_nic_slycooper = {
                name = "Sly Cooper",
                text = {
                    {"+1 Extra {C:attention}Shop{} Slot"},
                    {"When {C:attention}Blind{} is defeated, Buy",
                    "{C:attention}One Item{} for {C:green}Free{} in the {C:attention}Shop{},",
                    "{C:green}#1# in #2#{} chance you get",
                    "{C:red}Caught{} and {C:attention}Pay Double{}",
                    "{C:inactive}(Currently: #3#)"},
                }
            },
            j_nic_stalagmite = {
                name = "Stalagmite",
                text = {
                    {"{C:attention}Unscored cards{} in {C:attention}final hand{} of",
                    "round turn into {C:attention}Stone cards{}"},
                    {"Each played {C:attention}Stone card{}",
                    "turns {C:dark_edition}Negative{} and increases",
                    "{C:attention}Stalgamite{} {C:mult}Mult{} and {C:chips}Chips{} by",
                    "{C:mult}+25{} Mult and {C:chips}+25{} Chips"},
                    {"{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips",
                    "for each {C:attention}Stone card{} held in hand",
                    "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
                    "{C:inactive}(Currently {C:chips}+#4#{C:inactive} Chips)"},
                }
            },
            j_nic_ambassadorteto = {
                name = "Ambassador Teto",
                text = {
                    {"All cards held in hand",
                    "change {C:attention}suits{} in this order",
                    "{C:clubs}Clubs{} > {C:diamonds}Diamonds{} >",
                    "{C:spades}Spades{} > {C:hearts}Hearts{}",
                    "{C:inactive}(Stops at {C:hearts}Hearts{C:inactive})"},
                    {"All {C:hearts}Hearts{} held in",
                    "hand give {X:mult,C:white}X1.5{} Mult",
                    "All {C:attention}2{} of {C:hearts}Hearts{} held in",
                    "hand give {X:mult,C:white}X3{} Mult"},
                }
            },
            j_nic_pear = {
                name = "Pear",
                text = {
                    {"If played hand is a {C:attention}Pair{},",
                    "upgrades {C:attention}Pair{} by {C:attention}#1# level{}"},
                    {"{C:attention}Pear{} is destroyed",
                    "after triggering {C:attention}5{} times",
                    "{C:inactive}(#2# remaining)"},
                }
            },
            j_nic_pearto = {
                name = "Pearto",
                text = {
                    {"If played hand is a {C:attention}Pair{},",
                    "upgrades {C:attention}Pair{} by {C:attention}#1# levels{}"},
                    {"For every played {C:attention}Pair{},",
                    "gains {C:mult}+10{} Mult",
                    "For every {C:attention}level{} of {C:attention}Pair{},",
                    "gains {C:chips}+50{} Chips",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"},
                }
            }
        },
        Other={},
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={},
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={
            c_nic_incognito = "OOPS? ALL SWOONS!",
            c_nic_machinedramon = "THE FUTURE WILL BE PAVED WITH METAL!",
        },
        collabs={},
        dictionary={
            k_nic_incognito = "Incognito",
            k_nic_teto = "Teto",
            ph_nic_technoblade = "SAVED BY TECHNOBLADE NEVER DIES!",
        },
        high_scores={},
        labels={},
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={
            nic_slycooper_active = "Active!",
            nic_slycooper_inactive = "Inactive!",
        },
        v_text={
            ch_c_nic_incognito1 = {
                "You have {C:clubs}Clubs{}, {C:hearts}Hearts{}, {C:diamonds}Diamonds{}"
            },
            ch_c_nic_incognito2 = {
                "But you don't have any {C:spades}Spades{}"
            },
            ch_c_nic_incognito3 = {
                "Let's see how {C:spades}Incognito{} you are"
            },
            ch_c_nic_machinedramon1 = {
                "MACHINEDRAMON"
            },
        },
    },
}
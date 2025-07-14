SMODS.Rarity{
    key = "incognito",
    default_weight = 0,
    badge_colour = HEX("d0d0d0"),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "teto",
    pools = {
    ["Joker"] = true,
    },
    default_weight = 0.1,
    badge_colour = HEX('e15d73'), -- c73d54
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
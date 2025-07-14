SMODS.Atlas{ -- Jokers
    key = "nicjokers",
    path = "nicjokers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas{ -- Blinds
    key = "nicblinds",
    path = "nicblinds.png",
    px = 34,
    py = 34,
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
}

SMODS.Atlas{ -- Boosters
    key = 'nicboosters',
    path = 'nicboosters.png',
    px = 71,
    py = 96,
}

SMODS.Atlas { -- Modicon
  key = "modicon",
  px = 32,
  py = 32,
  path = "modicon.png" 
}

SMODS.Sound{ -- Black Knife
    key = "music_black_knife",
    path = "black_knife.ogg",
    select_music_track = function (self)
        return next(SMODS.find_card("j_nic_incognito")) and 1e10 or nil
    end,
    pitch = 1,
}

SMODS.Sound{ -- Pigstep
    key = "music_pigstep",
    path = "pigstep.ogg",
    select_music_track = function (self)
        return next(SMODS.find_card("j_nic_technoblade")) and 1e10 or nil
    end,
    pitch = 1,
}

SMODS.Sound{ -- Click
    key = "click",
    path = "click.ogg",
}

SMODS.Sound{ -- Dripstone
    key = "dripstone",
    path = "dripstone.ogg",
}

SMODS.Sound{ -- Duck
    key = "duck",
    path = "duck.ogg",
}

SMODS.Sound{ -- Explosion
    key = "explosion",
    path = "explosion.ogg",
}

SMODS.Sound{ -- Machinedramon
    key = "machinedramon",
    path = "machinedramon.ogg",
}

SMODS.Sound{ -- Metal Gear Solid Alert
    key = "metalalert",
    path = "metalalert.ogg",
}

SMODS.Sound{ -- Technoblade Never Dies
    key = "technoblade",
    path = "technoblade.ogg",
}

SMODS.Sound{ -- Teto Oh My God My Penis
    key = "tetoohmygodmypenis",
    path = "tetoohmygodmypenis.ogg",
}
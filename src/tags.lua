SMODS.Tag {
    key = 'legendary',
    config = {type = 'store_joker_create'},
    atlas = 'nictags',
    pos = { x = 0, y = 0 },
    apply = function(self, tag, context)
        if context.type == tag.config.type then
            local legendary_card = create_card('Joker', context.area, true, 1, nil, nil, nil, 'uta')
            create_shop_card_ui(legendary_card, 'Joker', context.area)
            legendary_card.states.visible = false
            tag:yep('+', G.C.PURPLE,function() 
                legendary_card:start_materialize()
                legendary_card:set_cost()
                return true
            end)
            tag.triggered = true
            return legendary_card
        end
    end
}
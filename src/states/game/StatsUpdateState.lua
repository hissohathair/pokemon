--[[
    GD50
    Pokemon
]]

StatsUpdateState = Class{__includes = BaseState}

function StatsUpdateState:init(items)
    
    self.statsMenu = Menu {
        x = VIRTUAL_WIDTH / 2,
        y = 2,
        width = VIRTUAL_WIDTH / 2,
        height = VIRTUAL_HEIGHT - 66,
        selectable = false,
        items = items
    }
end

function StatsUpdateState:update(dt)
    self.statsMenu:update(dt)
end

function StatsUpdateState:render()
    self.statsMenu:render()
end
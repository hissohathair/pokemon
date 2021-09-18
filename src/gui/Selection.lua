--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The Selection class gives us a list of textual items that link to callbacks;
    this particular implementation only has one dimension of items (vertically),
    but a more robust implementation might include columns as well for a more
    grid-like selection, as seen in many kinds of interfaces and games.
]]

Selection = Class{}

function Selection:init(def)
    self.items = def.items
    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width
    self.font = def.font or gFonts['small']

    self.gapHeight = self.height / #self.items

    -- By default, we allow selection of items - but can override
    self.selectable = true
    if def.selectable ~= nil then
        self.selectable = def.selectable
    end
    self.currentSelection = 1

    -- Only used if section entries are not selectable
    self.onClose = def.onClose
end

function Selection:update(dt)
    if self.selectable then
        if love.keyboard.wasPressed('up') then
            if self.currentSelection == 1 then
                self.currentSelection = #self.items
            else
                self.currentSelection = self.currentSelection - 1
            end
            
            gSounds['blip']:stop()
            gSounds['blip']:play()
        elseif love.keyboard.wasPressed('down') then
            if self.currentSelection == #self.items then
                self.currentSelection = 1
            else
                self.currentSelection = self.currentSelection + 1
            end
            
            gSounds['blip']:stop()
            gSounds['blip']:play()
        elseif love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
            self.items[self.currentSelection].onSelect()
            
            gSounds['blip']:stop()
            gSounds['blip']:play()
        end
    else
        if love.keyboard.wasPressed('return') then
            if self.onClose then
                self.onClose()
            else
                gStateStack:pop()
            end
        end
    end
end

function Selection:render()
    local currentY = self.y

    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - self.font:getHeight() / 2

        -- draw selection marker if we're at the right index
        if self.selectable then
            if i == self.currentSelection then
                love.graphics.draw(gTextures['cursor'], self.x - 8, paddedY)
            end
        end

        love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')

        currentY = currentY + self.gapHeight
    end
end
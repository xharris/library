local bump = require 'libs.bump'

return {
  name = 'isogrid',
  defaults = {
    tiles = {},
    left = nil,
    top = nil,
    right = nil,
    bottom = nil,
    world = function()
      return bump.newWorld()
    end,
  },
  render = function(self, children)
    children()
    local items, len = self.world:getItems()
    -- lg.setColor(1,0,0,0.7)
    -- for _, item in pairs(items) do 
    --   lg.rectangle('fill', self.world:getRect(item))
    -- end
  end
}
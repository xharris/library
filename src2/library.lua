local M
local IsoGrid = require 'isogrid'

local function getTileImage(name)
  return IMAGES[name], IMAGES['tile_base']:getWidth()/2, IMAGES['tile_base']:getHeight()/3
end

---@class Library 
---@field grid IsoGrid
M = class()

function M:init(name, size)
  local w, h = IMAGES['tile_base']:getWidth(), IMAGES['tile_base']:getHeight()
  self.grid = IsoGrid(TILE_W, TILE_H)

  for x = 0, size-1 do 
    for y = 0, size-1 do 
      self.grid:setTile(x, y, M.TILE.BLANK)
    end
  end

  self.grid:setTile(1, 1, M.TILE.BOX)
  self.grid:setTile(2, 1, M.TILE.BOX)
  self.grid:setTile(2, 0, M.TILE.BOX)
  self.grid:setTile(2, 3, M.TILE.BOX)
  self.grid:setTile(3, 3, M.TILE.BOX)
end

function M:update(dt)
  self.grid:update(dt)
end

function M:draw()
  -- draw tiles
  for tile in self.grid:tiles() do
    local px, py = tile.x, tile.y
    local img, imgOx, imgOy = getTileImage('tile_base')
    lg.draw(img, util.floor(px-imgOx), util.floor(py-imgOy))

    if tile.value == M.TILE.BOX then 
      local box_img = getTileImage('tile_bo')
      lg.draw(box_img, util.floor(px-imgOx), util.floor(py-imgOy) + (img:getHeight() - box_img:getHeight()))
    end

    if self.grid.hovered then 
      px, py = self.grid.hovered.x, self.grid.hovered.y
      lg.draw(IMAGES['tile_hovered'], util.floor(px-imgOx), util.floor(py-imgOy))
    end
  end
  -- self.grid:draw()
end

M.TILE = {
  BLANK = 'bl',
  BOX = 'bo'
}

return M
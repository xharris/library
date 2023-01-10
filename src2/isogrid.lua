---@class IsoGrid
local M

local astar = require 'libs.astar'

M = class {
  init = function(self, tileWidth, tileHeight, opts)
    self.tileWidth = tileWidth 
    self.tileHeight= tileHeight
    self.grid = {} --- z, y, x
    self.left = nil
    self.right = nil
    self.top = nil
    self.bottom = nil
    self.low = nil 
    self.high = nil
    self.hovered = nil
    opts = opts or {}
    self.hitboxSize = opts.hitboxSize or { w=tileWidth, h=tileHeight }
    self.hitboxOffset = opts.hitboxOffset or { x=0, y=tileHeight/2 }
  end,
  update = function(self, dt)
    -- get hovered tile
    local mx, my = push:toGame(love.mouse.getPosition())
    if mx and my then 
      mx, my = camera:toWorld(mx, my)
      self.hovered = self:getTileAt(mx, my)
    end
  end,
  draw = function(self)
    lg.push('all')
    local mx, my = push:toGame(love.mouse.getPosition())
    if mx and my then 
      mx, my = camera:toWorld(mx, my)
      lg.setColor(0,1,0)
      lg.origin()
      lg.circle('fill',mx,my,3)
      local tile = self.hovered
      if tile then 
        lg.circle('line', tile.x, tile.y, 3)
      end
    end
    lg.pop()
  end,  
  tiles = function(self)
    local y = self.top
    local x = self.left-1
    local h = self.low
    return function()
      x = x + 1
      if x > self.right then 
        x = self.left
        y = y + 1
        if y > self.bottom then 
          h = h + 1
        end
      end
      return self:getTile(x, y, h)
    end
  end,
  setTile = function(self, x, y, value, height)
    height = height or 0
    -- make sure tables exist
    if not self.grid[height] then 
      self.grid[height] = {}
    end
    if not self.grid[height][y] then 
      self.grid[height][y] = {}
    end
    -- get tile index
    local tile 
    if not self.grid[height][y][x] then 
      self.grid[height][y][x] = {}
    end
    tile = self.grid[height][y][x]
    tile.ix, tile.iy = x, y
    tile.x, tile.y = self:getTilePosition(x, y, height)
    tile.value = value
    tile.height = height
    -- resize bounds
    if self.low == nil or height < self.low then self.low = height end 
    if self.high == nil or height > self.high then self.high = height end
    if self.left == nil or x < self.left then self.left = x end 
    if self.right == nil or x > self.right then self.right = x end 
    if self.top == nil or y < self.top then self.top = y end 
    if self.bottom == nil or y > self.bottom then self.bottom = y end
  end,
  getTile = function(self, ix, iy, height)
    height = height or 0
    -- print(ix, iy, 'in', self.left, self.top, self.right, self.bottom)
    if self.grid[height] and self.grid[height][iy] then 
      return self.grid[height][iy][ix]
    end
  end,
  getTileAt = function(self, x, y)
    x, y = M.positionToIndex(
      x + self.hitboxOffset.x, 
      y + self.hitboxOffset.y, 
      self.hitboxSize.w, 
      self.hitboxSize.h
    )
    return self:getTile(x, y)
  end,
  getTilePosition = function(self, ix, iy, height)
    height = height or 0 
    local x, y = M.indexToPosition(ix, iy, self.tileWidth, self.tileHeight)
    return x, y + (height * self.tileHeight)
  end,
  getPath = function(self, from, to)
    local grid = self

    local map = {
      cached = {},
      get_node = function(self, x, y)
        if not self.cached[y] then
          self.cached[y] = {}
        end
        if not self.cached[y][x] then
          self.cached[y][x] = { x=x, y=y, tile=grid:getTile(x, y, from.height) }
        end
        return self.cached[y][x]
      end,
      check = function(self, x, y)
        local tile = grid:getTile(x, y, from.height)
        return x >= grid.left and x <= grid.right and y >= grid.top and y <= grid.bottom and tile.value ~= 'bo'
      end,
      get_neighbors = function(self, node, _, add)
        local nodes = {}
        local x, y
        for ox = -1, 1 do 
          for oy = -1, 1 do 
            x, y = node.x + ox, node.y + oy
            -- is the next tile walkable?
            if self:check(x, y) then 
              -- only move diagonally if the path is not between 2 blocks
              if ox ~= 0 and oy ~= 0 then
                if self:check(node.x + ox, node.y) and self:check(node.x, node.y + oy) then
                  add(self:get_node(x, y))
                end
              else
                add(self:get_node(x, y))
              end

            end
          end
        end
        return nodes
      end,
      get_cost = function(self, from, to)
        local cost = util.distance(from, to)
        return cost 
      end,
      estimate_cost = function(self, node, goal)
        return self:get_cost(node, goal)
      end
    }

    local finder = astar.new(map)
    return finder:find(
      map:get_node(from.x, from.y),
      map:get_node(to.x, to.y)
    ) or {}
  end
}

function M.indexToPosition(x, y, tile_width, tile_height)
  tile_width, tile_height = tile_width/2, tile_height/2
  return (x - y) * tile_width, -- x 
         (x + y) * tile_height -- y
end

function M.positionToIndex(x, y, tile_width, tile_height)
  return math.floor((y + x / 2) / tile_height),
         math.floor((y - x / 2) / tile_height)
end

return M
local bump = require 'libs.bump'
local luastar = require 'libs.lua-star'
local astar = require 'libs.astar'

return {
  name = 'isogrid',
  defaults = {
    tiles = {},
    left = nil,
    top = nil,
    right = nil,
    bottom = nil,
    current = nil,
    highest = nil,
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
  end,
  getTile = function(grid, x, y, h)
    return grid.tiles[h] and grid.tiles[h][x] and grid.tiles[h][x][y]
  end,
  getPath = function(start, dest)
    local grid = start.parent 
    
    local map = {
      cached = {},
      get_node = function(self, x, y)
        if not self.cached[y] then
          self.cached[y] = {}
        end
        if not self.cached[y][x] then 
          self.cached[y][x] = { x=x, y=y, tile=grid.tiles[start.height][y][x]  }
        end
        return self.cached[y][x]
      end,
      get_neighbors = function(self, node, from, add)
        local nodes = {}
        for x = node.x-1, node.x+1 do 
          for y = node.y-1, node.y+1 do 
            if x >= grid.left and x <= grid.right and 
              y >= grid.top and y <= grid.bottom and 
              grid.tiles[start.height][y][x].type ~= 'b' then 
                add(self:get_node(x, y))
            end
          end 
        end
        -- print(x2d.lume.serialize(nodes))
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
      map:get_node(start.index[3], start.index[2]),
      map:get_node(dest.index[3], dest.index[2])
    ) or {}
  end
}
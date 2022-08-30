return function()
  for _, grid in x2d.entity.isogrid:all() do 
    for f, upd in ipairs(grid.updates) do 
      local tx, ty = upd.x, upd.y
      -- resize grid?
      if tx < grid.left then grid.left = tx end 
      if tx > grid.right then grid.right = tx end 
      if ty < grid.top then grid.top = ty end 
      if ty > grid.bottom then grid.bottom = ty end
            
      local x = (tx + ty) * (TILE_SIZE / 2)
      local y = (ty - tx) * (TILE_SIZE / 4)
      local tile
      -- new tile? (yes, y and x are flipped)
      if not grid.tiles[ty] or not grid.tiles[ty][tx] then 
        local tile = x2d.entity.isotile(upd)
        if not grid.tiles[ty] then 
          grid.tiles[ty] = {}
        end
        grid.tiles[ty][tx] = tile
        grid:add(tile)
      end
      tile = grid.tiles[ty][tx]
      tile.x = x 
      tile.y = y      
    end
    grid.updates = {}
  end
end
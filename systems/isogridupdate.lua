return function()
  for _, grid in x2d.entity.isogrid:all() do 
    for f, upd in ipairs(grid.updates) do 
      local tx, ty, h = upd.x, upd.y, upd.height or 0
      local tile
      if grid.tiles[ty] and grid.tiles[ty][tx] then 
        -- tile exists? (yes, y and x are flipped)
        tile = grid.tiles[ty][tx]
        upd.x = nil 
        upd.y = nil 
        x2d.lume.extend(tile, upd)
        print('update',tile._id,tile.type, tile.height, upd.height)
      else 
        -- create new tile
        tile = x2d.entity.isotile(upd)
        tx, ty = upd.x, upd.y
        if not grid.tiles[ty] then 
          grid.tiles[ty] = {}
        end
        grid:add(tile)
      end
      grid.tiles[ty][tx] = tile
      -- resize grid?
      if tx < grid.left then grid.left = tx end 
      if tx > grid.right then grid.right = tx end 
      if ty < grid.top then grid.top = ty end 
      if ty > grid.bottom then grid.bottom = ty end
            
      local x = (tx + ty) * (TILE_SIZE / 2)
      local y = (ty - tx) * (TILE_SIZE / 4) + (tile.height * (TILE_SIZE/4))
      
      tile.x = x 
      tile.y = y   
    end
    grid.updates = {}
  end
end
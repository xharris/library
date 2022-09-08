return function()
  local tile_w, tile_h = TILE_SIZE, TILE_SIZE / 2
  local img_w, img_h = IMAGES['tile_base']:getWidth(), IMAGES['tile_base']:getHeight()

  for u, upd in x2d.entity.isogridupdate:all() do 
    local grid = upd.isogrid 

    local tx, ty, h = upd.x, upd.y, upd.height or 0
    local tile
    if grid.tiles[ty] and grid.tiles[ty][tx] then 
      -- tile exists? (yes, y and x are flipped)
      tile = grid.tiles[ty][tx]
      tile:copy(upd)
    else 
      -- create new tile
      tile = x2d.entity.isotile(upd)
      if not grid.tiles[ty] then 
        grid.tiles[ty] = {}
      end
      grid:add(tile)
      -- add it to bump world 
      grid.world:add(tile, 0, 0, 
        img_w,
        img_h
      )
    end
    grid.tiles[ty][tx] = tile
    -- resize grid?
    if grid.left == nil or tx < grid.left then grid.left = tx end 
    if grid.right == nil or tx > grid.right then grid.right = tx end 
    if grid.top == nil or ty < grid.top then grid.top = ty end 
    if grid.bottom == nil or ty > grid.bottom then grid.bottom = ty end
          
    -- local x = (tx + ty) * tile_w
    -- local y = (ty - tx) * tile_h

    local x, y = util.toIso(tx, ty, tile_w, tile_h)
    
    tile.index = {ty, tx}
    tile.x = x 
    tile.y = y + (tile.height * tile_h)
    tile:z(y)
    
    grid.world:update(
      tile, 
      tile.x - (img_w/2), 
      tile.y - (img_h/2)
    )
    x2d.entity.destroy(upd)
  end
end
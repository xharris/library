return function()
  local tile_w, tile_h = TILE_SIZE, TILE_SIZE / 2
  local img_w, img_h = IMAGES['tile_base']:getWidth(), IMAGES['tile_base']:getHeight()

  for u, upd in x2d.entity.isogridupdate:all() do 
    local grid = upd.isogrid 

    local tx, ty, h = upd.x, upd.y, upd.height or 0
    local tile
    if not grid.tiles[h] then 
      grid.tiles[h] = {}
    end
    if grid.tiles[h][ty] and grid.tiles[h][ty][tx] then 
      -- tile exists? (yes, y and x are flipped)
      tile = grid.tiles[h][ty][tx]
      tile.type = upd.type
    else 
      -- create new tile
      tile = x2d.entity.isotile(upd)
      if not grid.tiles[h][ty] then 
        grid.tiles[h][ty] = {}
      end
      -- add it to bump world 
      grid.world:add(tile, 0, 0, 
        img_w,
        img_h
      )
    end
    grid:add(tile)
    grid.tiles[h][ty][tx] = tile
    -- resize grid?
    if grid.left == nil or tx < grid.left then grid.left = tx end 
    if grid.right == nil or tx > grid.right then grid.right = tx end 
    if grid.top == nil or ty < grid.top then grid.top = ty end 
    if grid.bottom == nil or ty > grid.bottom then grid.bottom = ty end
     
    tile.index = {h, ty, tx}
    local x, y = util.toIso(tx, ty, tile_w, tile_h)
    
    tile.x = x 
    tile.y = y + (tile.height * tile_h)
    tile:z(tile.y)

    tile.origy = tile.y
    
    grid.world:update(
      tile, 
      tile.x - (img_w/2), 
      tile.y - (img_h/2)
    )
    x2d.entity.destroy(upd)
  end
end
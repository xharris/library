return function()
  local tile_w, tile_h = TILE_SIZE, TILE_SIZE / 2
  local size = TILE_SIZE / 2
  local img = IMAGES['tile_hovered']
  -- reset hover state
  for _, tile in x2d.entity.isotile:all() do 
    tile.isHovered = false
  end
  -- get currently hovered tile
  local mx, my = x2d.mousePosition()
  if mx and my then 

    for _, grid in x2d.entity.isogrid:all() do 
      local lib = grid.parent
      grid.offsetX = -lib.camera.x
      grid.offsetY = -lib.camera.y

      mx = mx + grid.offsetX
      my = my + grid.offsetY

      local items, len = grid.world:queryPoint(mx, my)
      local hoveredItem 
      for _, item in ipairs(items) do 
        local x, y = util.toIsoIndex(
          mx, my - (item.height * tile_h),
          tile_w, tile_h
        )
        -- isometric hitbox
        if (not hoveredItem or item.height < hoveredItem.height) and x == item.index[2] and y == item.index[3] then 
          hoveredItem = item
        end
      end
      if hoveredItem then 
        hoveredItem.isHovered = true
      end
    end
  end

  -- for _, lib in x2d.entity.library:all() do 
  --   local mx, my = x2d.mousePosition()
  --   if mx and my then 
  --     mx, my = mx - lib.camera.x, my - lib.camera.y
  --     local ty = my - mx/2 - size + (img:getHeight()/3)
  --     local tx = mx + ty + (img:getWidth()/2)
  --     local y = math.ceil(-ty/size) - 1
  --     local x = math.ceil(tx/size) 
  --     lib.hoveredTile = {
  --       x = x,
  --       y = y
  --     }
  --   else 
  --     lib.hoveredTile = nil
  --   end
  -- end
end
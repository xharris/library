return function()
  local size = TILE_SIZE / 2
  local img = IMAGES['tile_hovered']
  for _, lib in x2d.entity.library:all() do 
    local mx, my = x2d.mousePosition()
    if mx and my then 
      mx, my = mx - lib.camera.x, my - lib.camera.y
      local ty = my - mx/2 - size + (img:getHeight()/3)
      local tx = mx + ty + (img:getWidth()/2)
      local y = math.ceil(-ty/size) - 1
      local x = math.ceil(tx/size) 
      lib.hoveredTile = {
        x = x,
        y = y
      }
    else 
      lib.hoveredTile = nil
    end
  end
end
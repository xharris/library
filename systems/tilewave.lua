local t = 0

function sys(dt)
  local mx, my = x2d.mousePosition()
  local w = x2d.getWidth()
    
  t = t + 10 * dt
  local grid 
  for _, tile in x2d.entity.isotile:all() do 
    x2d.entity.isotile.setElevation(tile, math.ceil(math.sin((t + tile.x)/2.85)*3))
  end
end

-- return sys
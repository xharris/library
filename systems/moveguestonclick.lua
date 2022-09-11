return function(dt)
  local moveTo
  for _, tile in x2d.entity.isotile:all() do 
    if tile.isHovered and love.mouse.isDown(1) and not down then 
      down = true 
      moveTo = tile
    end
    if not love.mouse.isDown(1) then 
      down = false
    end
  end

  for _, guest in x2d.entity.guest:all() do 
    if moveTo then 
      x2d.entity.guest.goTo(guest, moveTo)
    end
  end
  moveTo = nil
end
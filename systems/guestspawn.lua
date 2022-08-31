local t = 0

return function(dt)
  t = t - dt
  for _, lib in x2d.entity.library:all() do 
    if t < 0 then 
      -- get entrance
      for _, tile in x2d.entity.isotile:all() do 
        if tile.type == 'e' and tile.parent.parent == lib then 
          -- spawn a guest 
          local guest = x2d.entity.guest{ x=tile.x, y=tile.y }
          print(guest.x, guest.y)
          lib:add(guest)
        end
      end
      t = 10000000  
    end
  end
end
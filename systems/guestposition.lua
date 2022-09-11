local down = false 

return function(dt)
  for _, guest in x2d.entity.guest:all() do 
    if guest.tile then 
      guest.x = guest.tile.x 
      guest.y = guest.tile.y + (guest.tile.height * TILE_H)
    end
  end
end
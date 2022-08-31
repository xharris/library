return {
  enter = function()
    local lib = x2d.entity.library{ name='NYPL', camera={ x=lg.getWidth()/2, y=lg.getHeight()/2 } }
    local floor = x2d.entity.isogrid()
    lib:add(floor)
    lib.floor[lib.floorFocused] = floor

    local size = 10
    for x = -size, size do 
      for y = -size, size do 
        local h = 0 -- size - x
        x2d.lume.push(floor.updates, { x=x, y=y, height=h })
      end
    end
    x2d.lume.push(floor.updates, {
      x = -10, y = -10,
      type = 'e'
    })
    x2d.lume.push(floor.updates, {
      x = 1, y = 1,
      type = 'b'
    })
  end
}
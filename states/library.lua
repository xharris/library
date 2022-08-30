return {
  enter = function()
    local lib = x2d.entity.library{ name='NYPL', camera={ x=lg.getWidth()/2, y=lg.getHeight()/2 } }
    local floor = x2d.entity.isogrid()
    lib.floor[lib.floorFocused] = floor

    for i = 1, 20 * 20 do 
      local tx, ty = util.to2d(i, 20)
      x2d.lume.push(floor.updates, { x=tx-10, y=ty-10, type='a' })
    end
  end
}
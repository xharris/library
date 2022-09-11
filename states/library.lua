return {
  enter = function()
    local lib = x2d.entity.library{ 
      name='NYPL', 
      camera={ x=lg.getWidth()/2, y=lg.getHeight()/2 } 
    }
    local grid = x2d.entity.isogrid()
    lib:add(grid)
    lib.grid = grid

    local size = 20
    size = size/2
    for x = -size, size do 
      for y = -size, size do 
        local h = 0 -- -(size - x)
        x2d.entity.isotile.new{ isogrid=grid, x=x, y=y, height=h }
      end
    end
    x2d.entity.isotile.new{
      isogrid=grid, 
      x = -size, y = -size,
      type = 'e'
    }
    x2d.entity.isotile.new{
      isogrid=grid,
      x = 1, y = 1,
      type = 'b'
    }
    x2d.entity.isotile.new{
      isogrid=grid,
      x = 2, y = 1,
      type = 'b'
    }
    x2d.entity.isotile.new{
      isogrid=grid,
      x = 2, y = 0,
      type = 'b'
    }
    x2d.entity.isotile.new{
      isogrid=grid,
      x = 3, y = -1,
      type = 'b'
    }
    x2d.entity.isotile.new{
      isogrid=grid,
      x = 0, y = 2,
      type = 'b'
    }
    x2d.entity.isotile.new{
      isogrid=grid,
      x = -1, y = 3,
      type = 'b'
    }
    x2d.entity.isotile.new{
      isogrid=grid,
      x = -2, y = 4,
      type = 'b'
    }
    x2d.entity.isotile.new{
      isogrid=grid,
      x = 2, y = 2,
      type = 'b'
    }
    x2d.entity.isotile.new{
      isogrid=grid,
      x = 5, y = 7,
      type = 'b'
    }
  end
}
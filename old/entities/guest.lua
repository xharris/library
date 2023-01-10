return {
  name = 'guest',
  render = function(self, children)
    lg.setColor(1,1,1)
    lg.circle('fill', 0, 0, TILE_SIZE/2)
  end,
  defaults = {
    x = 0,
    y = 0,
    name = 'bob',
    tile = nil
  },
  goTo = function(self, tile)
    local newpath = x2d.entity.isopath{ start=self.tile, dest=tile }
    newpath:z(200)
    if self.pathing then 
      x2d.entity.destroy(self.pathing)
    end
    self.pathing = newpath
    self:add(newpath)
  end
}
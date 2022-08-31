return {
  name = 'guest',
  render = function(self)
    lg.setColor(1,1,1)
    lg.translate(self.x, self.y)
    lg.circle('fill', 0, 0, TILE_SIZE/2)
    lg.circle('fill', 0, 0, lg.getHeight()/4)
  end,
  defaults = {
    x = 0,
    y = 0,
    name = 'bob'
  }
}
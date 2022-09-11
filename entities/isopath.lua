return {
  name = 'isopath',
  render = function(self)
    lg.setColor(1,0,0)
    lg.translate(-self.parent.x, -self.parent.y)
    for n, node in ipairs(self.nodes) do 
      if n > 1 then 
        local prev = self.nodes[n-1]
        lg.line(prev.tile.x, prev.tile.y, node.tile.x, node.tile.y)
      end
    end
  end,
  defaults = {
    start = nil,
    dest = nil,
    nodes = {},
    moveT = 0,
  },
  validate = function(self)
    assert(self.start, 'missing start')
    assert(self.dest, 'missing destination')
  end
}
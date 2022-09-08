-- push a tile update to an isogrid

return {
  name = 'isogridupdate',
  defaults = {
    isogrid = nil,
  },
  validate = function(self)
    assert(self.isogrid, 'must supply isogrid')
  end
}
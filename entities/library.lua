local f = util.floor

return {
  name = 'library',
  render = function(self, children)
    local hoveredTile
    lg.push('all')
      lg.translate(self.camera.x, self.camera.y)
      children()
    lg.pop()
    -- draw library name 
    lg.setFont(FONTS['large'])
    lg.print(self.name, 10, 10)   
    local mx, my = x2d.mousePosition()
    if mx then 
      lg.print(x2d.lume.format('{1}, {2}', {mx ,my}), 10, 50)
    end
  end,
  defaults = {
    name = '',
    floorFocused = 1,
    floor = {}, -- [floor]: isogrid
    hoveredTile = nil,
    camera = { x=0, y=0 }
  }
}
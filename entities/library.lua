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
    local w = x2d.getWidth()
    if mx then 
      lg.print(x2d.lume.format('{1}, {2}', {mx ,my}), 10, 50)
      lg.print(x2d.lume.lerp(1,10,(mx or 0) / w), 10, 100)
    end
    
  end,
  defaults = {
    name = '',
    grid = nil,
    hoveredTile = nil,
    camera = { x=0, y=0 }
  }
}
local M = class()

function M:init()
  self.x = 0 
  self.y = 0
end

function M:draw()
  lg.setColor(1,1,1)
  lg.circle('fill', self.x, self.y, 5)
end

return M
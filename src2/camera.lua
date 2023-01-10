local M

M = class {
  init = function(self)
    self.x = 0
    self.y = 0
    self.width = push:getWidth() 
    self.height = push:getHeight()
    self.transform = love.math.newTransform()
  end,
  start = function(self)
    love.graphics.push()
    self.transform:reset()
    self.transform:translate(self.width/2, self.height/2)
    self.transform:translate(-self.x, -self.y)
    love.graphics.applyTransform(self.transform)
  end,
  finish = function(self)
    love.graphics.pop()
  end,
  toWorld = function(self, x, y)
    return self.transform:inverseTransformPoint(x, y)
  end
}

return M 
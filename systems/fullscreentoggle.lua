local switched = false
local keys = 0

return function()
  keys = 0
  if love.keyboard.isDown('lalt', 'ralt') then keys = keys + 1 end 
  if love.keyboard.isDown('return') then keys = keys + 1 end 

  if keys == 2 then 
    if not switched then 
      x2d.push:switchFullscreen()
      switched = true
    end
  else 
    switched = false
  end
    
end
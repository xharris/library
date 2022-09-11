local M = {}

M.to2d = function(i, cols) return math.floor((i-1)%cols)+1, math.floor((i-1)/cols)+1 end
M.to1d = function(x, y, cols) return (((y-1) * cols) + (x-1))+1 end

function M.distance(a, b) return math.sqrt(math.pow(b.x - a.x, 2) + math.pow(b.y - a.y, 2)) end
function M.pythagorean(a, b) return math.sqrt(math.pow(a, 2) + math.pow(b, 2)) end
function M.floor(x) return math.floor(x+0.5) end
function M.sign(x) return x > 0 and 1 or (x == 0 and 0 or -1) end

function M.toIso(x, y, w, h)
  return (x + y) * w, (y - x) * h
end
function M.toIsoIndex(x, y, w, h)
  local my = y - x/2 - h
  local mx = x + my
  return math.ceil(mx/w), math.ceil(-my/w)-1 -- x, y
end

return M 
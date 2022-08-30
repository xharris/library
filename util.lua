local M = {}

M.to2d = function(i, cols) return math.floor((i-1)%cols)+1, math.floor((i-1)/cols)+1 end
M.to1d = function(x, y, cols) return (((y-1) * cols) + (x-1))+1 end

function M.pythagorean(a, b) return math.sqrt(math.pow(a, 2) + math.pow(b, 2)) end
function M.floor(x) return math.floor(x+0.5) end

return M 
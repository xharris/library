local M = {}

function M.indexToPosition(x, y, tile_width, tile_height)
  tile_width, tile_height = tile_width/2, tile_height/2
  return (x - y) * tile_width, -- x 
         (x + y) * tile_height -- y
end

function M.positionToIndex(x, y, tile_height)
  return math.floor((y + x / 2) / tile_height),
         math.floor((y - x / 2) / tile_height)
end

return M
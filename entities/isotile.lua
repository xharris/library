local f = util.floor
local tile_w, tile_h = TILE_SIZE, TILE_SIZE / 2

-- lg.translate(f(tile.x - (size/2)), f(tile.y - (size/4) ))

return {
  name = 'isotile',
  defaults = {
    x = 0,
    y = 0,
    origy = 0,
    index = {1,1,1},
    type = nil,
    height = 0,
    hasHitbox = false,
    isHovered = false
  },
  render = function(self)
    lg.setColor(1,1,1)
    -- draw normal tile base
    local img = IMAGES['tile_base']
    local ox, oy = f(img:getWidth()/2), f(img:getHeight()/3)
    lg.draw(img,0,0,0,1,1,ox,oy)
    -- draw hovering outline
    if self.isHovered then 
      lg.draw(IMAGES['tile_hovered'],0,0,0,1,1,ox,oy)
    end
    -- draw special tile overlay
    if self.type and IMAGES['tile_'..self.type] then 
      img = IMAGES['tile_'..self.type]
      lg.draw(img,0,0,0,1,1,ox,oy+(img:getHeight() - IMAGES['tile_base']:getHeight()))
    end
  end,
  setElevation = function(tile, elevation)
    local img_w, img_h = IMAGES['tile_base']:getWidth(), IMAGES['tile_base']:getHeight()
    local grid = tile.parent 
    tile.y = (tile.y - (tile.elevation * tile_h) + (elevation * tile_h))
    tile.elevation = height
    if grid and grid.world then 
      grid.world:update(
        tile, 
        tile.x - (img_w/2), 
        tile.y - (img_h/2)
      )
    end
  end,
  new = function(opts)
    return x2d.entity.isogridupdate(opts)
  end
}
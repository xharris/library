local f = util.floor
local tile_w, tile_h = TILE_SIZE, TILE_SIZE / 2

-- lg.translate(f(tile.x - (size/2)), f(tile.y - (size/4) ))

return {
  name = 'isotile',
  defaults = {
    x = 0,
    y = 0,
    index = {1,1},
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
    lg.setColor(0,1,0)
    
  end
}
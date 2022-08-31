local f = util.floor

return {
  name = 'library',
  render = function(self, children)
    lg.push('all')
      lg.translate(self.camera.x, self.camera.y)
      local size = TILE_SIZE
      -- draw tiles of each floor
      -- draw tiles
      local floor = self.floor[self.floorFocused]
      local tile, img
      if floor then 
        for x = floor.left, floor.right do 
          for y = floor.bottom, floor.top, -1 do 
            tile = floor.tiles[x][y] 
            img = IMAGES['tile_base']
            lg.push('all')
              lg.translate(f(tile.x - (size/2)), f(tile.y - (size/4) ))
              -- draw normal tile base
              local ox, oy = f(img:getWidth()/2), f(img:getHeight()/3)
              lg.draw(img,0,0,0,1,1,ox,oy)
              -- draw hovering outline
              if self.hoveredTile and self.hoveredTile.x == x and self.hoveredTile.y == y then 
                lg.draw(IMAGES['tile_hovered'],0,0,0,1,1,ox,oy)
              end
              -- draw special tile overlay
              if tile.type and IMAGES['tile_'..tile.type] then 
                img = IMAGES['tile_'..tile.type]
                lg.draw(img,0,0,0,1,1,ox,oy+(img:getHeight() - IMAGES['tile_base']:getHeight()))
              end
            lg.pop()
          end
        end
      end
      children()
    lg.pop()
    -- draw library name 
    lg.setFont(FONTS['large'])
    lg.print(self.name, 10, 10)   
    if self.hoveredTile then
      lg.setFont(FONTS['normal'])
      lg.print(x2d.lume.format('{x}, {y}', self.hoveredTile), 10, FONTS['large']:getHeight() + 5)
      lg.print(x2d.lume.format('{1}, {2}', {x2d.mousePosition()}), 10, FONTS['large']:getHeight() + FONTS['normal']:getHeight() + 5)
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
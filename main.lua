x2d = require 'xhh2d'
util = require 'util'
lg = nil

TILE_SIZE = 16
IMAGES = {}
FONTS = {}

function x2d.load()
  lg = love.graphics
  
  IMAGES['tile_base'] = lg.newImage('assets/images/tile_base.png')
  IMAGES['tile_b'] = lg.newImage('assets/images/tile_b.png')
  IMAGES['tile_e'] = lg.newImage('assets/images/tile_e.png')
  IMAGES['tile_hovered'] = lg.newImage('assets/images/tile_hovered.png')

  FONTS['normal'] = lg.newFont('assets/fonts/rainyhearts18.fnt') 
  FONTS['large'] = lg.newFont('assets/fonts/rainyhearts32.fnt') 

  lg.setFont(FONTS['normal'])
  x2d.state.push(x2d.state.library)
end
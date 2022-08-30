x2d = require 'xhh2d'
util = require 'util'
lg = nil

TILE_SIZE = 32
IMAGES = {}
FONTS = {}

function x2d.load()
  lg = love.graphics
  
  IMAGES['tile_a'] = lg.newImage('assets/images/tile_a.png')
  IMAGES['tile_hovered'] = lg.newImage('assets/images/tile_hovered.png')

  FONTS['normal'] = lg.newFont('assets/fonts/rainyhearts.ttf', 16)
  FONTS['large'] = lg.newFont('assets/fonts/rainyhearts.ttf', 32)

  lg.setFont(FONTS['normal'])
  state.push(x2d.state.library)
end

lg = nil
lume = require 'libs.lume'
class = require 'libs.clasp'
-- require 'libs.autobatch'
push = require 'libs.push'
util = require 'util'

local Camera = require 'camera'
local Library = require 'library'
local Guest = require 'guest'

TILE_SIZE = 32
TILE_W, TILE_H = TILE_SIZE, TILE_SIZE / 2
IMAGES = {}
FONTS = {}

local lib
local guest

local w, h = love.window.getMode()
push:setupScreen(w, h, w, h, {
  fullscreen = love.window.getFullscreen(), 
  resizable = true,
  highdpi = true,
  canvas = true
})

camera = Camera()

function love.load()
  local seed = os.time()
  math.randomseed(seed)
  love.graphics.setDefaultFilter("nearest", "nearest")
  lg = love.graphics
 
  IMAGES['tile_base'] = lg.newImage('assets/images/tile_base.png')
  IMAGES['tile_bo'] = lg.newImage('assets/images/tile_bo.png')
  IMAGES['tile_en'] = lg.newImage('assets/images/tile_en.png')
  IMAGES['tile_hovered'] = lg.newImage('assets/images/tile_hovered.png')

  FONTS['normal'] = lg.newFont('assets/fonts/rainyhearts18.fnt')
  FONTS['large'] = lg.newFont('assets/fonts/rainyhearts32.fnt')

  lg.setFont(FONTS['normal'])

  -- camera.x = lg.getWidth()/2
  lib = Library('NYPL', 20)
  guest = Guest()
  local tile = lib.grid:getTile(0, 0)
  guest.x, guest.y = tile.x, tile.y

  print(
    lume.serialize(
      lib.grid:getPath(
        guest,
        lib.grid:getTile(5, 5)
      )
    )
  )

  camera.y = TILE_H * 10
end

function love.update(dt)
  lib:update(dt)
  -- camera.x = camera.x + 10 * dt
end

function love.draw()
  push:start()
  camera:start()

  lib:draw()
  guest:draw()

  camera:finish()
  push:finish()
end

function love.resize(w, h)
  push:resize(w, h)
end
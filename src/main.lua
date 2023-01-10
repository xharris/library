x2d = require 'libs.xhh2d'
local lume = require 'libs.lume'

x2d.schema{
  -- tables
  drawable = {
    transform = x2d.TFRM,
    z = x2d.NUM
  },
  scenario = {
    total_guests = x2d.NUM,
    average_sound = x2d.NUM
  },
  library = {
    name = x2d.STR,
  },
  tile = {
    library = x2d.ID('library'),
    transform = x2d.TFRM,
    index = x2d.VEC2,
    floor = x2d.NUM,
    tile_type = x2d.ENUM('base', 'bo', 'en', 'hovered'),
    offset = x2d.VEC2,
    updated = x2d.BOOL,
    image = x2d.STR
  },
  hovered_tile = {
    transform = x2d.TFRM,
    index = x2d.VEC2,
    image = x2d.STR
  },
  station = {
    tile = x2d.ID('tile'),
  },
  inventory = {
    capacity = x2d.NUM
  },
  item = {
    name = x2d.STR,
    inventory = x2d.ID('inventory')
  },
  seat = {
    station = x2d.ID('station'),
    direction = x2d.ENUM('ne', 'se', 'sw', 'nw'),
    capacity = x2d.NUM
  },
  guest = {
    library = x2d.ID('library'),
    name = x2d.STR
  },
  path_node = {
    next_node = x2d.ID('path_node'),
    pos = x2d.VEC2
  },
  camera = {
    active = x2d.BOOL,
    transform = x2d.TFRM
  },
  -- relationships
  guest_inventory = { guest=x2d.ID('guest'), inventory=x2d.ID('inventory') },
  station_inventory = { station=x2d.ID('station'), inventory=x2d.ID('inventory') },
  station_seat = { station=x2d.ID('station'), seat=x2d.ID('seat') },
  guest_path = { guest=x2d.ID('guest'), path_node=x2d.ID('path_node') }
}

IMAGES = {}
FONTS = {}

--- covers all game object rendering
local game_renderer = x2d.system(
  { 'transform', 'z' },
  function(e)
    if FONTS[e.font] then 
      love.graphics.setFont(FONTS[e.font])
    end
    local x, y, r, sx, sy, ox, oy, kx, ky = unpack(e.transform)
    local offx, offy = unpack(e.offset or {0,0})
    local lg = love.graphics 
    lg.push('all')
      lg.translate(-(ox or 0), -(oy or 0))
      lg.rotate(r or 0)
      lg.scale(sx or 1, sy or 1)
      lg.shear(kx or 0, ky or 0)
      lg.translate((ox or 0), (oy or 0))
      lg.translate(math.floor((x or 0)+offx+0.5), math.floor((y or 0)+offy+0.5))
      if e.text then 
        love.graphics.print(e.text)
      end
      if IMAGES[e.image] then 
        love.graphics.draw(IMAGES[e.image])
      end
    lg.pop()
  end,
  { sort = 'z' }
)

local iso = require 'iso' 

-- when a tile changes its type
local tile_image_updater = x2d.system(
  { 'tile_type', 'updated', 'index' },
  function(e, id)
    local body = {}
    -- tile position
    body.transform = e.transform or {}
    body.transform[1], body.transform[2] = iso.indexToPosition(e.index[1], e.index[2], 32, 16)
    -- tile image
    body.image = lume.format('tile_{1}', {e.tile_type})
    -- image offset
    if e.tile_type ~= 'base' and IMAGES[body.image] then
      local img_base = IMAGES['tile_base']
      local img_tile = IMAGES[body.image]
      body.offset = {
        img_base:getWidth() - img_tile:getWidth(),
        img_base:getHeight() - img_tile:getHeight()
      }
    end
    x2d.put(id, body, {'updated'})
    x2d.print(id)
  end
)

local tile_hover = x2d.system(
  { 'index', 'transform' },
  function(e)
    local x, y = love.mouse.getPosition()
    tx, ty = iso.positionToIndex(x, y, 16)
    
  end
)

function love.load()
  local lg = love.graphics
  IMAGES['tile_base'] = lg.newImage('assets/images/tile_base.png')
  IMAGES['tile_bo'] = lg.newImage('assets/images/tile_bo.png')
  IMAGES['tile_en'] = lg.newImage('assets/images/tile_en.png')
  IMAGES['tile_hovered'] = lg.newImage('assets/images/tile_hovered.png')

  FONTS['normal'] = lg.newFont('assets/fonts/rainyhearts18.fnt')
  FONTS['large'] = lg.newFont('assets/fonts/rainyhearts32.fnt')

  -- create library 
  local id_lib = x2d.add{text='NYPL', z=10, font='large', transform={10, 10}}

  for x = 0, 10 do
    for y = 0, 10 do
      x2d.add{library=id_lib, index={x, y}, updated=true, tile_type='base', z=0}
    end
  end

  x2d.add{library=id_lib, index={8, 8}, updated=true, tile_type='bo', z=10}
end

function love.update(dt)
  tile_image_updater.call(dt)
  tile_hover.call(dt)
end

function love.draw()
  game_renderer.call()
end
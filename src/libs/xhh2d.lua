local M = {}

local lume = require 'libs.lume'
local sl = require 'libs.skiplist'

M.entities = {}
M.systems = {}

function M._addEntityToSystems(id, body) 
  for _, system in ipairs(M.systems) do 
    local belongs = true 
    local c = 1
    while belongs and c <= #system.components do 
      if not body or body[system.components[c]] == nil then 
        belongs = false
      end
      c = c + 1 
    end
    -- add to system entity list 
    if belongs then 
      system.entities:insert(id)
    else
      system.entities:delete(id)
    end
  end
end

local _id = 0
function M.add(body)
  _id = _id + 1
  M.entities[_id] = body
  for k, v in pairs(body) do 
    assert(type(v) ~= 'function', 'Cannot store function in component ('..k..')')
  end
  M._addEntityToSystems(_id, body)
  return _id
end

function M.get(id)
  return M.entities[id]
end

---@param id number
---@param update table
---@param remove? table
function M.put(id, update, remove)
  assert(M.entities[id], 'Entity does not exist ('..tostring(id)..')')
  M.entities[id] = lume.merge(M.entities[id], update)
  -- remove keys 
  if remove and #remove > 0 then 
    for k = 1, #remove do
      M.entities[id][remove[k]] = nil
    end
  end
  M._addEntityToSystems(id, M.entities[id])
  return M
end

function M.del(id)
  M.entities[id] = nil
  M._addEntityToSystems(id)
  return M 
end

function M.print(id)
  local props = { 'id='..id }
  for k, v in pairs(M.entities[id]) do 
    if type(v) == 'table' then 
      lume.push(props, k..'={'..table.concat(v, ', ')..'}')
    else
      lume.push(props, k..'='..tostring(v))
    end
  end
  print(table.concat(props, ', '))
end

local function newSkiplist(key)
  local list = sl()
  list.eq = function(a, b)
    return a == b
  end
  list.lt = function(a, b)
    a = M.entities[a][key] or 0
    b = M.entities[b][key] or 0
    return a < b
  end
  list.le = function(a, b)
    a = M.entities[a][key] or 0
    b = M.entities[b][key] or 0
    return a <= b
  end
  return list
end

function M.system(components, call, options)
  local sys = {}
  options = options or {}
  sys.components = components
  sys.entities = newSkiplist(options.sort)
  sys.call = function(...)
    for _, id in sys.entities:ipairs() do 
      call(M.entities[id], id, ...)
    end
  end
  lume.push(M.systems, sys)
  return sys
end

M.NUM = 'number'
M.STR = 'string'
M.BOOL = 'boolean' 
M.VEC2 = 'vec2'
M.VEC3 = 'vec3'
M.NIL = '__nil__'
---{x, y, r, sx, sy, ox, oy, kx, ky}
M.TFRM = 'transform'
---@param tbl string
M.ID = function(tbl) return tbl end
---@param ... string
M.ENUM = function(...) return table.concat({...}, '|') end
function M.schema(tbl)
  -- does nothing for now 
end

return M

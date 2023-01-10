# Library

## Simulator for building a library

# xhh2d

```lua
x2d = require 'xhh2d'

local sys = x2d.system(
  { 'component1', 'component2' },
  function(entity, id, ...)
    if x2d.changed(id, 'component2') then

    end
  end,
  {
    sort = 'z'
  }
)

local id = x2d.add{ component1='value1', component2='value2' }
local body = x2d.get(id)
x2d.put(id, { component1='other', component2=nil })
x2d.del(id)

function love.update(dt)
  sys.call('arg1', 'arg2', dt)
  x2d.reset()
end
```

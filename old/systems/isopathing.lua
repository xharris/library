return function(dt)
  for _, path in x2d.entity.isopath:all() do 
    -- create path
    if path.start and path.dest then 
      path.nodes = x2d.entity.isogrid.getPath(path.start, path.dest)
      path.length = 0
      for n, node in ipairs(path.nodes) do 
        if n > 1 then
          path.length = path.length + util.distance(node.tile, path.nodes[n-1].tile)
        end
      end

      if #path.nodes > 1 then 
        path.step = 2
        path.pointA = { x=path.parent.x, y=path.parent.y }
        path.pointB = path.nodes[path.step].tile
        path.moveT = 0
        print(path.pointA.x, path.pointA.y)
      end

      path.start = nil 
      path.dest = nil 
    end
    -- move on path 
    if path.pointA and path.pointB then 
      path.moveT = path.moveT + dt
      
      local parent = path.parent 
      local dist = util.distance(path.pointA, path.pointB)
      local maxT = (dist / path.length)
      parent.x = x2d.lume.lerp(path.pointA.x, path.pointB.x, path.moveT / maxT)
      parent.y = x2d.lume.lerp(path.pointA.y, path.pointB.y, path.moveT / maxT)
      if path.moveT / maxT >= 1 and path.step < #path.nodes then 
        parent.tile = path.nodes[path.step].tile
        path.step = path.step + 1
        path.pointA = { x=path.parent.x, y=path.parent.y }
        path.pointB = path.nodes[path.step].tile
        path.moveT = 0
      end
      -- print(parent.x, parent.y, dist, path.length, (path.moveT / 10) * pathPct)
    end
  end
end
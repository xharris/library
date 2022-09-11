return function()
  for _, path in x2d.entity.isopath:all() do 
    -- create path
    if path.start and path.dest then 
      path.nodes = x2d.entity.isogrid.getPath(path.start, path.dest)
      path.start = nil 
      path.dest = nil 
    end
  end
end
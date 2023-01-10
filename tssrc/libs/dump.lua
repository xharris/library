-- works like PHP's print_r(), returning the output instead of printing it to STDOUT
-- daniel speakmedia com

return function(data)
  -- cache of tables already printed, to avoid infinite recursive loops
  local tablecache = {}
  local buffer = ""
  local padder = "    "

  local function _dumpvar(d, depth)
      local t = type(d)
      local str = tostring(d)
      if (t == "table") then
          if (tablecache[str]) then
              -- table already dumped before, so we dont
              -- dump it again, just mention it
              buffer = buffer.."<"..str..">\n"
          else
              tablecache[str] = (tablecache[str] or 0) + 1
              buffer = buffer.."("..str..") {\n"
              for k, v in pairs(d) do
                  buffer = buffer..string.rep(padder, depth+1).."["..k.."] => "
                  _dumpvar(v, depth+1)
              end
              buffer = buffer..string.rep(padder, depth).."}\n"
          end
      elseif (t == "number") then
          buffer = buffer.."("..t..") "..str.."\n"
      else
          buffer = buffer.."("..t..") \""..str.."\"\n"
      end
  end
  _dumpvar(data, 0)
  return buffer
end


--[[
print(dumpvar({
[1] = "this is the first element",
[2] = "and this is the second",
[3] = 3,
[4] = 3.1415,
["nested"] = {
  ["lua"] = "is cool but",
  ["luajit"] = "is fucking awesome!"
},
["some-files"] = {
  [0] = io.stdin,
  [1] = io.stdout,
  [2] = io.stderr
}
}))

-- outputs:

(table: 0x41365f60) {
  [1] => (string) "this is the first element"
  [2] => (string) "and this is the second"
  [3] => (number) 3
  [4] => (number) 3.1415
  [nested] => (table: 0x41365fb0) {
      [lua] => (string) "is cool but"
      [luajit] => (string) "is fucking awesome!"
  }
  [some-files] => (table: 0x41366048) {
      [0] => (userdata) "file (0x3f1e79b6a0)"
      [1] => (userdata) "file (0x3f1e79b780)"
      [2] => (userdata) "file (0x3f1e79b860)"
  }
}

]]
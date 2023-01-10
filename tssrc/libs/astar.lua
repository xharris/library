-- AStar
-- https://github.com/xiejiangzhi/astar
-- map:
--  get_neighbors(node, from_node, add_neighbor_fn, userdata) -- all moveable neighbors
--  get_cost(from_node, to_node, userdata)
--  estimate_cost(start_node, goal_node, userdata)
--
-- node:
--  x:
--  y:
--  ==: check two node is same
--

local M = {}
M.__index = M
local private = {}
local inf = 1 / 0

function M.new(...)
  local obj = setmetatable({}, M)
  obj:init(...)
  return obj
end

function M:init(map)
  self.map = map
  assert(
    map.get_neighbors and map.get_cost and map.estimate_cost,
    "Invalid map, must include get_neighbors, get_cost and estimate_cost functions"
  )
end

-- start: start node
-- goal: goal node
function M:find(start, goal, userdata)
  local map = self.map

	local openset = { [start] = true }
	local closedset = {}
	local came_from = {}

	local g_score, h_score, f_score = {}, {}, {}
	g_score[start] = 0
  h_score[start] = map:estimate_cost(start, goal, userdata)
	f_score[start] = h_score[start]
	local current

	local add_neighbor_fn = function(neighbor, cost)
		if not closedset[neighbor] then
			if not cost then cost = map:get_cost(current, neighbor, userdata) end
			local tentative_g_score = g_score[current] + cost

			local openset_idx = openset[neighbor]
			if not openset_idx or tentative_g_score < g_score[neighbor] then
				came_from[neighbor] = current
				g_score[neighbor] = tentative_g_score
				h_score[neighbor] = h_score[neighbor] or map:estimate_cost(neighbor, goal, userdata)
				f_score[neighbor] = tentative_g_score + h_score[neighbor]

				openset[neighbor] = true
			end
		end
	end

	while next(openset) do
		current = private.pop_best_node(openset, f_score)
    openset[current] = nil

		if current == goal then
			local path = private.unwind_path({}, came_from, goal)
			table.insert(path, goal)
			return path, g_score, h_score, f_score, came_from
		end
		closedset[current] = true

    local from_node = came_from[current]
		map:get_neighbors(current, from_node, add_neighbor_fn, userdata)
	end

	return nil, g_score, h_score, f_score, came_from -- no valid path
end

----------------------------

-- return: node
function private.pop_best_node(set, score)
  local best, node = inf, nil

  for k, v in pairs(set) do
    local s = score[k]
    if s < best then
      best, node = s, k
    end
  end
  if not node then return end
  set[node] = nil
  return node
end

function private.unwind_path(flat_path, map, current_node)
	if map[current_node] then
		table.insert(flat_path, 1, map [ current_node ])
		return private.unwind_path(flat_path, map, map [ current_node ])
	else
		return flat_path
	end
end

return M

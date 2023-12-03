local GRAPH, P1 = {}, ""
for line in io.lines() do
	local name, weight = line:match("(%w+) %((%d+)%)")
	-- The "if not then" here and in the next paragraph is there because
	-- I don't know in which order I'll get nodes. Maybe the node is first
	-- seen as a child, and later as a parent, or the other way around.
	if not GRAPH[name] then
		GRAPH[name] = {
			weight = weight,
			parent = nil,
			children = {},
		}
	else
		GRAPH[name].weight = weight
	end

	for w in line:gmatch(" (%w+)") do
		if not GRAPH[w] then
			GRAPH[w] = {
				weight = math.mininteger,
				parent = name,
				children = {},
			}
		else
			GRAPH[w].parent = name
		end
		table.insert(GRAPH[name].children, w)
	end
end

-- With the graph built, we just find the node that has no parent (~ root)
for k, v in pairs(GRAPH) do
	if not v.parent then
		P1 = k
		break
	end
end
print(P1)

-- Do a depth-first traversal to compute the weight of each sub tree
-- from the bottom up. If one child's subtree is unbalanced, we're done.
-- We check for an unbalanced subtree by keeping track of the last three
-- weights.
local function dfs(node)
	local sum, t = 0, {}
	for _, child_key in ipairs(node.children) do
		local subtree_weight = dfs(GRAPH[child_key])
		sum = sum + subtree_weight
		table.insert(t, { GRAPH[child_key].weight, subtree_weight })
		if #t == 3 then
			local a, b, c = t[1], t[2], t[3]
			local correct, incorrect = nil, nil
			if a[2] == b[2] and b[2] ~= c[2] then
				correct, incorrect = b, c
			elseif b[2] == c[2] and b[2] ~= a[2] then
				correct, incorrect = b, a
			elseif a[2] == c[2] and b[2] ~= a[2] then
				correct, incorrect = a, b
			end
			if correct and incorrect then
				print(incorrect[1] + (correct[2] - incorrect[2]))
				os.exit()
			end
			table.remove(t, 1)
		end
	end
	return node.weight + sum
end
dfs(GRAPH[P1])

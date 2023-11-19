local input = tonumber(io.read("a"))

local rings = { { n = 1, added = 0 } }
while rings[#rings].n < input do
	local cur = rings[#rings]
	table.insert(rings, {
		added = cur.added + 8,
		n = cur.n + (cur.added + 8),
	})
end

local last_gen = rings[#rings]
local bot_right = last_gen.n
local length_side = last_gen.added / 4

local bottom_mid, left_mid, top_mid, right_mid =
	bot_right - (length_side / 2),
	bot_right - (length_side / 2) * 2,
	bot_right - (length_side / 2) * 3,
	bot_right - (length_side / 2) * 4

local dist_to_nearest_mid = math.min(
	math.abs(input - bottom_mid),
	math.abs(input - left_mid),
	math.abs(input - top_mid),
	math.abs(input - right_mid)
)

print("p1", dist_to_nearest_mid + #rings - 1)

local grid = {}
local function key(x, y)
	return string.format("%d;%d", x, y)
end

local function get(x, y)
	local k = key(x, y)
	return grid[k] or 0
end

local function set(x, y, v)
	local k = key(x, y)
	grid[k] = v
end

local function adjacent_sum(x, y)
	local sum = 0
	for _, pair in ipairs({
		{ -1, 0 },
		{ -1, -1 },
		{ 0, -1 },
		{ 1, -1 },
		{ 1, 0 },
		{ 1, 1 },
		{ 0, 1 },
		{ -1, 1 },
	}) do
		local xd, yd = table.unpack(pair)
		sum = sum + get(x + xd, y + yd)
	end
	return sum
end

local x, y = 0, 0
set(x, y, 1)

for _, gen in ipairs(table.pack(table.unpack(rings, 2))) do
	local side_length = gen.added / 4

	for _, instructions in ipairs({
		{ xd = 1, yd = 0, steps = 1 },
		{ xd = 0, yd = -1, steps = side_length - 1 },
		{ xd = -1, yd = 0, steps = side_length },
		{ xd = 0, yd = 1, steps = side_length },
		{ xd = 1, yd = 0, steps = side_length },
	}) do
		for _ = 1, instructions.steps do
			x, y = x + instructions.xd, y + instructions.yd
			local sum = adjacent_sum(x, y)
			if sum > input then
				print("p2", sum)
				goto done
			end
			set(x, y, sum)
		end
	end
end
::done::

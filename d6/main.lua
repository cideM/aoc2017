local P1, P2, P1_DONE, SEEN, BLOCKS = 0, 0, false, {}, {}

for w in io.read("a"):gmatch("(%d+)") do
	table.insert(BLOCKS, tonumber(w))
end

local function key(t)
	return table.concat(t, ";")
end

while (SEEN[key(BLOCKS)] or 0) < 2 do
	SEEN[key(BLOCKS)] = (SEEN[key(BLOCKS)] or 0) + 1

	local next_block, max = -1, math.mininteger
	for i, n in ipairs(BLOCKS) do
		if n > max or (n == max and i < next_block) then
			next_block, max = i, n
		end
	end

	local pos = next_block + 1
	for _ = max, 1, -1 do
		local i = pos % #BLOCKS == 0 and #BLOCKS or pos % #BLOCKS -- wrap
		BLOCKS[next_block] = BLOCKS[next_block] - 1
		BLOCKS[i] = BLOCKS[i] + 1
		pos = pos + 1
	end

	P1 = P1 + (not P1_DONE and 1 or 0)
	if (SEEN[key(BLOCKS)] or 0) == 1 then
		P1_DONE, P2 = true, P2 + 1
	end
end
print(P1, P2)

local instructions = {}
for line in io.lines() do
	table.insert(instructions, tonumber(line))
end

local POS, P1, instructions_p1 = 1, 0, table.move(instructions, 1, #instructions, 1, {})
while POS >= 1 and POS <= #instructions_p1 do
	local jump = instructions_p1[POS]
	instructions_p1[POS] = instructions_p1[POS] + 1
	POS, P1 = POS + jump, P1 + 1
end

POS, P2 = 1, 0
while POS >= 1 and POS <= #instructions do
	local jump = instructions[POS]
	instructions[POS] = instructions[POS] + (jump >= 3 and P2 > 0 and -1 or 1)
	POS, P2 = POS + jump, P2 + 1
end
print(P1, P2)

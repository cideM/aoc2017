local nums, sum, sum2 = {}, 0, 0
for line in io.lines() do
	for c in line:gmatch(".") do
		table.insert(nums, tonumber(c))
	end
end

for i, c in ipairs(nums) do
	local rem = (i - 1) % #nums -- p1
	if c == nums[rem == 0 and #nums or rem % #nums] then
		sum = sum + c
	end

	rem = (i + #nums / 2) -- p2
	if c == nums[rem == 0 and #nums or rem % #nums] then
		sum2 = sum2 + c
	end
end
print(sum, sum2)

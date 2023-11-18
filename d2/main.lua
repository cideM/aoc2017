local sheet, p1, p2 = {}, 0, 0
for line in io.lines() do
	local row = {}
	for w in line:gmatch("%w+") do
		table.insert(row, tonumber(w))
	end
	table.insert(sheet, row)
end

for _, row in ipairs(sheet) do
	table.sort(row, function(a, b)
		return a > b
	end)
	p1 = p1 + (row[1] - row[#row])

	for i, v in ipairs(row) do
		for j = i + 1, #row do
			if v % row[j] == 0 then
				p2 = p2 + (v / row[j])
			end
		end
	end
end
print(p1, p2)

local p1, p2 = 0, 0
for line in io.lines() do
  local seen, seen_sorted, p1_valid, p2_valid = {}, {}, true, true
  for word in line:gmatch("%w+") do
    local letters = {}
    for c in word:gmatch("%a") do
      table.insert(letters, c)
    end
    table.sort(letters)
    local word_sorted = table.concat(letters, "")
    if seen_sorted[word_sorted] then
      p2_valid = false
    end
    seen_sorted[word_sorted] = true

    if seen[word] then
      p1_valid = false
    end
    seen[word] = true
  end
  p1 = p1 + (p1_valid and 1 or 0)
  p2 = p2 + (p2_valid and 1 or 0)
end
print(p1, p2)

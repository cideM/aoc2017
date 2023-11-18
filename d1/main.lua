local CircularList = {}

function CircularList:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = function(t, k)
		if type(k) ~= "number" then
			return rawget(self, k)
		end
		local rem = k % #t
		return rem == 0 and t[#t] or t[rem]
	end
	return o
end

function CircularList:iter()
	local len = #self
	local i = 0
	return function()
		i = i + 1
		if i > len then
			return nil, nil
		end
		local v = rawget(self, i)
		return i, v
	end
end

local nums = CircularList:new()
for c in io.read("a"):gmatch(".") do
	table.insert(nums, tonumber(c))
end

local sum_1, sum_2 = 0, 0
for i, c in nums:iter() do
	if c == nums[i - 1] then
		sum_2 = sum_2 + c
	end
	if c == nums[i + #nums / 2] then
		sum_1 = sum_1 + c
	end
end
print(sum_1, sum_2)

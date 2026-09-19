--------------------------------------------
--DEPENDENCIES--
--------------------------------------------

local fs = require("@lune/fs")

--------------------------------------------
--INITIALIZATION--
--------------------------------------------

return function(path: string): number
	local contents = fs.readFile(path)
	local lines = 0
	for _ in contents:gmatch("\n\r?") do
		lines += 1
	end
	return lines + 1
end

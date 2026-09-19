--------------------------------------------
--DEPENDENCIES--
--------------------------------------------

local stdio = require("@lune/stdio")
local process = require("@lune/process")
local countRecursive = require("../src/countRecursive")

--------------------------------------------
--VARIABLES--
--------------------------------------------

local cwd = process.cwd
local TOTAL_FILE_LINES = 100 + 10 + 3 + 15

--------------------------------------------
--PRIVATE FUNCTIONS--
--------------------------------------------

local function countFileLinesRecursive(): ()
	local files, lines = countRecursive(cwd .. "files")

	if files ~= 4 then
		stdio.ewrite(`failed to count recursive count files: expected 4 got {files}`)
		process.exit(2)
	end

	if lines ~= TOTAL_FILE_LINES then
		stdio.ewrite(`failed to recursive count file lines: expected {TOTAL_FILE_LINES} got {lines}\n`)
		process.exit(2)
	end
end

--------------------------------------------
--INITIALIZATION--
--------------------------------------------

countFileLinesRecursive()

stdio.write("succesfully counted nested file lines\n")
process.exit(0)

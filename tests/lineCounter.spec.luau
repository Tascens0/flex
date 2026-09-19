--------------------------------------------
--DEPENDENCIES--
--------------------------------------------

local stdio = require("@lune/stdio")
local process = require("@lune/process")
local countFileLines = require("../src/countFileLines")

--------------------------------------------
--VARIABLES--
--------------------------------------------

local cwd = process.cwd

--------------------------------------------
--PRIVATE FUNCTIONS--
--------------------------------------------

local function getFilePath(fileName: string): ()
	return cwd .. "files/" .. fileName .. ".txt"
end

local function testFileTen(): ()
	local lines = countFileLines(getFilePath("fileTen"))
	if lines ~= 10 then
		stdio.ewrite(`failed to count fine lines: expected 10 got {lines}\n`)
		process.exit(2)
	end
end

local function testFileThree(): ()
	local lines = countFileLines(getFilePath("fileThree"))
	if lines ~= 3 then
		stdio.ewrite(`failed to count fine lines: expected 3 got {lines}\n`)
		process.exit(2)
	end
end

local function testFileOneHundred(): ()
	local lines = countFileLines(getFilePath("fileOneHundred"))
	if lines ~= 100 then
		stdio.ewrite(`failed to count fine lines: expected 100 got {lines}\n`)
		process.exit(2)
	end
end

--------------------------------------------
--INITIALIZATION--
--------------------------------------------

testFileTen()
testFileThree()
testFileOneHundred()

stdio.write("succesfully counted file lines\n")
process.exit(0)

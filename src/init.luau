--------------------------------------------
--DEPENDENCIES--
--------------------------------------------

local process = require("@lune/process")
local stdio = require("@lune/stdio")
local fs = require("@lune/fs")
local countRecursive = require("@self/countRecursive")

--------------------------------------------
--VARIABLES--
--------------------------------------------

local args = process.args

--------------------------------------------
--CONSTANTS--
--------------------------------------------

local NORMAL_OUTPUT_MESSAGE = "the project has a total of %d lines of code across %d files\n"
local PATTERN_OUTPUT_MESSAGE = "the project has %d lines across %d files that match %q"

--------------------------------------------
--PRIVATE FUNCTIONS--
--------------------------------------------

local function isFileOrDir(path: string): boolean
	return fs.isDir(path) or fs.isFile(path)
end

--------------------------------------------
--INITIALIZATION--
--------------------------------------------

local function main(): never
	local root = args[1]
	local pattern = args[2]
	if not (root and type(root) == "string" and isFileOrDir(root)) then
		stdio.ewrite("invalid argument 1: please provide the project's root dir\n")
		return process.exit(1)
	end

	local files, lines = countRecursive(root, pattern)
	if pattern then
		stdio.write(PATTERN_OUTPUT_MESSAGE:format(lines, files, pattern))
	else
		stdio.write(NORMAL_OUTPUT_MESSAGE:format(lines, files))
	end
	return process.exit(0)
end

main()

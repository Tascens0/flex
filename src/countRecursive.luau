--------------------------------------------
--DEPENDENCIES--
--------------------------------------------

local fs = require("@lune/fs")
local process = require("@lune/process")
local stdio = require("@lune/stdio")
local countFileLines = require("./countFileLines")

--------------------------------------------
--PRIVATE FUNCTIONS--
--------------------------------------------

local function getFileName(path: string): string
	return path:match("/?([^/]*)/?$")
end

local function getFileLines(path: string): (number, number)
	local lines = countFileLines(path)
	stdio.write(`{path} ({lines})\n`)
	return lines
end

local function countOnMatch(path: string, pattern: string?): (number, number)
	if not pattern then
		return 1, getFileLines(path)
	end
	local fileName = getFileName(path)
	if not fileName:match(pattern) then
		return 0, 0
	end
	return 1, getFileLines(path)
end

local function countRecursive(path: string, pattern: string?): (number, number)
	if fs.isFile(path) then
		return countOnMatch(path, pattern)
	end

	if not fs.isDir(path) then
		stdio.ewrite(debug.traceback(`an internal error occured\ninvalid argument path: {path}\n`, 0) .. "\n")
		return process.exit(2)
	end

	local files = 0
	local lines = 0
	local entries = fs.readDir(path)
	for i = 1, #entries do
		local entry = entries[i]
		local entryFiles, entryLines = countRecursive(path .. "/" .. entry, pattern)
		files += entryFiles
		lines += entryLines
	end
	return files, lines
end

--------------------------------------------
--INITIALIZATION--
--------------------------------------------

return countRecursive

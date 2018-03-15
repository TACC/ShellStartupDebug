-------------------------------------------------------------------------
--
--  Copyright (C) 2008-2013 Robert McLay
--
--  Permission is hereby granted, free of charge, to any person obtaining
--  a copy of this software and associated documentation files (the
--  "Software"), to deal in the Software without restriction, including
--  without limitation the rights to use, copy, modify, merge, publish,
--  distribute, sublicense, and/or sell copies of the Software, and to
--  permit persons to whom the Software is furnished to do so, subject
--  to the following conditions:
--
--  The above copyright notice and this permission notice shall be
--  included in all copies or substantial portions of the Software.
--
--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
--  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
--  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
--  NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
--  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
--  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
--  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
--  THE SOFTWARE.
--
--------------------------------------------------------------------------

--------------------------------------------------------------------------
-- fileOps: A collection of useful file operations.


_DEBUG          = false
local posix     = require("posix")

require("strict")
require("string_trim")
require("string_split")
local lfs       = require("lfs")
local concatTbl = table.concat

--------------------------------------------------------------------------
-- findInPath(): find the absolute path to an executable.

function findInPath(exec, path)
   local result  = "unknown_path_for_" .. (exec or "unknown")
   if ( exec == nil) then return result end
   exec = exec:trim()
   local i = exec:find(" ")
   local cmd  = exec
   local tail = ""
   if (i) then
      cmd  = exec:sub(1,i-1)
      tail = exec:sub(i)
   end

   if (cmd:find("/")) then
      if (posix.access(cmd,"x")) then
         return exec
      else
         return result
      end
   end

   path    = path or os.getenv("PATH")
   for dir in path:split(":") do
      local fullcmd = pathJoin(dir, cmd)
      if (posix.access(fullcmd,"x")) then
         result = fullcmd .. tail
         break
      end
   end
   return result
end

------------------------------------------------------------------------
-- isDir(): Return true if path is a directory.  Note that a symlink to
--          a directory is not a directory.

function isDir(d)
   if (d == nil) then return false end
   local t = posix.stat(d,"type")

   local result = (t == "directory")

   return result
end

--------------------------------------------------------------------------
-- isFile(): Return true if file exists is and is a file or link.

function isFile(fn)
   if (fn == nil) then return false end
   local t = posix.stat(fn,"type")

   local result = ((t == "regular") or (t == "link"))

   return result
end

--------------------------------------------------------------------------
-- isExec(): Returns true if file is readable and executable.

function isExec(fn)
   if (fn == nil) then return false end
   local result = posix.access(fn,"rx")
   return result
end

--------------------------------------------------------------------------
-- dirname(): Return the directory part of path. Will return "./" if path
--            is without a directory.

function dirname(path)
   if (path == nil) then return nil end
   local result
   local i,j = path:find(".*/")
   if (i == nil) then
      result = "./"
   else
      result = path:sub(1,j)
   end
   return result
end

--------------------------------------------------------------------------
-- extname(): Return the extension of a file or "" if there is none.

function extname(path)
   if (path == nil) then return nil end
   local result
   local i,j = path:find(".*/")
   i,j       = path:find(".*%.",j)
   if (i == nil) then
      result = ""
   else
      result = path:sub(j,-1)
   end
   return result
end

--------------------------------------------------------------------------
-- removeExt(): Remove extension from path.

function removeExt(path)
   if (path == nil) then return nil end
   local result
   local i,j = path:find(".*/")
   i,j       = path:find(".*%.",j)
   if (i == nil) then
      result = path
   else
      result = path:sub(1,j-1)
   end
   return result
end

--------------------------------------------------------------------------
-- barefilename(): return the file name w/o any directory part.

function barefilename(path)
   if (path == nil) then return nil end
   local result
   local i,j = path:find(".*/")
   if (i == nil) then
      result = path
   else
      result = path:sub(j+1,-1)
   end
   return result
end

--------------------------------------------------------------------------
-- splitFileName(): split a path into a directory and a file.

function splitFileName(path)
   if (path == nil) then return nil, nil end
   local d, f
   local i,j = path:find(".*/")
   if (i == nil) then
      d = './'
      f = path
   else
      d = path:sub(1,j)
      f = path:sub(j+1,-1)
   end
   return d, f
end

--------------------------------------------------------------------------
-- pathJoin(): Join argument into a path that has single slashes between
--             directory names and no trailing slash.

function pathJoin(...)
   local a = {}
   local arg = { n = select('#', ...), ...}
   for i = 1, arg.n  do
      local v = arg[i]
      if (v and v ~= '') then
         local vType = type(v)
         if (vType ~= "string") then
            msg = "bad argument #" .. i .." (string expected, got " .. vType .. " instead)\n"
            assert(vType ~= "string", msg)
         end
      	 v = v:trim()
      	 if (v:sub(1,1) == '/' and i > 1) then
	    if (v:len() > 1) then
	       v = v:sub(2,-1)
	    else
	       v = ''
	    end
      	 end
      	 v = v:gsub('//+','/')
      	 if (v:sub(-1,-1) == '/') then
	    if (v:len() > 1) then
	       v = v:sub(1,-2)
	    elseif (i == 1) then
	       v = '/'
      	    else
	       v = ''
	    end
      	 end
      	 if (v:len() > 0) then
	    a[#a + 1] = v
	 end
      end
   end
   local s = concatTbl(a,"/")
   s = path_regularize(s)
   return s
end

--------------------------------------------------------------------------
-- mkdir_recursive(): Create a new directory recursively.

function mkdir_recursive(path)
   local absolute
   if (path:sub(1,1) == '/') then
      absolute = true
      path = path:sub(2,-1)
   end

   local a = {}
   if (absolute) then
      a[#a + 1] = "/"
   end
   local d
   for v in path:split('/') do
      a[#a + 1] = v
      d         = concatTbl(a,'/')
      if (not isDir(d)) then
         lfs.mkdir(d)
      end
   end
end

--------------------------------------------------------------------------
-- abspath(): find true path through symlinks.

function abspath (path, localDir)
   if (path == nil) then return nil end
   local cwd = lfs.currentdir()
   path = path:trim()

   if (path:sub(1,1) ~= '/') then
      path = pathJoin(cwd,path)
   end

   local dir    = dirname(path)
   local ival   = lfs.chdir(dir)

   dir          = lfs.currentdir() or dir

   path = pathJoin(dir, barefilename(path))
   local result = path

   local attr = lfs.symlinkattributes(path)
   if (attr == nil) then
      lfs.chdir(cwd)
      return nil
   elseif (attr.mode == "link") then
      local rl = posix.readlink(path)
      if (not rl) then
         lfs.chdir(cwd)
         return nil
      end
      if (localDir and (rl:sub(1,1) == "/" or rl:sub(1,3) == "../")) then
         lfs.chdir(cwd)
         return result
      end
      result = abspath(rl, localDir)
   end
   lfs.chdir(cwd)
   return result
end

--------------------------------------------------------------------------
-- path_regularize(): Remove leading and trail spaces and extra slashes.

function path_regularize(value)
   if value == nil then return nil end
   value = value:gsub("^%s+","")
   value = value:gsub("%s+$","")
   value = value:gsub("//+","/")
   value = value:gsub("/%./","/")
   value = value:gsub("/$","")
   if (value == '') then
      value = ' '
   end
   return value
end

--------------------------------------------------------------------------
-- shell_startup_debug License
--------------------------------------------------------------------------
--
--  shell_startup_debug is licensed under the terms of the MIT license 
--  reproduced below. This means that shell_startup_debug  is free software 
--  and can be used for both academic and commercial purposes at absolutely
--  no cost.
--
--  ----------------------------------------------------------------------
--
--  Copyright (C) 2013 Robert McLay
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
-- BaseShell

require("strict")
require("fileOps")
require("inherits")

local assert       = assert
local getenv       = os.getenv
local io           = io
local loadfile     = loadfile
local masterTbl    = masterTbl
local pathJoin     = pathJoin
local print	   = print
local setmetatable = setmetatable
local systemG      = _G
local tostring     = tostring
local type	   = type


local M = {}

function M.name(self)
   print ("Shell name:",self.my_name)
end


local function valid_shell(shellTbl,shell_name)
   if (not shellTbl[shell_name]) then
      return shellTbl.bare
   end
   return shellTbl[shell_name]
end

function M.build(shell_name)
   local i, j       = shell_name:find('^.*/')
   if (i) then
      shell_name = shell_name:sub(j+1)
   end
   local shellTbl = {}
   local Csh        = require('Csh')
   local Bash       = require('Bash')
   local Bare       = require('Bare')
   shellTbl["sh"]   = Bash
   shellTbl["bash"] = Bash
   shellTbl["zsh"]  = Bash
   shellTbl["csh"]  = Csh
   shellTbl["tcsh"] = Csh
   shellTbl.bare    = Bare

   local  o = valid_shell(shellTbl,shell_name):create()
   return o
end

function M.echo_cmd(self,cmd)
   local masterTbl = masterTbl()
   local execDir   = masterTbl.execDir
   assert(loadfile(pathJoin(execDir,"shell_startup.rc")))()

   local key       = "bash_" .. cmd

   local s         = systemG.echoTbl[key]
   if (s) then
      io.stdout:write(tostring(s))
   end
end


--function getMT(self, name)
--   return getenv(name)
--end

return M

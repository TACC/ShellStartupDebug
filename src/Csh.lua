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


local BaseShell = BaseShell
local assert    = assert
local io        = io
local loadfile  = loadfile
local masterTbl = masterTbl
local pairs     = pairs
local pathJoin  = pathJoin
local systemG   = _G

Csh             = inheritsFrom(BaseShell)
Csh.my_name     = 'csh'

function Csh.expand(self,tbl)
   for k in pairs(tbl) do
      local v = tbl[k]
      if (v == false) then
	 io.stdout:write("unsetenv ",k,";\n")
      else
	 io.stdout:write("setenv ",k," '",v,"';\n")
      end
   end
end

function Csh.echo_cmd(self,cmd)
   local masterTbl = masterTbl()
   local execDir   = masterTbl.execDir
   assert(loadfile(pathJoin(execDir,"shell_startup.rc")))()

   local key       = "csh_" .. cmd

   local s         = systemG.echoTbl[key]
   if (s) then
      io.stdout:write(s)
   end
end

return Csh

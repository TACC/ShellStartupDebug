--------------------------------------------------------------------------
-- use io.popen to open a pipe to collect the output of a command.
-- @module capture
_DEBUG      = false
local posix = require("posix")

require("strict")

------------------------------------------------------------------------
--
--  Copyright (C) 2008-2014 Robert McLay
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


local dbg   = require("Dbg"):dbg()


--------------------------------------------------------------------------
-- Capture stdout from *cmd*
-- @param cmd a string that contains a unix command.

function capture(cmd)
   dbg.start{"capture(",cmd,")"}
   dbg.print{"cwd: ",posix.getcwd(),"\n",level=2}
   local p = io.popen(cmd)
   if p == nil then
      return nil
   end
   local ret = p:read("*all")
   p:close()
   dbg.start{"capture output()",level=2}
   dbg.print{ret}
   dbg.fini("capture output")
   dbg.fini("capture")
   return ret
end


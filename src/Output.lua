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


require("capture")
require("fileOps")
require("string_trim")

_DEBUG          = false
local getenv    = os.getenv
local io        = io
local BaseShell = require("BaseShell")
local posix     = require("posix")

function DATEString()
   local ymd  = os.date("*t")

   --                           y    m    d    h    m    s
   local uuid = string.format("%d_%02d_%02d_%02d_%02d_%02d", 
			      ymd.year, ymd.month, ymd.day, 
			      ymd.hour, ymd.min,   ymd.sec)
   return uuid
end

function Output(shell,cmd)
   local masterTbl  = masterTbl()
   local envVarsT   = masterTbl.envVarsT
   local SSD        = tonumber(getenv("SHELL_STARTUP_DEBUG")) or 0
   if (SSD > 2) then
      local ssdFn      = getenv("SHELL_STARTUP_DEBUG_FN")
      if (ssdFn == nil) then
         local host    = "-" .. posix.uname("%n"):gsub("%..*","")
         local dateStr = "-" .. DATEString()
         local uuid    = "-" .. capture("uuidgen")
         uuid          = uuid:trim()
         ssdFn         = "SHELL_STARTUP" .. host .. dateStr .. uuid .. ".log"
         ssdFn         = pathJoin(os.getenv("HOME"), ssdFn)
         envVarsT["SHELL_STARTUP_DEBUG_FN"] = ssdFn
      end
   end
   shell:expand(envVarsT)
end

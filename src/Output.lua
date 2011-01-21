-- $Id: Output.lua 194 2008-06-25 21:43:50Z mclay $ --

require("capture")
require("fileOps")
require("string_trim")

local getenv = os.getenv
local io     = io

require("BaseShell")

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
         local host    = posix.uname("%n")
         host          = "-" .. host:gsub("%..*","")
         local dateStr = "-" .. DATEString()
         local uuid    = "-" .. capture("uuidgen")
         uuid          = uuid:trim()
         ssdFn         = "SHELL_STARTUP" .. host .. dateStr .. uuid .. ".log"
         ssdFn         = pathJoin(os.getenv("HOME"), ssdFn)
         envVarsT["SHELL_STARTUP_DEBUG_FN"] = ssdFn
      end
   end

   if (SSD > 2 or cmd == "clobber" ) then
      shell:echo_cmd(cmd)
   end

   shell:expand(envVarsT)

end

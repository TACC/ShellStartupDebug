-- -*- lua -*-

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

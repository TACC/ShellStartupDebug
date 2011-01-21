-- -*- lua -*-
-- $Id: Bash.lua 194 2008-06-25 21:43:50Z mclay $
local BaseShell = BaseShell
local io        = io
local pairs     = pairs
local assert    = assert
local table     = table
Bash	        = inheritsFrom(BaseShell)
Bash.my_name    = 'bash'
local systemG   = _G

local Bash   = Bash

module("Bash")

function expand(self, tbl)

   for k in pairs(tbl) do
      local v     = tbl[k]
      local lineA = {}
      if (v == false) then
	 io.stdout:write("unset '",k,"';\n")
      else
         lineA[#lineA + 1] = k
         lineA[#lineA + 1] = "='"
         lineA[#lineA + 1] = v
         lineA[#lineA + 1] = "';\n"
         lineA[#lineA + 1] = "export "
         lineA[#lineA + 1] = k
         lineA[#lineA + 1] = ";\n"
         
         local line = table.concat(lineA,"")
	 io.stdout:write(line)
         --io.stdout:write("echo ",k,": \"%",v,"%\";\n")
      end
   end
end

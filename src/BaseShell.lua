-- BaseShell
-- $Id: BaseShell.lua 194 2008-06-25 21:43:50Z mclay $
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

-- BaseShell
-- $Id: BaseShell.lua 194 2008-06-25 21:43:50Z mclay $

BaseShell = {}

local assert       = assert
local getenv       = os.getenv
local io           = io
local loadfile     = loadfile
local masterTbl    = masterTbl
local print	   = print
local setmetatable = setmetatable
local systemG      = _G
local tostring     = tostring
local type	   = type

------------------------------------------------------------------------
-- Create a new class that inherits from a base class
------------------------------------------------------------------------

function inheritsFrom( baseClass )

    -- The following lines are equivalent to the SimpleClass example:

    -- Create the table and metatable representing the class.
    local new_class = {}
    local class_mt = { __index = new_class }

    -- Note that this function uses class_mt as an upvalue, so every instance
    -- of the class will share the same metatable.
    --
    function new_class:create()
        local newinst = {}
        setmetatable( newinst, class_mt )
        return newinst
    end

    -- The following is the key to implementing inheritance:

    -- The __index member of the new class's metatable references the
    -- base class.  This implies that all methods of the base class will
    -- be exposed to the sub-class, and that the sub-class can override
    -- any of these methods.
    --
    if baseClass then
        setmetatable( new_class, { __index = baseClass } )
    end

    return new_class
end

require("fileOps")
require('Csh')
require('Bash')
require('Bare')

local Csh      = Csh
local Bash     = Bash
local Bare     = Bare
local pathJoin = pathJoin
------------------------------------------------------------------------
module ('BaseShell')
------------------------------------------------------------------------

function name(self)
   print ("Shell name:",self.my_name)
end

local shellTbl = {}
shellTbl["sh"]	 = Bash
shellTbl["bash"] = Bash
shellTbl["ksh"]  = Bash
shellTbl["zsh"]	 = Bash
shellTbl["csh"]	 = Csh
shellTbl["tcsh"] = Csh
shellTbl.bare	 = Bare

local function valid_shell(shell_name)
   if (not shellTbl[shell_name]) then
      return shellTbl.bare
   end
   return shellTbl[shell_name]
end

function build(shell_name)
   local i, j       = shell_name:find('^.*/')
   if (i) then
      shell_name = shell_name:sub(j+1)
   end

   local  s = valid_shell(shell_name)
   local  o = s:create()
   return o
end

function echo_cmd(self,cmd)
   local masterTbl = masterTbl()
   local execDir   = masterTbl.execDir
   assert(loadfile(pathJoin(execDir,"shell_startup.rc")))()

   local key       = "bash_" .. cmd

   local s         = systemG.echoTbl[key]
   if (s) then
      io.stdout:write(tostring(s))
   end
end


function getMT(self, name)
   return getenv(name)
end

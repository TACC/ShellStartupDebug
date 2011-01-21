-- $Id: CmdLineOptions.lua 194 2008-06-25 21:43:50Z mclay $ --
local setmetatable = setmetatable
local arg          = arg
local pairs        = pairs
local next         = next
local masterTbl    = masterTbl
local io           = io
local require      = require
local systemG      = _G
local format       = string.format

CmdLineOptions = {}
require("Version")
local version      = Version.name

module("CmdLineOptions")
local s_CmdLineOptions = {}

local function new(self)
   local o = {}

   setmetatable(o,self)
   self.__index = self

   return o
end

function  options(self)
   if ( next(s_CmdLineOptions) ) then return s_CmdLineOptions end

   s_CmdLineOptions = new(self)

   local Optiks = require("Optiks")


   local masterTbl     = masterTbl()
   local usage         = "Usage: settarg [options] [up|down]"
   local cmdlineParser = Optiks:new{usage=usage, version=format("settarg %s",version())}

   cmdlineParser:add_option{ 
      name    = {'-s','--shell'},
      dest    = 'shell',
      action  = 'store',
      type    = 'string',
      default = 'bash',
   }

   cmdlineParser:add_option{ 
      name   = {'-v','--verbose'},
      dest   = 'verbosityLevel',
      action = 'count',
   }

   cmdlineParser:add_option{ 
      name   = {'--name'},
      dest   = 'name',
      action = 'store',
      type   = 'string',
   }

   local optionTbl, pargs = cmdlineParser:parse(arg)

   for v in pairs(optionTbl) do
      masterTbl[v] = optionTbl[v]
   end
   masterTbl.pargs = pargs
   
   return s_CmdLineOptions
end

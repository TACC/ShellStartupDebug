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

require("strict")
require("fileOps")
local setmetatable = setmetatable
local arg          = arg
local pairs        = pairs
local next         = next
local masterTbl    = masterTbl
local io           = io
local require      = require
local systemG      = _G
local format       = string.format

local Version      = require("Version")
local version      = Version.name
local M            = {}

local s_CmdLineOptions = {}

local function new(self)
   local o = {}

   setmetatable(o,self)
   self.__index = self

   return o
end

function  M.options(self)
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
   masterTbl.shell = barefilename(masterTbl.shell)


   return s_CmdLineOptions
end

return M

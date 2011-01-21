-- -*- lua -*-
-- $Id: Bare.lua 194 2008-06-25 21:43:50Z mclay $

require ('BeautifulTbl')
local BaseShell	   = BaseShell
local pairs	   = pairs
local BeautifulTbl = BeautifulTbl

Bare	     = inheritsFrom(BaseShell)
Bare.my_name = 'bare'

module("Bare")

function expand(self,tbl)
   local t = {}
   for k in pairs(tbl) do
      local v = tbl[k]
      t[#t + 1] = {k, '"'..v..'"'}
   end

   local bt = BeautifulTbl:new(t)
   bt:print_tbl()
end

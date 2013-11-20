--------------------------------------------------------------------------
-- This function is described in the book: Programming in Lua by
-- Roberto Ierusalimschy.  It has been updated for Lua 5.1.
--
-- This function returns an iterator.  The point of this function
-- to be able to walk a table where the keys are sorted.

require("strict")
local sort = table.sort
function pairsByKeys (t, f)
   local a = {}
   local n = 0
   for k in pairs(t) do
      n    = n + 1
      a[n] = k
   end
   sort(a, f)
   local i = 0                -- iterator variable
   local iter = function ()   -- iterator function
                   i = i + 1
                   if a[i] == nil then return nil
                   else return a[i], t[a[i]]
                   end
                end
   return iter
end

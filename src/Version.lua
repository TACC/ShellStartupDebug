--module('Version')
local M={}
function M.tag()  return "1.4.3"   end
function M.git()  return "@git@"    end
function M.date() return "2013-11-16 13:22" end
function M.name()
  local a = {}
  a[#a+1] = M.tag()
  a[#a+1] = M.git()
  a[#a+1] = M.date()
  return table.concat(a," ")
end
return M

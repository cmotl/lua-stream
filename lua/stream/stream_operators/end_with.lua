function Stream:end_with(...)
  local args = { ... }
  local iter = self._next
  local i = 0
  return Stream:new(function()
    local x = iter()
    if (not x) and (i == 0) then
      iter = function()
        i = i + 1
        return args[i]
      end
      x = iter()
    end
    return x
  end)
end

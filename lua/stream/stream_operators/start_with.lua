function Stream:start_with(...)
  local args = { ... }
  local iter = self._next
  local i = 0
  return Stream:new(function()
    i = i + 1
    return args[i] or iter()
  end)
end

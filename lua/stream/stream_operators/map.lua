function Stream:map(fn)
  local iter = self._next
  return Stream:new(function()
    local x = iter()
    return x and fn(x)
  end)
end

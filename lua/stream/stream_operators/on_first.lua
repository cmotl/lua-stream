function Stream:on_first(fn)
  local iter = self._next
  return Stream:new(function()
    local x = iter()
    if fn and x then
      fn(x)
      fn = nil
    end
    return x
  end)
end

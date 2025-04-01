function Stream:select_until(fn)
  local iter = self._next
  return Stream:new(function()
    local x = iter()
    if x and fn(x) then
      x = nil
    end
    return x
  end)
end

function Stream:filter(fn)
  local iter = self._next
  return Stream:new(function()
    local x = iter()
    while x do
      if fn(x) then
        return x
      end
      x = iter()
    end
  end)
end

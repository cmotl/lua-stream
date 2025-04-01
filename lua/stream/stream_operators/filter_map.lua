function Stream:filter_map(fn)
  local iter = self._next
  return Stream:new(function()
    local x = iter()
    while x do
      local y = fn(x)
      if y then
        return y
      end
      x = iter()
    end
  end)
end

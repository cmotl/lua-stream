function Stream:on_last(fn)
  local iter = self._next
  local last
  return Stream:new(function()
    local x = iter()
    if x then
      last = x
      return x
    end
    fn(last)
  end)
end

function Stream:reject_until(fn)
  local iter = self._next
  local done = false
  return Stream:new(function()
    if done then
      return iter()
    else
      local x = iter()
      while x and not fn(x) do
        x = iter()
      end
      done = true
      return x
    end
  end)
end

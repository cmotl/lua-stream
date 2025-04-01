function Stream:take(limit)
  local count = 0
  local iter = self._next
  return Stream:new(function()
    if count < limit then
      count = count + 1
      return iter()
    end
  end)
end

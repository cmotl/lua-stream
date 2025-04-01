function Stream.from_array_values(t)
  local i = 0
  return Stream:new(function()
    i = i + 1
    return t[i]
  end)
end

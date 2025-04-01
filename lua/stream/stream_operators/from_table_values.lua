function Stream.from_table_values(t)
  local k, v
  return Stream:new(function()
    k, v = next(t, k)
    if k then
      return v
    end
  end)
end

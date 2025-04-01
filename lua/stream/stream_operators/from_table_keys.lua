function Stream.from_table_keys(t)
  local k
  return Stream:new(function()
    k = next(t, k)
    return k
  end)
end

function Stream.from_table_keys_with_values(t)
  local k, v
  return Stream:new(function()
    k, v = next(t, k)
    if k then
      return { k, v }
    end
  end)
end

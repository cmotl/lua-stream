function Stream.sorted_values_with_keys(t, fn)
  fn = fn or function(x)
    return x
  end
  local keys_and_values = Stream.from_table_keys_with_values(t):to_table()
  table.sort(keys_and_values, function(a, b)
    return fn(a[2]) < fn(b[2])
  end)
  return Stream.stream(keys_and_values)
end

function Stream.sorted_keys_with_values(t, fn)
  fn = fn or function(x)
    return x
  end
  local keys_and_values = Stream.from_table_keys_with_values(t):to_table()
  table.sort(keys_and_values, function(a, b)
    return fn(a[1]) < fn(b[1])
  end)
  return Stream.stream(keys_and_values)
end

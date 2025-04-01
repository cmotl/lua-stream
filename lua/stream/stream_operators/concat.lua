function Stream.concat(...)
  return Stream.from_array_values({ ... }):flat_map(function(x)
    return x
  end)
end

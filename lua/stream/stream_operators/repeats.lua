function Stream.repeats(value)
  return Stream:new(function()
    return value
  end)
end

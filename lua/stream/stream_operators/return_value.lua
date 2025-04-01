function Stream.return_value(value)
  return Stream:new(function()
    local x = value
    value = nil
    return x
  end)
end

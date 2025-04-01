function Stream.replicate(value, count)
  if count < 0 then
    error 'negative count'
  end
  return Stream:new(function()
    return value
  end):take(count)
end

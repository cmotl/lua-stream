function Stream.stream(enumerable)
  if type(enumerable) == 'table' then
    if enumerable._next then
      -- the enumerable is already a stream, just return it
      return enumerable
    else
      return Stream.from_array_values(enumerable)
    end
  elseif type(enumerable) == 'function' then
    -- enumerable is a generator function
    return Stream:new(enumerable)
  elseif enumerable == nil then
    -- there is nothing to enumerate
    return Stream.empty()
  else
    -- the enumerable is a value for which we will generate a single value
    return Stream.return_value(enumerable)
  end
end

function Stream.zip(stream1, stream2)
  local iter1 = stream1._next
  local iter2 = stream2._next
  local value1 = iter1()
  local value2 = iter2()
  return Stream:new(function()
    if value1 and value2 then
      local result = { value1, value2 }
      value1 = iter1()
      value2 = iter2()
      return result
    end
  end)
end

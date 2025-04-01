function Stream.range(start_index, end_index)
  local index = start_index
  return Stream:new(function()
    if index <= end_index then
      local result = index
      index = index + 1
      return result
    end
  end)
end

function Stream:scan(binary_operation, initial, transform)
  if transform then
    return self:map(transform):scan(binary_operation, initial, nil)
  end

  local result = initial
  local iter = self._next

  return Stream:new(function()
    local new_result
    repeat
      local x = iter()
      if x then
        new_result = binary_operation(result, x)
      else
        return nil
      end
    until new_result
    result = new_result
    return result
  end)
end

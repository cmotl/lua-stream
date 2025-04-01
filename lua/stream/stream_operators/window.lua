function Stream:window(count)
  if count < 1 then
    error 'Stream:window requires positive number'
  end
  local buffer = {}
  local eof_marker = {}
  return self
    :end_with(eof_marker)
    :filter(function(x)
      if x == eof_marker then
        return true
      end

      table.insert(buffer, x)
      return #buffer == count
    end)
    :map(function()
      local result = buffer
      buffer = {}
      return result
    end)
end

function Stream:tail(length)
  local buffer = {}
  local eof_marker = {}
  local count = 0
  local head
  return self
    :end_with(eof_marker)
    :filter(function(x)
      if x == eof_marker then
        return true
      end
      head = count % length + 1
      count = count + 1
      buffer[head] = x
    end)
    :flat_map(function()
      if not head then
        return nil
      end
      return Stream.range(count - math.min(count, length), count - 1)
        :map(function(input_index)
          return input_index % length + 1
        end)
        :map(function(translated_index)
          return buffer[translated_index]
        end)
    end)
end

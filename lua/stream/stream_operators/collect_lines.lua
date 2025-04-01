function Stream:collect_lines()
  local buffers = {}
  local eof_marker = {}
  return self
    :end_with(eof_marker)
    :flat_map(function(new_data)
      if not buffers then
        return
      end
      if new_data ~= eof_marker then
        local clean_data = new_data:gsub('\r', '')
        table.insert(buffers, clean_data)
        if clean_data:find '\n' then
          local buffer = table.concat(buffers)
          return function()
            local end_pos = buffer:find '\n'
            if end_pos then
              local result = buffer:sub(1, end_pos - 1)
              buffer = buffer:sub(end_pos + 1)
              return result
            else
              buffers = { buffer }
            end
          end
        else
          return ''
        end
      else
        local buffer = table.concat(buffers)
        buffers = nil
        return buffer
      end
    end)
    :filter(L '#_ > 0')
end

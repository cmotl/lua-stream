function Stream:every_nth(n, fn)
  if n <= 0 then
    error 'Stream:every_nth requires a positive number'
  end
  local current_count = 1
  local total_count = 0
  return self:filter(function(x)
    total_count = total_count + 1
    if current_count == n then
      fn(x, total_count, current_count)
      current_count = 1
      return true
    else
      current_count = current_count + 1
      return false
    end
  end)
end

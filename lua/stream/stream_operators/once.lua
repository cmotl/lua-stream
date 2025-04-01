function Stream:once(fn)
  local called_once = false
  return self:peek(function(x)
    if not called_once then
      fn(x)
      called_once = true
    end
  end)
end

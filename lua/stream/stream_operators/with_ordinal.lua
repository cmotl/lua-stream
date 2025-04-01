function Stream:with_ordinal()
  local i = 0
  return self:map(function(x)
    i = i + 1
    return { x, i }
  end)
end

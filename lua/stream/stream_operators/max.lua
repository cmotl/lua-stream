function Stream:max(transform)
  local binary_operation = function(max, x)
    return math.max(x, max or x)
  end
  local identity = nil

  return self:reduce(binary_operation, identity, transform)
end

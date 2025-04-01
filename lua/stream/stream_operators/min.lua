function Stream:min(transform)
  local binary_operation = function(min, x)
    return math.min(x, min or x)
  end
  local identity = nil

  return self:reduce(binary_operation, identity, transform)
end

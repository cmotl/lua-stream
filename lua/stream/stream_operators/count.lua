function Stream:count()
  local binary_operation = function(x, _)
    return x + 1
  end
  local identity = 0

  return self:reduce(binary_operation, identity)
end

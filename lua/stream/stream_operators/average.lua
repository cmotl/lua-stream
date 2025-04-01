function Stream:average(fn)
  local count = 0
  local sum = 0

  local binary_operation = function(_, x)
    count = count + 1
    sum = sum + x
    return sum / count
  end

  local identity = nil

  return self:reduce(binary_operation, identity, fn)
end

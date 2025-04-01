function Stream:sum(transform)
  local sum = function(a, b)
    return a + b
  end
  local initial = 0

  return self:reduce(sum, initial, transform)
end

function Stream:reduce(binary_operation, initial, transform)
  return self:scan(binary_operation, initial, transform):last() or initial
end

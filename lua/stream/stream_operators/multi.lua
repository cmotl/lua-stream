function Stream:multi(aggregator_generators)
  local initial_values = {}

  local aggregators = {}
  for i, generator_fn in ipairs(aggregator_generators) do
    local aggregator, init_val = generator_fn()
    aggregators[i] = aggregator
    initial_values[i] = init_val
  end

  local binary_operation = function(groups, value)
    local results = {}
    for i, aggregator in ipairs(aggregators) do
      results[i] = aggregator(value)
    end
    return results
  end

  local identity = initial_values

  return self:reduce(binary_operation, identity)
end

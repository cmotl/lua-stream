function Stream.aggregators.multi(aggregator_generators)
  return function()
    local aggregators = {}
    local initial_values = {}

    for k, generator_fn in pairs(aggregator_generators) do
      local aggregator, init_val = generator_fn()
      aggregators[k] = aggregator
      initial_values[k] = init_val
    end

    return function(value)
      local results = {}
      for k, aggregator in pairs(aggregators) do
        results[k] = aggregator(value)
      end
      return results
    end,
      initial_values
  end
end

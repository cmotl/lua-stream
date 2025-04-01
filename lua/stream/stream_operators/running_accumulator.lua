function Stream:running_accumulator(agg_factory)
  local aggregator
  local result
  return self
    :once(function(x)
      aggregator, result = agg_factory(x)
    end)
    :filter(function(x)
      result = aggregator(x)
      return result
    end)
    :map(function(x)
      return result
    end)
end

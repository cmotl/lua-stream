function Stream.aggregators.multiplex(key_fn, agg_factory)
  return function()
    local group = {}
    local aggregators = {}

    return function(value)
      local key = key_fn(value)
      if not aggregators[key] then
        aggregators[key] = agg_factory(value)
      end

      group[key] = aggregators[key](value)

      return group[key]
    end,
      nil
  end
end

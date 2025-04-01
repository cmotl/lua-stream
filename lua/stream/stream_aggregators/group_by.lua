local function group_by_with_accessor_fn(fn, agg_factory)
  return function()
    local groups = {}
    local aggregators = {}
    return function(x)
      if x then
        local key = fn(x)
        local aggregator = aggregators[key]
        if not aggregator then
          aggregator = agg_factory(x)
          aggregators[key] = aggregator
        end
        groups[key] = aggregator(x)
      end
      return groups
    end, {}
  end
end

local function group_by_withiout_accessor_fn(agg_factory)
  return function()
    local groups = {}
    local aggregators = {}
    return function(x)
      if x then
        local aggregator = aggregators[x]
        if not aggregator then
          aggregator = agg_factory(x)
          aggregators[x] = aggregator
        end
        groups[x] = aggregator(x)
      end
      return groups
    end, {}
  end
end

function Stream.aggregators.group_by(fn, agg_factory)
  if fn then
    return group_by_with_accessor_fn(fn, agg_factory)
  else
    return group_by_without_accessor_fn(agg_factory)
  end
end

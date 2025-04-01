function Stream.aggregators.union_merge(merge_aggregator)
  if not merge_aggregator then
    print 'merge aggreagtion function required'
    return
  end

  return function()
    local group = {}
    local aggregators = {}

    return function(t)
      for k, v in pairs(t) do
        if not aggregators[k] then
          aggregators[k] = merge_aggregator(v)
        end

        group[k] = aggregators[k](v)
      end

      return group
    end, {}
  end
end

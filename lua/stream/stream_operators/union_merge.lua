function Stream:union_merge(merge_aggregator)
  local aggregators = {}

  local binary_operation = function(group, t)
    for k, v in pairs(t) do
      if not aggregators[k] then
        aggregators[k] = merge_aggregator(v)
      end

      group[k] = aggregators[k](v)
    end

    return group
  end

  local identity = {}

  return self:reduce(binary_operation, identity)
end

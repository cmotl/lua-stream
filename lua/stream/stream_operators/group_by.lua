function Stream:group_by(key_fn, group_aggregator)
  local aggregators = {}
  local binary_operation = function(groups, x)
    local key = key_fn(x)
    if not aggregators[key] then
      aggregators[key] = group_aggregator(x)
    end
    groups[key] = aggregators[key](x)
    return groups
  end

  local identity = {}

  return self:reduce(binary_operation, identity)
end

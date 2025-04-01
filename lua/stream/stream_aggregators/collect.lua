local identity_fn = function(x)
  return x
end

function Stream.aggregators.collect(fn)
  local fn = fn or identity_fn
  return function()
    local group = {}

    return function(t)
      table.insert(group, fn(t))
      return group
    end, {}
  end
end

function max_with_accessor_fn(fn)
  return function()
    local max
    return function(x)
      local y = fn(x)
      max = math.max(y, max or y)
      return max
    end, nil
  end
end

function max_without_accessor_fn()
  return function()
    local max
    return function(x)
      max = math.max(x, max or x)
      return max
    end, nil
  end
end

function Stream.aggregators.max(fn)
  if fn then
    return max_with_accessor_fn(fn)
  else
    return max_without_accessor_fn()
  end
end

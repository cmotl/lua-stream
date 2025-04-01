function min_with_accessor_fn(fn)
  return function()
    local min
    return function(x)
      local y = fn(x)
      min = math.min(y, min or y)
      return min
    end, nil
  end
end

function min_without_accessor_fn()
  return function()
    local min
    return function(x)
      min = math.min(x, min or x)
      return min
    end, nil
  end
end

function Stream.aggregators.min(fn)
  if fn then
    return min_with_accessor_fn(fn)
  else
    return min_without_accessor_fn()
  end
end

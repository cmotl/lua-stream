local function last_with_accessor_fn(fn)
  return function()
    return function(x)
      return fn(x)
    end, nil
  end
end

local function last_without_accessor_fn(fn)
  return function()
    return function(x)
      return x
    end, nil
  end
end

function Stream.aggregators.last(fn)
  if fn then
    return last_with_accessor_fn(fn)
  else
    return last_without_accessor_fn()
  end
end

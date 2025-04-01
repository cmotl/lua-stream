local function first_with_accessor_fn(fn)
  return function()
    local first
    return function(x)
      if not first then
        first = fn(x)
      end
      return first
    end, nil
  end
end

local function first_without_accessor_fn(fn)
  return function()
    local first
    return function(x)
      if not first then
        first = x
      end
      return first
    end, nil
  end
end

function Stream.aggregators.first(fn)
  if fn then
    return first_with_accessor_fn(fn)
  else
    return first_without_accessor_fn()
  end
end

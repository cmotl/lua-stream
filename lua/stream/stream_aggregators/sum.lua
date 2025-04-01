local function sum_with_accessor_fn(fn)
  return function()
    local sum = 0
    return function(x)
      sum = sum + fn(x)
      return sum
    end, 0
  end
end

local function sum_without_accessor_fn()
  return function()
    local sum = 0
    return function(x)
      sum = sum + x
      return sum
    end, 0
  end
end

function Stream.aggregators.sum(fn)
  if fn then
    return sum_with_accessor_fn(fn)
  else
    return sum_without_accessor_fn()
  end
end

local function average_with_accessor_fn(fn)
  return function()
    local count = 0
    local sum = 0
    return function(x)
      count = count + 1
      sum = sum + fn(x)
      return sum / count
    end, 0
  end
end

local function average_without_accessor_fn()
  return function()
    local count = 0
    local sum = 0
    return function(x)
      count = count + 1
      sum = sum + x
      return sum / count
    end, 0
  end
end

function Stream.aggregators.average(fn)
  if fn then
    return average_with_accessor_fn(fn)
  else
    return average_without_accessor_fn()
  end
end

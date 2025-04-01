local TableX = require 'pl.tablex'

local function distinct_with_accessor_fn(fn)
  return function()
    local known_values = {}
    return function(x)
      local x = fn(x)
      if not TableX.find(known_values, x) then
        table.insert(known_values, x)
      end
      return known_values
    end, {}
  end
end

local function distinct_without_accessor_fn()
  return function()
    local known_values = {}
    return function(x)
      if not TableX.find(known_values, x) then
        table.insert(known_values, x)
      end
      return known_values
    end, {}
  end
end

function Stream.aggregators.distinct(fn)
  if fn then
    return distinct_with_accessor_fn(fn)
  else
    return distinct_without_accessor_fn()
  end
end

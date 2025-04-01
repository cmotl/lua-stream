function Stream.aggregators.count()
  return function()
    local count = 0
    return function()
      count = count + 1
      return count
    end, 0
  end
end

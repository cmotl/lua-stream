function Stream.aggregators.pairwise()
  return function()
    local previous

    return function(x)
      if previous then
        local pair = { previous, x }
        previous = x
        return pair
      end
      previous = x
    end, {}
  end
end

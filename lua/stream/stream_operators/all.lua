function Stream:all(condition_fn)
  local all = true
  return self
    :reject_until(function(x)
      if not condition_fn(x) then
        all = false
        return true
      end
    end)
    :end_with('')
    :take(1)
    :map(function()
      return all
    end)
end

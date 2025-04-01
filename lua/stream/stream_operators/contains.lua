function Stream:contains(condition_fn, transform_fn)
  transform_fn = transform_fn or function()
    return true
  end
  local not_found = {}
  return self
    :reject_until(function(x)
      return condition_fn(x)
    end)
    :end_with(not_found)
    :take(1)
    :map(function(x)
      if not_found == x then
        return false
      else
        return transform_fn(x)
      end
    end)
end

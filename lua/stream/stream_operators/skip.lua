function Stream:skip(limit)
  local count = 0
  return self:reject_until(function()
    count = count + 1
    return count > limit
  end)
end

function Stream:reject(fn)
  return self:filter(function(x)
    return not fn(x)
  end)
end

function Stream:peek(fn)
  return self:map(function(x)
    fn(x)
    return x
  end)
end

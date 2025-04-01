function Stream:distinct_until_changed(fn)
  local prev
  local discriminator
  if fn then
    discriminator = function(x)
      local new_value = fn(x)
      if prev ~= new_value then
        prev = new_value
        return new_value
      end
    end
  else
    discriminator = function(x)
      if prev ~= x then
        prev = x
        return x
      end
    end
  end
  return self:filter(discriminator)
end

local function unique_with_accessor_fn(self, fn)
  local seen_items = {}
  return self:reject(function(x)
    local y = fn(x)
    if seen_items[y] then
      return true
    end
    seen_items[y] = true
    return false
  end)
end

local function unique_without_accessor_fn(self)
  local seen_items = {}
  return self:reject(function(x)
    if seen_items[x] then
      return true
    end
    seen_items[x] = true
    return false
  end)
end

function Stream:unique(fn)
  if fn then
    return unique_with_accessor_fn(self, fn)
  else
    return unique_without_accessor_fn(self)
  end
end

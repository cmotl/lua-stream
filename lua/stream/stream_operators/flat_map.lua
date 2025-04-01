require 'string_lambda'

function Stream:flat_map(fn)
  fn = fn or L '_'
  local iter = self._next
  local enumerable
  local i
  local many_iter
  local next_from_many_iter = function()
    local y = many_iter()
    if y then
      return y
    else
      many_iter = nil
    end
  end
  local enumerable_ipairs = function()
    i = i + 1
    return enumerable[i]
  end
  return Stream:new(function()
    if many_iter then
      local y = next_from_many_iter()
      if y then
        return y
      end
    end
    local x = iter()
    while x do
      enumerable = fn(x)
      local type_of_enumerable = type(enumerable)
      if 'table' == type_of_enumerable then
        if enumerable._next then
          many_iter = enumerable._next
        else
          i = 0
          many_iter = enumerable_ipairs
        end
      elseif 'function' == type_of_enumerable then
        many_iter = enumerable
      else
        return enumerable
      end
      local y = next_from_many_iter()
      if y then
        return y
      end
      x = iter()
    end
  end)
end

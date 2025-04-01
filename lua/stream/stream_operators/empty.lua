local noop = function() end
function Stream.empty()
  return Stream:new(noop)
end

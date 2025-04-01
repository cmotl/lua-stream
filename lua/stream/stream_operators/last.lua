function Stream:last()
  local iter = self._next
  local last
  local x
  repeat
    last = x
    x = iter()
  until not x
  return last
end

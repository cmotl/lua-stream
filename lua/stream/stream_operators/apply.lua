function Stream:apply()
  local iter = self._next
  while iter() do
  end
end

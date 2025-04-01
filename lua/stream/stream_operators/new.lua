function Stream:new(fn)
  if type(fn) ~= 'function' then
    error('Streams must be created with a generator function', 2)
  end

  local stream = {
    _next = fn,
  }
  setmetatable(stream, getmetatable(Stream))

  return stream
end

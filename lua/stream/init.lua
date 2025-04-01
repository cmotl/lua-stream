Stream = {
  aggregators = {},
}

local stream_operators_mt = {
  __index = function(_, k)
    pcall(function()
      require(string.format('stream.stream_operators.%s', k))
    end)
    return rawget(Stream, k)
  end,
}
setmetatable(Stream, stream_operators_mt)

local stream_aggregators_mt = {
  __index = function(_, k)
    pcall(function()
      require(string.format('stream.stream_aggregators.%s', k))
    end)
    return rawget(Stream.aggregators, k)
  end,
}
setmetatable(Stream.aggregators, stream_aggregators_mt)

function Stream.is_stream(x)
  return (type(x) == 'table') and (stream_operators_mt == getmetatable(x))
end

return Stream

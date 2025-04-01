describe('stream_reduce', function()
  require 'stream'
  require 'string_lambda'

  local first = L '|a,b| a'
  local second = L '|a,b| b'
  local sum = L '|a,b| a+b'

  it('should return the initial value for an empty stream', function()
    local value = {}
    assert.is.equal(value, Stream.empty():reduce(first, value))
  end)

  it('should not execute binary operation on empty stream', function()
    local f = L '|a,b| assert(false)'
    local value = {}
    assert.is.equal(value, Stream.empty():reduce(f, value))
  end)

  it('should pass aggregated value as first parameter to binary operation', function()
    local value = 1
    assert.is.equal(value, Stream.stream({ 0 }):reduce(first, value))
  end)

  it('should pass next stream value as second parameter to binary operation', function()
    local value = 1
    assert.is.equal(42, Stream.stream({ 42 }):reduce(second, value))
  end)

  it('should pass aggregated value as first parameter to binary operation on subsequent calls', function()
    local results = {}
    local f = function(a, b)
      table.insert(results, a)
      return a + b
    end
    local value = 1
    Stream.stream({ 10, 20 }):reduce(f, value)
    assert.are.same({ 1, 11 }, results)
  end)

  it('should aggregate all values in stream', function()
    local value = 0
    assert.is.equal(15, Stream.stream({ 1, 2, 3, 4, 5 }):reduce(sum, value))
  end)

  it('should apply an optional transformation accessor on stream values prior to aggregating', function()
    local transform = L '|a| #a'
    local value = 0
    assert.is.equal(15, Stream.stream({ 'a', 'bb', 'ccc', 'dddd', 'eeeee' }):reduce(sum, value, transform))
  end)
end)

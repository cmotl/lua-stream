describe('scan', function()
  require 'string_lambda'
  require 'stream'

  local first = L '|a,b| a'
  local second = L '|a,b| b'
  local sum = L '|a,b| a+b'

  it('should emit no values for an empty stream', function()
    local value = 42
    assert.is.equal(0, Stream.empty():scan(first, value):count())
  end)

  it('should not execute binary operation on empty stream', function()
    local f = L '|a,b| assert(false)'
    local value = {}
    Stream.empty():scan(f, value):apply()
  end)

  it('should pass aggregated value as first parameter to binary operation', function()
    local value = 1
    assert.is.equal(value, Stream.stream({ 0 }):scan(first, value):first())
  end)

  it('should pass next stream value as second parameter to binary operation', function()
    local value = 1
    assert.is.equal(42, Stream.stream({ 42 }):scan(second, value):first())
  end)

  it('should pass aggregated value as first parameter to binary operation on subsequent calls', function()
    local results = {}
    local f = function(a, b)
      table.insert(results, a)
      return a + b
    end
    local value = 1
    Stream.stream({ 10, 20 }):scan(f, value):apply()
    assert.are.same({ 1, 11 }, results)
  end)

  it('should aggregate all values in stream', function()
    local value = 0
    assert.is.equal(15, Stream.stream({ 1, 2, 3, 4, 5 }):scan(sum, value):last())
  end)

  it('should apply an optional transformation accessor on stream values prior to aggregating', function()
    local transform = L '|a| #a'
    local value = 0
    assert.is.equal(15, Stream.stream({ 'a', 'bb', 'ccc', 'dddd', 'eeeee' }):scan(sum, value, transform):last())
  end)

  it('should produce all intermediate results', function()
    local result = Stream.stream({ 'a', 5, { 12, 15, 17 } }):scan(L '|a,b|a+1', 0):to_table()

    assert.are.same({ 1, 2, 3 }, result)
  end)

  it('should be able to skip updating the result when nothing is returned from the binary operation', function()
    local sum_if_odd = function(a, b)
      if 1 == b % 2 then
        return a + b
      end
    end
    local result = Stream.stream({ 1, 2, 3, 4, 5 }):scan(sum_if_odd, 0):to_table()

    assert.are.same({ 1, 4, 9 }, result)
  end)
end)

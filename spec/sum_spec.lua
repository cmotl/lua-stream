describe('stream_sum', function()
  require 'stream'
  require 'string_lambda'

  it('can sum the values of a stream', function()
    assert.is.same(0, Stream.stream({}):sum())
    assert.is.same(3, Stream.stream({ 1, 1, 1 }):sum())
    assert.is.same(55, Stream.stream({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }):sum())
    assert.is.same(-7, Stream.stream({ 1, 2, 3, 4, 5, -10, -12 }):sum())
  end)

  it('can sum accessed values of a stream', function()
    assert.is.same(15, Stream.stream({ 'a', 'bb', 'ccc', 'dddd', 'eeeee' }):sum(L '|a| #a'))
  end)

  it('throws an error on non-numeric values', function()
    assert.has.errors(function()
      Stream.stream({ 'a', 'bb', 'ccc' }):sum()
    end)
  end)
end)

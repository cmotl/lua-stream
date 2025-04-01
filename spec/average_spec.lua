describe('stream_average', function()
  require 'stream'
  require 'string_lambda'

  it('can average the values of a stream', function()
    assert.is.same(nil, Stream.stream({}):average())
    assert.is.same(1, Stream.stream({ 1, 1, 1 }):average())
    assert.is.same(5.5, Stream.stream({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }):average())
    assert.is.same(-1, Stream.stream({ 1, 2, 3, 4, 5, -10, -12 }):average())
  end)

  it('can average accessed values of a stream', function()
    assert.is.same(2, Stream.stream({ 'a', 'bb', 'ccc' }):average(L '|x| #x'))
  end)

  it('throws an error on non-numeric values', function()
    assert.has.errors(function()
      Stream.stream({ 'a', 'bb', 'ccc' }):average()
    end)
  end)
end)

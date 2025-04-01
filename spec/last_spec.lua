describe('stream_last', function()
  require 'stream'

  it('can get last value', function()
    assert.is.same(4, Stream.stream({ 1, 2, 3, 4 }):last())
    assert.is.same(5, Stream.stream({ 5 }):last())
    assert.is.same(nil, Stream.stream({}):last())
  end)
end)

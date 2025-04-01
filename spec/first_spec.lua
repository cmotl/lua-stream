describe('stream_every_nth', function()
  require 'stream'

  it('can get first value', function()
    assert.is.same(1, Stream.stream({ 1, 2, 3, 4 }):first())
    assert.is.same(5, Stream.stream({ 5 }):first())
    assert.is.same(nil, Stream.stream({}):first())
  end)
end)

describe('stream_count', function()
  require 'stream'

  it('can count records', function()
    assert.is.equal(4, Stream.stream({ 1, 2, 3, 4 }):count())
  end)
end)

describe('stream_any', function()
  require 'stream'

  it('any is an alias for contains', function()
    assert.is.equal(Stream.contains, Stream.any)
  end)
end)

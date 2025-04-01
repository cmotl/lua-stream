describe('stream_some', function()
  require 'stream'

  it('some is an alias for contains', function()
    assert.is.equal(Stream.contains, Stream.some)
  end)
end)

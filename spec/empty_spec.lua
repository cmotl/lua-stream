describe('stream_empty', function()
  require 'stream'

  it('can have an empty stream', function()
    assert.is.equal(0, Stream.empty():count())
    assert.is.equal(0, Stream.empty():count())
  end)
end)

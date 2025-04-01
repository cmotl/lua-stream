describe('collect', function()
  require 'stream'

  it('is an alias for map', function()
    assert.is.equal(Stream.map, Stream.collect)
  end)
end)

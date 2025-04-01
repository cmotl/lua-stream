describe('collect_many', function()
  require 'stream'

  it('is an alias for flat_map', function()
    assert.is.equal(Stream.collect_many, Stream.flat_map)
  end)
end)

describe('select', function()
  require 'stream'

  it('is an alias for filter', function()
    assert.is.equal(Stream.filter, Stream.select)
  end)
end)

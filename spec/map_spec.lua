describe('stream_map', function()
  require 'stream'

  it('can map values', function()
    assert.is.same(
      { 1, 4, 9, 16 },
      Stream.stream({ 1, 2, 3, 4 })
        :map(function(x)
          return x * x
        end)
        :to_table()
    )
  end)
end)

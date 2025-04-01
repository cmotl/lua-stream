describe('stream_filter', function()
  require 'stream'

  it('can filter some values', function()
    assert.is.same(
      { 1, 2 },
      Stream.stream({ 1, 2, 3, 4 })
        :filter(function(x)
          return x <= 2
        end)
        :to_table()
    )
  end)
end)

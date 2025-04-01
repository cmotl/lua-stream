describe('stream_filter_map', function()
  require 'stream'

  it('can filter and map values at the same time', function()
    assert.is.same(
      { 4, 8 },
      Stream.stream({ 1, 2, 3, 4 })
        :filter_map(function(x)
          if 0 == (x % 2) then
            return x * 2
          end
        end)
        :to_table()
    )
  end)
end)

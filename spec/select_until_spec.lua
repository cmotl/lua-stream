describe('stream_select_until', function()
  require 'stream'

  it('can select until some condition', function()
    assert.is.same(
      { 2, 3 },
      Stream.stream({ 1, 2, 3, 4 })
        :filter(function(x)
          return x >= 2
        end)
        :select_until(function(x)
          return x == 4
        end)
        :to_table()
    )
  end)
end)

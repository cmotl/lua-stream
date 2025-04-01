describe('stream_group_by', function()
  require 'stream'

  it('can group by values', function()
    assert.is.same(
      { [0] = 2, [1] = 2, [2] = 2 },
      Stream.stream({ 1, 2, 3, 4, 5, 6 }):group_by(function(i)
        return i % 3
      end, Stream.aggregators.count())
    )
  end)
end)

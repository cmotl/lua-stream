describe('stream_multi', function()
  require 'stream'

  it('can perform multiple aggregations', function()
    assert.is.same(
      { 15, 3, 5 },
      Stream.stream({ 1, 2, 3, 4, 5 }):multi {
        Stream.aggregators.sum(),
        Stream.aggregators.average(),
        Stream.aggregators.max(),
      }
    )
  end)

  it('can perform multiple aggregations in a group_by specified as an array of aggregators', function()
    local groups = Stream.stream({ { 'a', 1 }, { 'b', 2 }, { 'a', 3 }, { 'b', 4 }, { 'a', 5 } }):group_by(
      function(pair)
        return pair[1]
      end,
      Stream.aggregators.multi {
        Stream.aggregators.sum(function(pair)
          return pair[2]
        end),
        Stream.aggregators.max(function(pair)
          return pair[2]
        end),
      }
    )

    assert.is.same({ a = { 9, 5 }, b = { 6, 4 } }, groups)
  end)

  it('can perform multiple aggregations in a group_by specified as table of aggregators', function()
    local groups = Stream.stream({ { 'a', 1 }, { 'b', 2 }, { 'a', 3 }, { 'b', 4 }, { 'a', 5 } }):group_by(
      function(pair)
        return pair[1]
      end,
      Stream.aggregators.multi {
        total = Stream.aggregators.sum(function(pair)
          return pair[2]
        end),
        max = Stream.aggregators.max(function(pair)
          return pair[2]
        end),
      }
    )

    assert.is.same({ a = { total = 9, max = 5 }, b = { total = 6, max = 4 } }, groups)
  end)
end)

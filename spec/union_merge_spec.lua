describe('stream_union_merge', function()
  require 'stream'

  it('can aggregate union_merge', function()
    assert.are.same({ a = 2, b = 2 }, Stream.stream({ { a = 1 }, { b = 2 }, { a = 1 } }):union_merge(Stream.aggregators.sum()))
  end)
end)

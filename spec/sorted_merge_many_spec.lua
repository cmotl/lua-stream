describe('stream_sorted_merge_many', function()
  require 'stream'

  it('can merge three streams', function()
    local streams = Stream.stream { Stream.stream { 0, 3, 6 }, Stream.stream { 1, 4, 7 }, Stream.stream { 2, 5, 8 } }
    local results = Stream.sorted_merge_many(streams):to_table()
    assert.are.same({ 0, 1, 2, 3, 4, 5, 6, 7, 8 }, results)
  end)

  it('can merge zero streams', function()
    local streams = Stream.empty()
    local results = Stream.sorted_merge_many(streams):to_table()
    assert.are.same({}, results)
  end)
end)

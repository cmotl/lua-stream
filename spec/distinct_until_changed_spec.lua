describe('stream_distinct_until_changed', function()
  require 'stream'

  it('can stream distinct until changed', function()
    assert.is.same({}, Stream.stream({}):distinct_until_changed():to_table())
    assert.is.same({ 8 }, Stream.stream({ 8 }):distinct_until_changed():to_table())
    assert.is.same({ 8 }, Stream.stream({ 8, 8 }):distinct_until_changed():to_table())
    assert.is.same({ 8, 4, 8 }, Stream.stream({ 8, 8, 4, 4, 4, 8, 8, 8, 8 }):distinct_until_changed():to_table())
    assert.is.same({ 1, 2, 3, 4, 5, 6 }, Stream.stream({ 1, 2, 3, 4, 5, 6 }):distinct_until_changed():to_table())
    assert.is.same(
      { 1, 2, 4, 6 },
      Stream.stream({ 1, 2, 3, 4, 5, 6 })
        :distinct_until_changed(function(x)
          return math.floor(x / 2)
        end)
        :to_table()
    )
  end)
end)

describe('stream_every_nth', function()
  require 'stream'

  it('can every_nth values', function()
    local values = { 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7 }
    local expected_values = { { 2, 3 }, { 3, 6 }, { 5, 9 }, { 6, 12 } }
    local actual_values = {}

    Stream.stream(values)
      :every_nth(3, function(value, total, current)
        table.insert(actual_values, { value, total })
      end)
      :to_table()

    assert.is.same(expected_values, actual_values)
  end)
end)

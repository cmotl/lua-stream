describe('stream_from_table_values', function()
  require 'stream'

  it('works with an empty input table', function()
    assert.is.same({}, Stream.from_table_values({}):to_table())
  end)

  it('returns the values when iterating a table', function()
    local t = { a = 1, b = 2 }

    local result = Stream.from_table_values(t):to_table()

    table.sort(result)
    assert.is.same({ 1, 2 }, result)
  end)
end)

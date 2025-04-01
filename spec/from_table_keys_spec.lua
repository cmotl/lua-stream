describe('stream_from_table_keys', function()
  require 'stream'

  it('works with an empty input table', function()
    assert.is.same({}, Stream.from_table_keys({}):to_table())
  end)

  it('returns the keys when iterating a table', function()
    local t = { a = 1, b = 2 }

    local result = Stream.from_table_keys(t):to_table()

    table.sort(result)
    assert.is.same({ 'a', 'b' }, result)
  end)
end)

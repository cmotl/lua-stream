describe('stream_from_table_keys_with_values', function()
  require 'stream'

  it('supports empty tables', function()
    assert.is.same({}, Stream.from_table_keys_with_values({}):to_table())
  end)

  it('streams tuples with the key and value', function()
    local t = { a = 1, b = 2 }

    local result = Stream.from_table_keys_with_values(t):to_table()

    table.sort(result, function(a, b)
      return a[1] < b[1]
    end)
    assert.is.same({ { 'a', 1 }, { 'b', 2 } }, result)
  end)
end)

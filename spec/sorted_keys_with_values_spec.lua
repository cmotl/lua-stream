describe('stream_sorted_keys_with_values', function()
  require 'stream'

  it('supports empty tables', function()
    assert.is.same({}, Stream.sorted_keys_with_values({}):to_table())
  end)

  it('sorts by key', function()
    local t = { a = 1, b = 2, c = 3, d = 4, e = 5, f = 6, g = 7 }

    local result = Stream.sorted_keys_with_values(t):to_table()

    assert.is.same({ { 'a', 1 }, { 'b', 2 }, { 'c', 3 }, { 'd', 4 }, { 'e', 5 }, { 'f', 6 }, { 'g', 7 } }, result)
  end)

  it('sorts by key using a comparison function', function()
    local t = { ['7'] = 1, ['66'] = 2, ['555'] = 3, ['4444'] = 4, ['33333'] = 5, ['222222'] = 6, ['1111111'] = 7 }

    local result = Stream.sorted_keys_with_values(t, function(x)
      return #x
    end):to_table()

    assert.is.same({ { '7', 1 }, { '66', 2 }, { '555', 3 }, { '4444', 4 }, { '33333', 5 }, { '222222', 6 }, { '1111111', 7 } }, result)
  end)
end)

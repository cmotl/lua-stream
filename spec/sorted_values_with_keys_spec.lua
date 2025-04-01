describe('stream_sorted_values_with_keys', function()
  require 'stream'

  it('supports empty tables', function()
    assert.is.same({}, Stream.sorted_values_with_keys({}):to_table())
  end)

  it('sorts by key', function()
    local t = { a = 7, b = 6, c = 5, d = 4, e = 3, f = 2, g = 1 }

    local result = Stream.sorted_values_with_keys(t):to_table()

    assert.is.same({ { 'g', 1 }, { 'f', 2 }, { 'e', 3 }, { 'd', 4 }, { 'c', 5 }, { 'b', 6 }, { 'a', 7 } }, result)
  end)

  it('sorts by key using a comparison function', function()
    local t = { a = '7', b = '66', c = '555', d = '4444', e = '33333', f = '222222', g = '1111111' }

    local result = Stream.sorted_values_with_keys(t, function(x)
      return #x
    end):to_table()

    assert.is.same({ { 'a', '7' }, { 'b', '66' }, { 'c', '555' }, { 'd', '4444' }, { 'e', '33333' }, { 'f', '222222' }, { 'g', '1111111' } }, result)
  end)
end)

describe('stream_buffer', function()
  require 'stream'

  it('can buffer values', function()
    local values = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 }
    local expected_values = { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 }, { 10, 11 } }
    local actual_values = {}

    Stream.stream(values):window(3):each(function(tuple)
      table.insert(actual_values, tuple)
    end)
    assert.is.same(expected_values, actual_values)
  end)
end)

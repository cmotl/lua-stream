describe('stream_flat_map', function()
  require 'stream'

  it('can flat map several values', function()
    local values = {
      { items = { 1, 2 } },
      { items = { 3, 4 } },
      { items = { 5, 6 } },
      { items = { 7, 8 } },
    }
    local expected_values = { 1, 2, 3, 4, 5, 6, 7, 8 }
    local values_written = {}

    local streamed_values = Stream.stream(values)
      :flat_map(function(value)
        return Stream.stream(value.items)
      end)
      :each(function(value)
        table.insert(values_written, value)
      end)

    assert.are.same(expected_values, values_written)
  end)

  it('can flat map values that are not iterable', function()
    local values = {
      { items = 2 },
      { items = 4 },
      { items = 6 },
      { items = 8 },
    }
    local expected_values = { 2, 4, 6, 8 }
    local values_written = {}

    local streamed_values = Stream.stream(values)
      :flat_map(function(value)
        return Stream.stream(value.items)
      end)
      :each(function(value)
        table.insert(values_written, value)
      end)

    assert.are.same(expected_values, values_written)
  end)

  it('can flat map with a default function', function()
    local values = {
      { 1, 2 },
      { 3, 4, 5 },
      { 6 },
    }
    local expected_values = { 1, 2, 3, 4, 5, 6 }

    local result = Stream.stream(values):flat_map():to_table()

    assert.is.same(expected_values, result)
  end)
end)

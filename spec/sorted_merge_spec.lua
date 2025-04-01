describe('stream_sorted_merge', function()
  require 'stream'

  it('can merge two streams', function()
    local results = Stream.sorted_merge(Stream.stream { 2, 4, 8, 10, 12 }, Stream.stream { 1, 3, 5, 7, 11, 13 }):to_table()
    assert.are.same({ 1, 2, 3, 4, 5, 7, 8, 10, 11, 12, 13 }, results)

    local results = Stream.sorted_merge(Stream.stream { 1, 2, 3, 4, 5 }, Stream.stream { 6, 7, 8, 9, 10 }):to_table()
    assert.are.same({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, results)

    local results = Stream.stream({ 1, 5, 9 }):sorted_merge(Stream.stream { 2, 3, 4, 6, 7, 8, 10 }):to_table()
    assert.are.same({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, results)

    local results = Stream.stream({ 1, 2, 5, 9 }):sorted_merge(Stream.stream { 2, 3, 4 }):to_table()
    assert.are.same({ 1, 2, 2, 3, 4, 5, 9 }, results)

    local results = Stream.stream({}):sorted_merge(Stream.stream { 2, 3, 4 }):to_table()
    assert.are.same({ 2, 3, 4 }, results)

    local results = Stream.stream({}):sorted_merge(Stream.stream {}):to_table()
    assert.are.same({}, results)
  end)

  it('can merge two streams with a complex comparator', function()
    local function transform_complex_value(input_table)
      return { input_table[1], input_table[2] }
    end

    local function compare_complex_values(a, b)
      if a[1] < b[1] then
        return true
      elseif b[1] < a[1] then
        return false
      elseif a[2] < b[2] then
        return true
      else
        return false
      end
    end

    local results = Stream.stream({ { 1, 0 }, { 1, 2 }, { 1, 4 } })
      :sorted_merge(Stream.stream { { 1, 1 }, { 1, 3 }, { 1, 5 } }, transform_complex_value, compare_complex_values)
      :to_table()
    assert.are.same({ { 1, 0 }, { 1, 1 }, { 1, 2 }, { 1, 3 }, { 1, 4 }, { 1, 5 } }, results)

    local results = Stream.stream({ { 1, 100 }, { 3, 50 }, { 5, 0 } })
      :sorted_merge(Stream.stream { { 1, 0 }, { 1, 50 }, { 1, 101 } }, transform_complex_value, compare_complex_values)
      :to_table()
    assert.are.same({ { 1, 0 }, { 1, 50 }, { 1, 100 }, { 1, 101 }, { 3, 50 }, { 5, 0 } }, results)

    local results = Stream.stream({ { 1, 100 }, { 3, 50 }, { 5, 0 } })
      :sorted_merge(Stream.stream { { 0, 0 }, { 2, 50 }, { 3, 49 } }, transform_complex_value, compare_complex_values)
      :to_table()
    assert.are.same({ { 0, 0 }, { 1, 100 }, { 2, 50 }, { 3, 49 }, { 3, 50 }, { 5, 0 } }, results)

    local results = Stream.stream({}):sorted_merge(Stream.stream {}, transform_complex_value, compare_complex_values):to_table()
    assert.are.same({}, results)
  end)
end)

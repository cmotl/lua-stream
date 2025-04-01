describe('stream', function()
  require 'stream'

  it('recognizes a stream object', function()
    assert.is.truthy(Stream.is_stream(Stream.range(1, 2)))
  end)

  it('knows that numbers are not stream objects', function()
    assert.is.falsy(Stream.is_stream(7))
  end)

  it('knows that nil is not a stream object', function()
    assert.is.falsy(Stream.is_stream(nil))
  end)

  it('knows that strings are not stream objects', function()
    assert.is.falsy(Stream.is_stream 'bob')
  end)

  it('knows that tables are not stream objects', function()
    assert.is.falsy(Stream.is_stream {})
  end)

  it('can iterate through a table lazily in the correct order', function()
    local values = { 1, 2, 3 }
    local spied_values = ''
    Stream.stream(values)
      :map(function(x)
        spied_values = spied_values .. 'a' .. x
        return x
      end)
      :map(function(x)
        spied_values = spied_values .. 'b' .. x
        return x
      end)
      :to_table()
    assert.is.equal('a1b1a2b2a3b3', spied_values)
  end)

  it('can stream a single value', function()
    assert.are.same({ 42 }, Stream.stream({ 42 }):to_table())
  end)

  it('can stream from an enumerable function', function()
    local expected_values = { 0, 1, 42, 113 }
    local generator_function = function()
      local index = 0
      return function()
        if index > #expected_values then
          return nil
        else
          index = index + 1
          return expected_values[index]
        end
      end
    end
    local actual_values = Stream.stream(generator_function()):to_table()

    assert.are.same({ 0, 1, 42, 113 }, Stream.stream(generator_function()):to_table())
  end)
end)

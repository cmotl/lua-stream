describe('sort_many_streams', function()
  local Stream = require 'stream'
  local SortManyStreams = require 'sort_many_streams'
  local items

  before_each(function()
    items = nil
  end)

  after_each(function()
    items = nil
  end)

  local function collect(stream)
    items = {}
    stream:each(function(item)
      table.insert(items, item)
    end)
  end

  it('can peek into an empty stream returning nil', function()
    local stream = SortManyStreams.stream {}

    assert.is.equal(nil, stream:peek_at_head())
  end)

  it('can peek into a stream seeing the first item and then returning the item later', function()
    local stream = SortManyStreams.stream {
      Stream.stream { 'foo' },
    }

    assert.is.equal('foo', stream:peek_at_head())

    collect(stream)

    assert.is.same({ 'foo' }, items)
  end)

  it('can peek into a stream seeing each item and then returning the item later', function()
    local stream = SortManyStreams.stream {
      Stream.stream { 'foo' },
      Stream.stream { 'bar', 'baz' },
    }

    assert.is.equal('bar', stream:peek_at_head())
    assert.is.equal('bar', stream:first())

    assert.is.equal('baz', stream:peek_at_head())
    assert.is.equal('baz', stream:first())

    stream:add_stream(Stream.stream { 'zed' })

    assert.is.equal('foo', stream:peek_at_head())
    assert.is.equal('foo', stream:first())

    stream:add_stream(Stream.stream { 'alittlelate' })

    assert.is.equal('alittlelate', stream:peek_at_head())
    assert.is.equal('alittlelate', stream:first())

    assert.is.equal('zed', stream:peek_at_head())
    assert.is.equal('zed', stream:first())
  end)

  it('produces an empty stream for no inputs', function()
    collect(SortManyStreams.stream {})

    assert.is.same({}, items)
  end)

  it('produces an empty stream for a single empty input', function()
    collect(SortManyStreams.stream {
      Stream.empty(),
    })

    assert.is.same({}, items)
  end)

  it('produces an empty stream for multiple empty inputs', function()
    collect(SortManyStreams.stream {
      Stream.empty(),
      Stream.empty(),
    })

    assert.is.same({}, items)
  end)

  it('copies a single input stream', function()
    collect(SortManyStreams.stream {
      Stream.stream { 1, 2, 3 },
    })

    assert.is.same({ 1, 2, 3 }, items)
  end)

  it('can merge with empty stream', function()
    collect(SortManyStreams.stream {
      Stream.empty(),
      Stream.stream { 1, 2, 3 },
    })

    assert.is.same({ 1, 2, 3 }, items)
  end)

  it('can merge many items with the same times', function()
    -- This test case exposes an invalid sort function issue
    assert.has_no.errors(function()
      collect(SortManyStreams.stream {
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
        Stream.stream { 1 },
      })
    end)
  end)

  it('can merge three streams', function()
    collect(SortManyStreams.stream {
      Stream.stream { 1, 4, 7 },
      Stream.stream { 2, 5, 8 },
      Stream.stream { 3, 6, 9 },
    })

    assert.is.same({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, items)
  end)

  it('can merge three streams via an accessor', function()
    collect(SortManyStreams.stream({
      Stream.stream { 7, 4, 1 },
      Stream.stream { 8, 5, 2 },
      Stream.stream { 9, 6, 3 },
    }, function(item)
      return 0 - item
    end))

    assert.is.same({ 9, 8, 7, 6, 5, 4, 3, 2, 1 }, items)
  end)

  it('can merge reused reference table objects', function()
    local aindex = 1
    local avalues = { '1A', '2A', '3A' }
    local a = { name = 'foo' }
    local function producer_a()
      if aindex <= #avalues then
        a.name = avalues[aindex]
        aindex = aindex + 1
        return a
      end
    end

    local bindex = 1
    local bvalues = { '1B', '2B', '3B' }
    local b = { name = 'boo' }
    local function producer_b()
      if bindex <= #bvalues then
        b.name = bvalues[bindex]
        bindex = bindex + 1
        return b
      end
    end

    items = SortManyStreams.stream({
      Stream.stream(producer_a),
      Stream.stream(producer_b),
    }, function(rec)
      return rec.name
    end)
      :map(function(rec)
        return rec.name
      end)
      :to_table()

    assert.is.same({ '1A', '1B', '2A', '2B', '3A', '3B' }, items)
  end)

  it('can merge three streams via an accessor and comparator', function()
    local map = {
      ['Z'] = 7,
      ['Q'] = 4,
      ['A'] = 1,
      ['Charles'] = 8,
      ['Bob'] = 6,
      ['Alice'] = 2,
      [6] = 9,
      [4] = 5,
      [2] = 3,
    }
    collect(SortManyStreams.stream({
      Stream.stream { 'Z', 'Q', 'A' },
      Stream.stream { 'Charles', 'Bob', 'Alice' },
      Stream.stream { 6, 4, 2 },
    }, function(item)
      return map[item]
    end, function(a, b)
      return a >= b
    end))

    assert.is.same({ 6, 'Charles', 'Z', 'Bob', 4, 'Q', 2, 'Alice', 'A' }, items)
  end)

  it('can add a new stream to an existing empty sort many streams object', function()
    local stream = SortManyStreams.stream {}
    local second_stream = Stream.stream { 1, 5, 7 }
    local third_stream = Stream.stream { 2, 4, 6 }

    stream:add_stream(third_stream)
    stream:add_stream(second_stream)

    collect(stream)

    assert.is.same({ 1, 2, 4, 5, 6, 7 }, items)
  end)

  it('can add a new stream after pulling some items', function()
    local stream = SortManyStreams.stream { Stream.stream { 1, 5, 10 } }
    local second_stream = Stream.stream { 2, 6, 11 }
    local third_stream = Stream.stream { 3, 7, 12 }

    items = {}

    stream:take(2):each(function(item)
      table.insert(items, item)
    end)

    stream:add_stream(second_stream)
    stream:take(3):each(function(item)
      table.insert(items, item)
    end)

    stream:add_stream(third_stream)
    stream:each(function(item)
      table.insert(items, item)
    end)

    assert.is.same({ 1, 5, 2, 6, 10, 3, 7, 11, 12 }, items)
  end)
end)

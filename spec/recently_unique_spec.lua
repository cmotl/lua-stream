describe('stream_recently_unique', function()
  require 'stream'

  describe('without an accessor function', function()
    it('produces an empty output stream for an empty input stream', function()
      local input_values = {}

      local output_values = Stream.stream(input_values):recently_unique():to_table()

      assert.is.same(input_values, output_values)
    end)

    it('produces a single output item for a single input item', function()
      local input_values = { 1 }

      local output_values = Stream.stream(input_values):recently_unique():to_table()

      assert.is.same(input_values, output_values)
    end)

    it('produces multiple output items for multiple unique input items', function()
      local input_values = { 1, 2 }

      local output_values = Stream.stream(input_values):recently_unique():to_table()

      assert.is.same(input_values, output_values)
    end)

    it('does not output the same value twice', function()
      local input_values = { 1, 2, 1, 2, 3 }

      local output_values = Stream.stream(input_values):recently_unique():to_table()

      assert.is.same({ 1, 2, 3 }, output_values)
    end)
  end)

  describe('with an accessor function', function()
    local accessor_fn = function(x)
      return math.floor(x / 2)
    end

    it('produces an empty output stream for an empty input stream', function()
      local input_values = {}

      local output_values = Stream.stream(input_values):recently_unique(accessor_fn):to_table()

      assert.is.same(input_values, output_values)
    end)

    it('produces a single output item for a single input item', function()
      local input_values = { 1 }

      local output_values = Stream.stream(input_values):recently_unique(accessor_fn):to_table()

      assert.is.same(input_values, output_values)
    end)

    it('produces multiple output items for multiple unique input items', function()
      local input_values = { 1, 2 }

      local output_values = Stream.stream(input_values):recently_unique(accessor_fn):to_table()

      assert.is.same(input_values, output_values)
    end)

    it('only outputs the first item for a given accessor function result', function()
      local input_values = { 1, 3, 1, 2, 2, 4, 5 }

      local output_values = Stream.stream(input_values):recently_unique(accessor_fn):to_table()

      assert.is.same({ 1, 3, 4 }, output_values)
    end)
  end)

  describe('limited size', function()
    it('defaults to remembering 10000 items', function()
      local x = Stream.concat(Stream.range(1, 10000), Stream.return_value(1)):recently_unique():last()
      assert.is.equal(10000, x)
    end)

    it('defaults to forgetting after 10000 items', function()
      local x = Stream.concat(Stream.range(1, 65537), Stream.return_value(1)):recently_unique():last()
      assert.is.equal(1, x)
    end)

    it('can be limited to fewer items', function()
      local x = Stream.concat(Stream.range(1, 10000), Stream.return_value(1)):recently_unique(nil, 9999):last()
      assert.is.equal(1, x)
    end)
  end)
end)

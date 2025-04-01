describe('stream_running_accumulator', function()
  require 'stream'

  local counting_aggregator_factory

  before_each(function()
    counting_aggregator_factory = function()
      local count = 0
      return function(x)
        count = count + 1
        return count
      end
    end
  end)

  it('should apply aggregator for single key and single item', function()
    local result = Stream.stream({ 'a', 5, { 12, 15, 17 } }):running_accumulator(counting_aggregator_factory):to_table()

    assert.are.same({ 1, 2, 3 }, result)
  end)
end)

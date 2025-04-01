describe('stream_write', function()
  require 'stream'

  it('can write values', function()
    local values = { 1, 2, 3, 4 }
    local values_written = {}

    local mock_writer = {
      write = function(value)
        table.insert(values_written, value)
      end,
    }

    local streamed_values = Stream.stream(values):write(mock_writer)

    assert.is.same(values, values_written)
  end)
end)

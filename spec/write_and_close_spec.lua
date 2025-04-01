describe('stream_write_and_close', function()
  require 'stream'

  it('can write values and close', function()
    local values = { 1, 2, 3, 4 }
    local values_written = {}
    local closed = false

    local mock_writer = {
      write = function(value)
        table.insert(values_written, value)
      end,
      close = function()
        closed = true
      end,
    }

    local streamed_values = Stream.stream(values):write_and_close(mock_writer)

    assert.is.same(values, values_written)
    assert.is.equal(closed, true)
  end)
end)

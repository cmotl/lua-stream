describe('stream_take', function()
  require 'stream'

  it('can take values', function()
    assert.is.same({ 1, 2 }, Stream.stream({ 1, 2, 3, 4 }):take(2):to_table())
  end)
end)

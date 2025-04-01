describe('stream_drop', function()
  require 'stream'

  it('can drop values', function()
    assert.is.same({ 3, 4 }, Stream.stream({ 1, 2, 3, 4 }):drop(2):to_table())
  end)
end)

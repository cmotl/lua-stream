describe('stream_head', function()
  require 'stream'

  it('can head values', function()
    assert.is.same({ 1, 2 }, Stream.stream({ 1, 2, 3, 4 }):head(2):to_table())
  end)
end)

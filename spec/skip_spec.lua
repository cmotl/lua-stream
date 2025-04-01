describe('stream_skip', function()
  require 'stream'

  it('can skip values', function()
    assert.is.same({ 3, 4 }, Stream.stream({ 1, 2, 3, 4 }):skip(2):to_table())
  end)
end)

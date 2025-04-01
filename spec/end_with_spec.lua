describe('stream_end_with', function()
  require 'stream'

  it('can end with', function()
    assert.is.same({ 1 }, Stream.stream({}):end_with(1):to_table())
    assert.is.same({ 1, 2, 3, 7 }, Stream.stream({ 1, 2, 3 }):end_with(7):to_table())
    assert.is.same({ 1, 2, 3, { 7, 8 } }, Stream.stream({ 1, 2, 3 }):end_with({ 7, 8 }):to_table())
    assert.is.same({ 1, 2, 3, 7, 8 }, Stream.stream({ 1, 2, 3 }):end_with(7, 8):to_table())
  end)
end)

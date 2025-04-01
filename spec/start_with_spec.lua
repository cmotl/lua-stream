describe('stream_start_with', function()
  require 'stream'

  it('can start with', function()
    assert.is.same({ 1 }, Stream.stream({}):start_with(1):to_table())
    assert.is.same({ 7, 1, 2, 3 }, Stream.stream({ 1, 2, 3 }):start_with(7):to_table())
    assert.is.same({ { 7, 8 }, 1, 2, 3 }, Stream.stream({ 1, 2, 3 }):start_with({ 7, 8 }):to_table())
    assert.is.same({ 7, 8, 1, 2, 3 }, Stream.stream({ 1, 2, 3 }):start_with(7, 8):to_table())
  end)
end)

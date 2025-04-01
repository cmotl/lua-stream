describe('stream_tail', function()
  require 'stream'

  it('can get the tail', function()
    assert.is.same({}, Stream.stream({}):tail(1):to_table())
    assert.is.same({ 4 }, Stream.stream({ 1, 2, 3, 4 }):tail(1):to_table())
    assert.is.same({ 3, 4 }, Stream.stream({ 1, 2, 3, 4 }):tail(2):to_table())
    assert.is.same({ 1, 2, 3, 4 }, Stream.stream({ 1, 2, 3, 4 }):tail(4):to_table())
    assert.is.same({ 1, 2, 3, 4 }, Stream.stream({ 1, 2, 3, 4 }):tail(5):to_table())
  end)
end)

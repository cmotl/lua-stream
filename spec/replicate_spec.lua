describe('stream_replicate', function()
  require 'stream'

  it('can replicate a value a given number of times', function()
    assert.is.same({ 1 }, Stream.replicate(1, 1):to_table())
    assert.is.same({ 1, 1, 1 }, Stream.replicate(1, 3):to_table())
    assert.is.same({ 1, 1, 1, 1, 1, 1 }, Stream.replicate(1, 6):to_table())
    assert.is.same({}, Stream.replicate(1, 0):to_table())
    assert.has_error(function()
      Stream.replicate(1, -1):to_table()
    end)
  end)
end)

describe('stream_range', function()
  require 'stream'

  it('can generate a range of values', function()
    assert.are.same({ 1, 2, 3, 4, 5 }, Stream.range(1, 5):to_table())
    assert.are.same({}, Stream.range(4, 3):to_table())
    assert.are.same({ 42 }, Stream.range(42, 42):to_table())
  end)
end)

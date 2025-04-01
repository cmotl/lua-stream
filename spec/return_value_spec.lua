describe('stream_return_value', function()
  require 'stream'

  it('can stream a return_value', function()
    assert.are.same({ 42 }, Stream.return_value(42):to_table())
  end)
end)

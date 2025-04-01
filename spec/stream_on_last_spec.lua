describe('stream_on_last', function()
  require 'stream'

  local t

  before_each(function()
    t = {}
    stub(t, 'fn')
  end)

  it('calls the user function for an empty stream', function()
    Stream.empty():on_last(t.fn):apply()

    assert.stub(t.fn).was_called()
  end)

  it('does not call the user function if the stream is not drained', function()
    Stream.stream({ 1, 2 }):on_last(t.fn):take(1):apply()

    assert.stub(t.fn).was_not_called()
  end)

  it('calls the user function with the last item that went through the stream', function()
    Stream.stream({ 1, 2, 3 }):on_last(t.fn):apply()

    assert.stub(t.fn).was_called.with(3)
  end)
end)

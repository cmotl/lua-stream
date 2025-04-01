describe('stream_on_first', function()
  require 'stream'

  local t

  before_each(function()
    t = {}
    stub(t, 'fn')
  end)

  it('never calls the user function for an empty stream', function()
    Stream.empty():on_first(t.fn):apply()

    assert.stub(t.fn).was_not_called()
  end)

  it('calls the user function even if only a single item is pulled from the stream', function()
    Stream.stream({ 1, 2 }):on_first(t.fn):take(1):apply()

    assert.stub(t.fn).was_called.with(1)
  end)

  it('only calls the user function once even if many items are pulled from the stream', function()
    Stream.stream({ 4, 5, 6 }):on_first(t.fn):apply()

    assert.stub(t.fn).was_called(1)
    assert.stub(t.fn).was_called_with(4)
  end)

  it('never calls the user function if no items are pulled from the stream', function()
    Stream.stream({ 1, 2, 3 }):on_first(t.fn)

    assert.stub(t.fn).was_not_called()
  end)
end)

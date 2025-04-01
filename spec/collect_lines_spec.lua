describe('stream_collect_lines', function()
  require 'stream'

  it('returns no output for no input', function()
    local result = Stream.empty():collect_lines():to_table()

    assert.is.same({}, result)
  end)

  it('returns a simple string input as the output', function()
    local result = Stream.stream({ 'Hello, world!' }):collect_lines():to_table()

    assert.is.same({ 'Hello, world!' }, result)
  end)

  it('concatenates strings if no newline is detected', function()
    local result = Stream.stream({ 'a', 'b', 'c' }):collect_lines():to_table()

    assert.is.same({ 'abc' }, result)
  end)

  it('splits newlines into multiple strings', function()
    local result = Stream.stream({ 'a\nb\nc' }):collect_lines():to_table()

    assert.is.same({ 'a', 'b', 'c' }, result)
  end)

  it('strips blank lines', function()
    local result = Stream.stream({ '\na\n\nb\n\nc\n' }):collect_lines():to_table()

    assert.is.same({ 'a', 'b', 'c' }, result)
  end)

  it('works with Windows line endings', function()
    local result = Stream.stream({ 'a\r\nb\r\nc' }):collect_lines():to_table()

    assert.is.same({ 'a', 'b', 'c' }, result)
  end)
end)

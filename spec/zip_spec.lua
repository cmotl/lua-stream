describe('stream_zip', function()
  require 'stream'

  it('can zip streams', function()
    assert.are.same(
      { { 1, 6 }, { 2, 7 }, { 3, 8 }, { 4, 9 }, { 5, 0 } },
      Stream.zip(Stream.stream { 1, 2, 3, 4, 5 }, Stream.stream { 6, 7, 8, 9, 0 }):to_table()
    )
    assert.are.same({ { 1, 6 }, { 2, 7 }, { 3, 8 }, { 4, 9 } }, Stream.zip(Stream.stream { 1, 2, 3, 4, 5 }, Stream.stream { 6, 7, 8, 9 }):to_table())
    assert.are.same({}, Stream.zip(Stream.stream { 1, 2, 3, 4, 5 }, Stream.stream {}):to_table())
    assert.are.same({}, Stream.zip(Stream.stream {}, Stream.stream {}):to_table())
    assert.are.same({ { 1, 6 }, { 2, 7 }, { 3, 8 }, { 4, 9 }, { 5, 0 } }, Stream.stream({ 1, 2, 3, 4, 5 }):zip(Stream.stream { 6, 7, 8, 9, 0 }):to_table())
  end)
end)

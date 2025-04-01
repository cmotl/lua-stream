describe('stream_concat', function()
  require 'stream'

  it('can concat', function()
    assert.is.same({}, Stream.stream().concat({}, {}):to_table())
    assert.is.same({ 1 }, Stream.stream().concat({ 1 }, {}):to_table())
    assert.is.same({ 1 }, Stream.stream().concat({}, { 1 }):to_table())
    assert.is.same({ 1, 2 }, Stream.stream().concat({ 1 }, { 2 }):to_table())
    assert.is.same({ 1, 2, 3 }, Stream.stream().concat({ 1, 2 }, { 3 }):to_table())
    assert.is.same({ 1, 2, 3 }, Stream.stream().concat({ 1 }, { 2, 3 }):to_table())
    assert.is.same({ 1, 2, 3 }, Stream.stream().concat({ 1 }, { 2 }, { 3 }):to_table())
    assert.is.same({ 1, 2, 3, 4, 5, 6, 7, 8 }, Stream.stream().concat({ 1, 2 }, { 3, 4 }, { 5, 6, 7, 8 }):to_table())
  end)
end)

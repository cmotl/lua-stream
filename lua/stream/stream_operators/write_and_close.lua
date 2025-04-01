function Stream:write_and_close(writer)
  self:write(writer)
  writer.close()
end

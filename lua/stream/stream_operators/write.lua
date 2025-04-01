function Stream:write(writer)
  self:each(writer.write)
end

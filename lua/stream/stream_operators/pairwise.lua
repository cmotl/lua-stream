function Stream:pairwise()
  return self:running_accumulator(Stream.aggregators.pairwise())
end

local SortManyStreams = require 'sort_many_streams'

function Stream.sorted_merge(stream1, stream2, accessor, comparator)
  return SortManyStreams.stream({ stream1, stream2 }, accessor, comparator)
end

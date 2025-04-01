local SortManyStreams = require 'sort_many_streams'

function Stream.sorted_merge_many(streams, accessor, comparator)
  return SortManyStreams.stream(streams, accessor, comparator)
end

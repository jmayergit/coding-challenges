# https://www.interviewcake.com/question/ruby/merging-ranges

######## Solution 1 ###############
## sorts meeting times then combines continguous and/or overlapping meetings

def merge(left, right)
  result = []
  i,j = 0, 0
  while i < left.length && j < right.length
    start_time_comparison = left[i][0] <=> right[j][0]
    end_time_comparison = left[i][1] <=> right[j][1]
    if start_time_comparison == -1
      result << left[i]
      i += 1
    elsif start_time_comparison == 1
      result << right[j]
      j += 1
    else
      if end_time_comparison <= 0
        result << left[i]
        i += 1
      else
        result << right[j]
        j += 1
      end
    end
  end

  if i < left.length
    result.concat(left[i..-1])
  end

  if j < right.length
    result.concat(right[j..-1])
  end

  result
end

def mergeSort(list)
  if list.length < 2
    list[0..-1]
  else
    middle = list.length / 2
    left = mergeSort(list[0...middle])
    right = mergeSort(list[middle..-1])
    merge(left, right)
  end
end

# For example:
# meaningful_overlap_or_contiguous([0,2],[1,3]) => true
# meaningful_overlap_or_contiguous([0,2],[2,3]) => true
# meaningful_overlap_or_contiguous([0,2],[3,4]) => false
# meaningful_overlap_or_contiguous([0,2],[1,2]) => false
def meaningful_overlap_or_contiguous(before_range, after_range)
  return (after_range[0] <= before_range[1]) && (after_range[1] > before_range[1])
end

def condense_meeting_times(meeting_time_ranges)
  sorted_meeting_time_ranges = mergeSort(meeting_time_ranges)
  condensed_ranges = []
  sorted_meeting_time_ranges.each do |range|
    if condensed_ranges.empty?
      condensed_ranges << range
    else
      if meaningful_overlap_or_contiguous(condensed_ranges[-1], range)
        condensed_ranges[-1][1] = range[1]
      else
        condensed_ranges.insert(-1, range)
      end
    end
  end

  return condensed_ranges
end

######## Solution 2 ###############
## crazy initial solution, doesn't sort and takes at least O(n^2.75) time

def condense_meeting_times_2(meeting_time_ranges)
  i = 0
  while i < meeting_time_ranges.length
    amoeba = meeting_time_ranges[i]
    j = 0
    while j < meeting_time_ranges.length
      unless j == i
        current = meeting_time_ranges[j]
        # right extension
        if (current[0] >= amoeba[0] && current[0] <= amoeba[1]) && (current[1] > amoeba[1])
          meeting_time_ranges[i] = [amoeba[0], current[1]]
          meeting_time_ranges.delete_at(j)
          j = 0
        # left extension
        elsif (current[0] < amoeba[0]) && (current[1] >= amoeba[0] && current[1] <= amoeba[1])
          meeting_time_ranges[i] = [current[0], amoeba[1]]
          meeting_time_ranges.delete_at(j)
          j = 0
        # within
        elsif (current[0] >= amoeba[0]) && (current[1] <= amoeba[1])
          meeting_time_ranges.delete_at(j)
        else
          j += 1
        end
      end

      if j == i
        j += 1
      end
    end

    i += 1
  end

  meeting_time_ranges
end

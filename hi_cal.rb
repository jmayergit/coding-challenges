# sorts interview times then combines continguous and/or overlapping meetings

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

# crazy solution that doesn't sort

def condense_meeting_times(meeting_time_ranges)
  # takes an array of meeting time ranges and returns an array of condensed ranges
  # https://www.interviewcake.com/question/ruby/merging-ranges

  i = 0
  while i < meeting_time_ranges.length
    amoeba = meeting_time_ranges[i]
    j = 0
    puts "amoeba:"
    print amoeba
    puts "\n"
    while j < meeting_time_ranges.length
      unless j == i
        current = meeting_time_ranges[j]
        puts "current:"
        print current
        puts "\n"
        # right extension
        if (current[0] >= amoeba[0] && current[0] <= amoeba[1]) && (current[1] > amoeba[1])
          puts "right extension"
          meeting_time_ranges[i] = [amoeba[0], current[1]]
          meeting_time_ranges.delete_at(j)
          j = 0
        # left extension
        elsif (current[0] < amoeba[0]) && (current[1] >= amoeba[0] && current[1] <= amoeba[1])
          puts "left extension"
          meeting_time_ranges[i] = [current[0], amoeba[1]]
          meeting_time_ranges.delete_at(j)
          j = 0
        # within
        elsif (current[0] >= amoeba[0]) && (current[1] <= amoeba[1])
          puts "within"
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

  puts "RETURN:"
  print meeting_time_ranges
end


condense_meeting_times(      [ [0, 1], [3, 5], [4, 8], [10, 12], [9, 10] ])

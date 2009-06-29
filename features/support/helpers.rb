def english_to_number(word)
  words = %w(zero one two three four five six seven eight nine ten)
  number = words.index(word)
  raise "english_to_number doesnt know how to interpret #{word}" unless number
  number
end

require "./ruby_lab"

$bigram = Hash.new {|h,k| h[k] = Hash.new(0) }

test = "hello there how are you hello i hello there how are you hello i hello i hello you hello you hello you hello i"

def addToBigram(line)
  words = line.split(/\s/)
  (0 ... words.length).each do |i|
    if i < words.length-1 #second to last word
      $bigram[words[i]][words[i+1]] += 1
    end
  end
end


def mcw(word)
  ans = ""
  highest = 0
  $bigram[word].each do |word2, value|
    if value > highest
      ans = word2
      highest = value
    end
  end
  ans
end

# if cleanup_title("%TRMMMLF128F4228771<SEP>SOLGCKQ12A8AE47CFA<SEP>Leo Marini<SEP>Acércate Más") != nil
#   puts "hi"
# else
#   puts "hello"
# end
process_file("a_tracks.txt")

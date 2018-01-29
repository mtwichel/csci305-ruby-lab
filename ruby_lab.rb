
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# <firstname> <lastname>
# <email-address>
#
###############################################################

$bigrams = Hash.new {|h,k| h[k] = Hash.new(0) } # The Bigram data structure, line taken from https://anandimmannavar.wordpress.com/2013/05/06/ruby-nested-hash-initialization/
$name = "<Marcus> <Twichel>"

# function to process each line of a file and extract the song titles

def cleanup_title(title)
	title.sub!(/\A.*(?=<SEP>)<SEP>/, "")
	title.sub!(/\s?(\[|\(|{|\\|\/|\_|\-|\:|\"|\`|\+|\=|\*|feat.).*/, "")
		title.gsub!(/\?|¿|!|¡|\.|;|&|@|%|#|\|/, "")
		if (title =~ /\A(\w|\s|')*\z/)!= nil
			title.downcase!
		else
			title = nil
		end
		title
	end

	def mcw(word)
		ans = ""
		highest = 0
		$bigrams[word].each do |word2, value|
			if value > highest
				ans = word2
				highest = value
			end
		end
		ans
	end

	def addToBigram(line)
		words = line.split(/\s/)
		(0 ... words.length).each do |i|
			if i < words.length-1 	#second to last word
				$bigrams[words[i]][words[i+1]] += 1
			end
		end
	end

	def create_title(starting_word)
		process_file("a_tracks.txt")
		ans = starting_word
		tracking_word = starting_word
		(0 ... 20).each do
			if(mcw(tracking_word) != "")
				ans += " #{mcw(tracking_word)}"
				tracking_word = mcw(tracking_word)
			end
		end
		ans
	end

	def process_file(file_name)
		puts "Processing File.... "
		# begin
		IO.foreach(file_name, encoding: "utf-8") do |line|
			clean_line = cleanup_title(line)
			if(clean_line != nil)
				addToBigram(clean_line)
			end
		end

		puts "Finished. Bigram model built.\n"

	# rescue
	# 	STDERR.puts "Could not open file"
	# 	exit 4
	# end
end

# Executes the program
def main_loop()
	puts "CSCI 305 Ruby Lab submitted by #{$name}"

	if ARGV.length < 1
		puts "You must specify the file name as the argument."
		exit 4
	end

	# process the file
	process_file(ARGV[0])

	# Get user input
	while true do
		puts "Please enter the first word (or \"q\" to quit): "
		choice = $stdin.gets.chomp
		if(choice.downcase == "q")
			exit 4
		end
			puts create_title(choice)
	end
end

if __FILE__==$0
	main_loop()
end

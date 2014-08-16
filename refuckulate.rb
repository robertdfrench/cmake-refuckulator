#!/usr/bin/env ruby
# CMake Refuckulator
# Converts CMake projects into Autotools projects
# Copyright 2014 Robert D. French

class Logger
	def initialize
		@log_count = 0
	end

	def log(msg)
		@log_count += 1
		sleep(0.7)
		puts "[CMKREF #{@log_count}] #{msg}"
	end
end

def log(msg)
	@logger.log(msg)
end

def is_cmake?
	File.exists? "CMakeLists.txt"
end

def banner
	log "Checking to see if your project is totally fucked"
end

def cmd(msg)
	puts "==> #{msg}"
	system msg
end

def throw_out(ext)
	cmd "find . -regextype posix-egrep -regex \".*\\.(#{ext})$\" -delete"
end


def refuckulate
	log "Deleting this stupid Lists.txt bullshit"
	cmd "rm CMakeLists.txt"
	log "What kind of fucked up bullshit did you even have in there?"
	throw_out "c"
	log "Those weren't gonna compile anyway"
	throw_out "cpp"
	log "Cory! Trevor! Get in there and throw out the rest of this shit"
	throw_out "f|f77|F|py|pl|C|cxx|sh"
end

def main
	@logger = Logger.new
	banner

	log "Looking around for CMakeLists.txt or any other greasy bullshit"
	if is_cmake?
		log "Yup, found CMakeLists.txt"
		log "Your project is fucked in the head."
		refuckulate
	else
		log "Okay, move along. Nothing here to see."
	end
end

main

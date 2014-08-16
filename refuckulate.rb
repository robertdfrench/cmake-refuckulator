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

def convert_to_autotools
	log "Assuming you have gcc and bash"
	log "If your system doesn't have gcc and bash, you're fucked in the head anyways"
	File.open("configure","w") do |f|
		f.write "#!/bin/bash"
		f.write "echo \"Checking for CMake... NO (fucking decent!)\""
		f.write "echo \"HAVE_CMAKE_PROBLEMS=NO\" >> make.inc"
	end
	cmd "chmod +x configure"
	File.open("Makefile","w") do |f|
		f.write "include make.inc"
		f.write "cmake-is-fucked.exe: main.c"
		f.write "\tgcc -o cmake-is-fucked.exe main.c"
	end
	File.open("main.c","w") do |f|
		f.write "#include <stdio.h>"
		f.write "int main() {"
		f.write "printf(\"CMake is completely fucked in the head\n\");"
		f.write "return 0;"
		f.write "}"
	end
end

def main
	@logger = Logger.new
	banner

	log "Looking around for CMakeLists.txt or any other greasy bullshit"
	if is_cmake?
		log "Yup, found CMakeLists.txt"
		log "Your project is fucked in the head."
		refuckulate
		log "Converting to something decent, like autotools"
		convert_to_autotools
		log "Alright, you cheeseburger-eatin bastard, your shit is converted"
		log "Run ./configure and make like any normal person would"
	else
		log "Okay, move along. Nothing here to see."
	end
end

main

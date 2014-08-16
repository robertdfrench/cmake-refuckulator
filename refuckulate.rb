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
		sleep(0.3)
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

def main
	@logger = Logger.new
	banner

	log "Looking around for CMakeLists.txt or any other greasy bullshit"
	if is_cmake?
		log "Yup, found CMakeLists.txt"
		log "Your project is fucked in the head."
	else
		log "Okay, move along. Nothing here to see."
	end
end

main

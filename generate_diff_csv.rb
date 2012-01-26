#!/usr/bin/env ruby

require 'date'

str = `git log -p -U0 --no-merges diplom.tex`.split(/commit \w+\n/)

str.shift

commit_count = 0
line_count = 0

puts "COMMIT,A_POS,A_COUNT,B_POS,B_COUNT,LINE_COUNT,R,G,B"

str.reverse.each do |commit|
  #puts l
	commit_count += 1
	commit.scan(/Date:\s+(.+)\n/)
	date = Date.parse($1)
  changes = commit.scan(/@@\s(.+)\s@@/).map!{|c| c[0].gsub(/[\+\-]/,'').split(/\s/).map!{|b| b.include?(',') ? b.split(',') : (b+",1").split(',')}}
  #puts changes.inspect
	changes.each do |change|
		if change[0][1] < change[1][1]
			color = "0,255,0"
		elsif change[0][1] == change[1][1]
			color = "255,255,0"
		else
			color = "255,0,0"
		end
		line_count += (change[1][1].to_i - change[0][1].to_i)
		puts "#{commit_count},#{change[0][0]},#{change[0][1]},#{change[1][0]},#{change[1][1]},#{line_count},#{color}"
	end
end

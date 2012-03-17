#!/usr/bin/env ruby

f = File.open("diplom.tex")

labels = {}
cites = {}
refs = {}

f.each do |line|
	#puts "#{f.lineno}: #{line}"
  #f.lineno
  labels[f.lineno] = line.match(/^\\label{(.+)}/)[1] if line.match(/^\\label{(.+)}/)
  line.scan(/\\cite[^{]*{([^}]+)}/) do |m|
    if cites[f.lineno]
      cites[f.lineno] << m[0]
    else
      cites[f.lineno] = m
    end
  end

  line.scan(/\\ref{([^}]+)}/) do |m|
    if refs[f.lineno]
      refs[f.lineno] << m[0]
    else
      refs[f.lineno] = m
    end
  end

end

puts labels.inspect
puts labels.count
puts
puts cites.inspect
c = 0
cites.each {|k,v| c += v.count}
puts c
puts
puts refs.inspect
c = 0
refs.each {|k,v| c += v.count}
puts c

res = []

cites.each do |k,v|
  v.each do |vv|

    puts "#{k}\t1513\tcite\t#{vv}"
    res << [k,1513,"cite",vv]
  end
end

refs.each do |k,v|
  v.each do |vv|
    labels.each do |kkk,vvv|
      if vvv == vv
        type = vvv[0..2]
        if k <= kkk
          puts "#{k}\t#{kkk}\t#{type}\t#{vvv[4..vvv.length]}"
          res << [k,kkk,type,vvv[4..vvv.length]]
        else
          puts "#{kkk}\t#{k}\t#{type}\t#{vvv[4..vvv.length]}"
          res << [k,kkk,type,vvv[4..vvv.length]]
        end
      end
    end
  end
end

orange = "225,150,18"
purple = "91,22,151"
green = "38,186,15"
pink = "204,16,66"
blue = "21,87,145"

res.each do |r|
  r[2] = orange if r[2] == "cha"
  r[2] = pink if r[2] == "sec"
  r[2] = blue if r[2] == "fig"
  r[2] = purple if r[2] == "tab"
  r[2] = green if r[2] == "cite"
end

puts "y1,y2,r,g,b,name"

res.each do |r|
  puts "#{r[0]},#{r[1]},#{r[2]},#{r[3]}"
end

require '../fanfou-rb/fanfou'

begin
  acc = IO.readlines('account.txt')
rescue
  puts "Unable to read account.txt"
  exit -1
end

loginname = acc[0].chomp
password  = acc[1].chomp

bot = Fanfou.new(loginname, password)

to_follow = []
followed = []

File.open("to_follow.txt", "r") do |f|
  f.each_line do |item|
    item = item.chomp
    to_follow << item
    followed << item if bot.follow(item)
  end
end

File.open("followed.txt", "a+") do |f|
  followed.each do |item|
    f << item+"\n"
  end
end

# Prune to_follow.txt
not_followed = to_follow - followed
File.open("to_follow.txt", "w+") do |f|
  not_followed.each do |item|
    f << item+"\n"
  end
end

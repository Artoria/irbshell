#!irbshell

!wget "https://github.com/Artoria/irbshell/raw/master/ar-get.list"
x = File.read("ar-get.list").split(/\n/)
if ARGV[0] == 'get'
  eval("!wget --no-check-certificate \"https://github.com/Artoria/irbshell/raw/master/ar-get/#{ARGV[1]}/get.rb\" -o ar-get/#{ARGV[1]}/get.rb")
  eval("ar-get/#{ARGV[1]}/get.rb")
end

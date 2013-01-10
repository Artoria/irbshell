#!irbshell

!wget "http://github.com/Artoria/irbshell/ar-get.list"
x = File.read("ar-get.list").split(/\n/)
if ARGV[0] == 'get'
  eval("!wget --no-check-certificate \"https://github.com/Artoria/irbshell/ar-get/#{ARGV[1]}/get.rb\"")
end

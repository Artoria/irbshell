alias my_eval eval
require 'irb'
def eval(str, *a)
  ret = if str[0] == '!'
    system str[1, str.length-1]
  else
    my_eval str, *a
  end
  cd = `echo %cd%`.chomp + ">"
  IRB.conf[:PROMPT_MODE] = :CUSTOM
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_I => cd,
   :PROMPT_S => cd,
   :PROMPT_C => cd,
   :PROMPT_N => cd,
   :RETURN => "=> %s\n"
  }
  ret
end

IRB.start
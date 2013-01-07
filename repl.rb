alias my_eval eval
$: << File.dirname(__FILE__)
begin
  load ".irbshrc" 
rescue LoadError
end
require 'irb'

$PS1 = "Dir.getwd.tr('/', '\\\\') + '>'"
$PS_ = 0
def eval(str, *a)
  ret = if str[0] == '!'
    system str[1, str.length-1]
  else
    my_eval str, *a
  end
  cd = my_eval $PS1
  def cd.dup
    my_eval $PS1
  end
  $PS_ += 1
  name = "CUSTOM#{$PS_}".to_sym
  IRB.conf[:PROMPT][name] = {
   :PROMPT_I => cd,
   :PROMPT_S => cd,
   :PROMPT_C => cd,
   :PROMPT_N => cd,
   :RETURN => "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = name
  ret
end

IRB.start
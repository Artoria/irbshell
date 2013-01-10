alias my_eval eval



require 'irb'



module IREPL
  EVALS = []
  def cmd(reg, &block)
    EVALS.push [reg, block]
  end

  def set_prompt
    $PS1 = "Dir.getwd.tr('/', '\\\\') + '>'"
    cd = my_eval $PS1

    def cd.dup
       my_eval $PS1
    end

    IRB.conf[:PROMPT][:CUSTOM] = {
       :PROMPT_I => cd,
       :PROMPT_S => cd,
       :PROMPT_C => cd,
       :PROMPT_N => cd,
       :RETURN => "=> %s\n"
    }
    IRB.conf[:PROMPT_MODE] = :CUSTOM
  end

  def eval(str, *a)
      r = EVALS + [[/.*/, method(:my_eval)]]
      x = r.select{|k| k[0] =~ str}
      ret = false
      x.each{|y|
        y[0] =~ str
        $ARG = $~
        ret = y[1].call(str, *a)
        break if ret
      }
      set_prompt unless $PS1
      ret
  end

end



class Object
  include IREPL
end

$: << File.dirname(__FILE__)
begin
  load ".irbshrc" 
rescue LoadError
end

IRB.start

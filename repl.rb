alias my_eval eval
require 'irb'
require 'optparse'



module IREPL
  EVALS    = []
  IREPLDIR = File.expand_path(File.dirname(__FILE__))
  IREPLNAME = File.basename(__FILE__)
  MYOPT = {}

  OptionParser.new do |opts|
  opts.banner = "Usage: ruby #{IREPLNAME} [-s]"
    opts.on("-s", " ", "Silent mode(no irb prompt)") do |v|
      MYOPT[:silent] = true
    end
  end.parse!

#  IARGV = ARGV.dup
#  ARGV[0..-1]=[]
  
  def current_or_runtime(x)
    FileTest.exists?(x) ? x : runtime(x)
  end

  def runtime(x)
    File.join(IREPLDIR, x)
  end
  def save_data(obj, file)
    open(file, 'wb'){|f| f.write Marshal.dump obj}
  end

  def load_data(file)
    open(file, 'rb'){|f| Marshal.load f}
  end

  def cmd(reg, &block)
    EVALS.push [reg, block]
  end

  def set_prompt
    $PS1 = "Dir.getwd.tr('/', '\\\\') + '>'"
    cd = my_eval $PS1
    def cd.dup
       my_eval $PS1
    end
    
    if MYOPT[:silent]
      IRB.conf[:PROMPT][:CUSTOM] = {
       :PROMPT_I => "",
       :PROMPT_S => "",
       :PROMPT_C => "",
       :PROMPT_N => "",
       :RETURN => ""
      }
      IRB.conf[:INSPECT_MODE]= false
    else
     IRB.conf[:PROMPT][:CUSTOM] = {
       :PROMPT_I => cd,
       :PROMPT_S => cd,
       :PROMPT_C => cd,
       :PROMPT_N => cd,
       :RETURN => "=> %s\n"
     }
   end
    IRB.conf[:PROMPT_MODE] = :CUSTOM
  end

  def eval(str, *a)
      r = EVALS + [[/.*/, lambda{|*a| my_eval(*a)}]]
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

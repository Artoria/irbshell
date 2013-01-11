irbshell
========

IRB-based OS Shell

basic usage
=====

ruby repl.rb

now mostly look like an ordinary IRB, with an exception that it prompts current directory instead.
(you could use global variable $PS1 to change the prompt)

==>To run a program, use "!" before command line, e.g.
<pre>
 >!git init
</pre>

if you use +sh, "!" could be omited. The effect of +sh is permanent, until you use "-sh".

<pre>
 >+sh git
 >git init
 >-sh git
 #you must use !git init now.
</pre>

==>To do normal ruby calculation:
<pre>
 >3+5
 => 8
</pre>
This is the default behavior of IRB.

==>To define a customized command, this is just the way we define other stuff:
see .irbshrc

<pre>
 > cmd /say\s*(.*)/ do |line, *a|
    puts $ARG[1] # $ARG is used like $~, $ARG[1] is like $1, but exactly what after "say"
    true
 end
 >say Hello
 Hello
 => true
</pre>

==>To write a script:
>!vim a.rb
then write and save as a.rb:
<pre>
#!irbshell
1.00
cd ".."
puts "Hello world"
</pre>

and then:

>a.rb
#!irbshell
#!irbshell
1.00
cd ".."
puts "Hello world"
Hello world
=> "#!irbshell"

we can now only see mix script and user-input/output, this will be improved in future.








usage of mk
=====
The behaviors are defined in the default .irbshrc

<ul>
<li>mk will copy template file or directory to the destination, always the target file/directory, 
when it comes to directory, it NEVER means the container but just the copy target)</li>

<li>mk! is the forcely overwriting version of mk(like in vim)</li>

<li>if the target is a directory, and has a 'setup.rb' inside,
the behavior will change.
mk will not copy the data, but just run 'setup.rb' in the context of newly-created directory first.
</li>

</ul>

a full example:
(you can refer to "templates/sample_zlib_project/setup.rb")
<pre>
  mk! cpp a/main.cpp
  mk! addrake a
  mk! zlib a
  cd a
  rake
</pre>


usage of script files
=====
The behaviors are defined in the default .irbshrc

File with shebang("#!") in the first line will be run differently:

<ol>
<li>when:
  the first line is "#!irbshell"
or 
  the first line is "#!irbshell here"
will be interpreted just like input in IRB, with irbshell.
</li>

<li>
  Because shebang is just a prompt, 
<pre>
  #!xxxxxx
  yyyy
</pre>
  will be interpreted like, assume the filename is 'filename':
irbshell>xxxxxx filename
  
  see examples below:
  assume a.rb is an irbshell script:
<pre>
#!a.rb
  puts "Hello"
</pre>

  assume a is an OS executable, note there is an extra "!", just like we type "!a filename" in irbshell:
<pre>
#!!a
 Hello
</pre>

 
  
</li>



</ol>







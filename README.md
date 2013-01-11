irbshell
========

IRB-based OS Shell

basic usage
=====

ruby repl.rb

now mostly look like an ordinary IRB, with an exception that it prompts current directory instead.

To run a program, use "!" before command line, e.g.

<pre>
  +sh git
  +sh ls
  git init
  ls
</pre>

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







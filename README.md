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
<ul>
<li>mk will copy template file or directory to the destination, always the target file/directory, 
when it comes to directory, it NEVER means the container but just the copy target)</li>

<li>mk! is the forcely overwriting version of mk(like in vim)</li>

<li>if the target is a directory, and has a 'setup.rb' inside,
the behavior will change.
mk will not copy the data, but just run 'setup.rb' in the context of newly-created directory
</li>

</ul>


another full example:
(you can refer to "templates/sample_zlib_project/setup.rb")
<pre>
  mk! cpp a/main.cpp
  mk! addrake a
  mk! zlib a
  cd a
  rake
</pre>



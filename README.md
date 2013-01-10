irbshell
========

IRB-based OS Shell

usage
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

another full example:
(you can refer to "templates/sample_zlib_project/setup.rb")
<pre>
  mk! cpp a/main.cpp
  mk! addrake a
  mk! zlib a
  cd a
  rake
</pre>



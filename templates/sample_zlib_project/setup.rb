#!irbshell
1.00

eval("cd #{ARGV[0]}")
mk! cpp main.cpp
mk! addrake . 3
mk! zlib . 3


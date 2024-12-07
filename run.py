import sys, os
name = sys.argv[1]
os.system("nasm -f elf64 -o _.o " + name + ".s")
os.system("ld _.o -o _")
os.system("./_")
# ./run [name_task]
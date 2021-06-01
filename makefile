libPath = $(CURDIR)/build-system-lib
libIncludePath = $(CURDIR)/build-system-lib/include
# 增量编译依赖 依赖关系。make 会根据add.o 自动推导依赖 add.c，但头文件需要显式指定
project : $(libPath)/mathLib.h main.o mathLib.o add.o sub.o
	clang -o project main.o mathLib.o add.o sub.o

main.o : $(libPath)/mathLib.h mathLib.o
	clang -c -I$(libPath) -I$(libIncludePath) main.c

mathLib.o : $(libPath)/mathLib.h $(libIncludePath)/sub.h $(libIncludePath)/add.h sub.o add.o
	clang -c -I$(libIncludePath) -I$(libPath) $(libPath)/mathLib.c

add.o : $(libIncludePath)/add.h
	clang -c -I$(libIncludePath) $(libPath)/add/add.c

sub.o : $(libIncludePath)/sub.h
	clang -c -I$(libIncludePath) $(libPath)/sub/sub.c

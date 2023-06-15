xGraph: plantilla.o xGraph.c check_key.c
	gcc -m32 check_key.c xGraph.c -lX11 plantilla.o -o xGraph -no-pie 

plantilla.o: plantilla.asm
	nasm -f elf32 plantilla.asm -g -F dwarf

clean:
	rm *.o

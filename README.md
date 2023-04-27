# assembly_UIs
Assembly User Interfaces for Linux i386


Terminal Raw Mode - Echo Disabled / Just check for keystroke without
waiting for enter key hit.

C++ Graphical mode using Server X and Xlib. Planned for assembly interface.

#Dependencies
#To install Xlib support for i386

sudo dpkg -add-architecture i386
sudo apt-get update
sudo apt-get install libx11-dev:i386
sudo apt-get instal g++-multilib

#Instructions
#The xGraph.c file contains the c interface with the Xlib X window Server.
#For to make the bin file must be included the library reference in the link process,
#in this case with GCC. The flag -lX11 points to the shared library libX11.
#The commands in the example correpond to the asm file xGraph_client.asm and the xGraph.c 
#interface. Into the assembly file the shared functions (from the interface) are marked with
#de directive 'external'.

nasm -f elf32 xGraph_client.asm -g -F dwarf
gcc -m32 xGraph.c -lX11 xGraph_client.o -o xGraph -no-pie
./xGraph 


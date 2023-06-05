#include <stdio.h>
#include <stdlib.h>
#include <sys/select.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>

char check_key(void);
char check_key(void){

    char c; //Caracter que se lee si el buffer no está vacío.

    //Se establece en modo crudo la terminal.
    struct termios term;
    tcgetattr(0, &term);
    term.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(0, TCSANOW, &term);

    //Número de bytes pendientes en el buffer stdin.
    int bytesWaiting;

        /*Lee la cantidad de datos en el buffer. Si es mayor a 0 lee un caracter
        y después limpia el buffer de entrada*/
        ioctl(0, FIONREAD, &bytesWaiting);
        if(bytesWaiting > 0){
            c = getc(stdin);
            tcflush(0, TCIFLUSH);
            }
        else
            c = 0;

        sleep(0.9); //Delay (podría quitarse).

    /*Termina la función de checar el teclado y regresa la consola
    a modo cooked*/
    term.c_lflag |= ICANON | ECHO;
    tcsetattr(0, TCSANOW, &term);

    //Si se leyó un caracter se retorna este sino se retorna 0.
    return c;
}
#include <stdio.h>
#include <stdlib.h>
#include <sys/select.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>

int main(void){

    char c;

    struct termios term;
    tcgetattr(0, &term);

    //struct termios term2 = term;
    term.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(0, TCSANOW, &term);

    int bytesWaiting;

    for(;;){ 
        ioctl(0, FIONREAD, &bytesWaiting);
        if(bytesWaiting > 0){
            c = getc(stdin);
            printf("DATA %c \n", c);
            tcflush(0, TCIFLUSH);
            break;}
            
        else
            printf("NO DATA\n");

        sleep(0.9);
    }

    term.c_lflag |= ICANON | ECHO;
    tcsetattr(0, TCSANOW, &term);

    return 1;

}
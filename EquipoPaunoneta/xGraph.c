#include <X11/Xlib.h>
#include <unistd.h>
#include <stdio.h>

#define SNK_SIZE 10

char _setup();
void _draw();
void _drawString();
void _createRectangle(int index, short int x, short int y);

Display* disp;

Window ventana;
XColor color;
XRectangle recArray[SNK_SIZE];

char stringDraw[] = {'G','a','m','e',' ','O','v','e','r','!'};
char setUpSuccess = 0;
int size = 1;
short int height = 10;
short int width = 10;
/*int main (){
    setup();
    createRectangle(1,100,100,50,50);
    draw();

    return 0;
}*/

char _setup(char* s){

	disp = XOpenDisplay(NULL);
    
    if (disp == NULL){
        //printf("No se pudo realizar la conexion con el servidor X");
        return 0;
    }

    ventana = XCreateSimpleWindow (
		disp,
		XDefaultRootWindow (disp),
		0, 0,
		500, 500,
		1, 1,
		BlackPixel (disp, DefaultScreen(disp)));

    XSelectInput(disp, ventana, StructureNotifyMask);
	XMapWindow (disp, ventana);
	XFlush (disp);

    color.flags = DoRed | DoGreen | DoBlue;
	color.red = 65535;
	color.blue = 0;
	color.green = 0;

	XAllocColor (
		disp,
		DefaultColormap (disp, DefaultScreen(disp)),
		&color);

	
	XSetForeground (
		disp,
		XDefaultGC (disp, DefaultScreen(disp)),
		color.pixel);

    for(;;){
        XEvent e;
        XNextEvent(disp, &e);
        if(e.type == MapNotify)
            return 1;
    }

}

void _draw(){
        XClearWindow(disp, ventana);
        //_drawString();
        XFillRectangles (disp, ventana, XDefaultGC (disp, DefaultScreen(disp)),
		    recArray, size);
	    XFlush (disp);
        usleep(10000);
        
}

void _drawfinal(){
        XClearWindow(disp, ventana);
        _drawString();
        /*XFillRectangles (disp, ventana, XDefaultGC (disp, DefaultScreen(disp)),
		    recArray, size);*/
	    XFlush (disp);
        usleep(10000);
}

void _drawString(){
    if (setUpSuccess){
        XDrawImageString (disp, ventana, XDefaultGC (disp, DefaultScreen(disp)), 
            10, 10, stringDraw, 11);
	    XFlush (disp);
    }
}

void _createRectangle(int index, short int x, short int y){
    recArray[index].x = x;
    recArray[index].y = y;
    recArray[index].height = height;
    recArray[index].width = width;
    size=10;
}


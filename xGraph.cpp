//#include <X11/Xlib.h>
//#include <unistd.h>
#include <stdio.h>

#define SNK_SIZE 10

void _setup();
void _draw();
void _drawString();
void _createRectangle(char index, int x, int y, int height, int width);
/*
Display* disp;
Window ventana;
XColor color;
XRectangle recArray[SNK_SIZE];
*/
char stringDraw[] = {'H','o','l','a',' ','M','u','n','d','o','!'};
bool setUpSuccess = false;
char size = 1;

/*int main (){
    setup();
    createRectangle(1,100,100,50,50);
    draw();

    return 0;
}
*/
void _setup(char* s){/*

	disp = XOpenDisplay(NULL);
    
    if (disp == NULL){
        //printf("No se pudo realizar la conexion con el servidor X");
        return false;
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
            return true;
    }
*/

}

void _draw(){/*
        XClearWindow(disp, ventana);
        _drawString();
        XFillRectangles (disp, ventana, XDefaultGC (disp, DefaultScreen(disp)),
		    recArray, size);
	    XFlush (disp);*/
        //sleep(1);
}

void _drawString(){/*
    if (setUpSuccess){
        XDrawImageString (disp, ventana, XDefaultGC (disp, DefaultScreen(disp)), 
            10, 10, stringDraw, 11);
	    XFlush (disp);
    }
    */
}

void _createRectangle(char index, int x, int y, int height, int width){/*
    recArray[index].x = x;
    recArray[index].y = y;
    recArray[index].height = height;
    recArray[index].width = width;
    size++;*/
}
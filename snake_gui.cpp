#include <X11/Xlib.h>
#include <unistd.h>
#include <stdio.h> 

struct {
    Display *disp;
    Window ventana;
    XColor color;
} Wininstance;

XRectangle recArray[2];

int setup();
void draw();
void drawString();

char stringDraw[] = {'H','o','l','a',' ','M','u','n','d','o','!'};


int main(){

    if(setup() == 1){
        printf("Inicializacion correcta!\n");

        for(int i = 0; i<15; i++){
            recArray[0].x = 100 + (i*20);
            recArray[0].y = 100;
            recArray[0].height = 10;
            recArray[0].width = 10;

            recArray[1].x = 110 + (i*20);
            recArray[1].y = 100;
            recArray[1].height = 10;
            recArray[1].width = 10;

            draw();

            sleep(1);
        } 
    }
    else{
        printf("Error al inicializar\n");
    }

    return 0;
}

int setup(){

	Wininstance.disp = XOpenDisplay(NULL);
    
    if (Wininstance.disp == NULL){
        printf("No se pudo realizar la conexion con el servidor X");
        return 0;
    }

    Wininstance.ventana = XCreateSimpleWindow (
		Wininstance.disp,
		XDefaultRootWindow (Wininstance.disp),
		0, 0,
		500, 500,
		1, 1,
		BlackPixel (Wininstance.disp, DefaultScreen(Wininstance.disp)));

    XSelectInput(Wininstance.disp, Wininstance.ventana, StructureNotifyMask);
	XMapWindow (Wininstance.disp, Wininstance.ventana);
	XFlush (Wininstance.disp);

    Wininstance.color.flags = DoRed | DoGreen | DoBlue;
	Wininstance.color.red = 65535;
	Wininstance.color.blue = 0;
	Wininstance.color.green = 0;

	XAllocColor (
		Wininstance.disp,
		DefaultColormap (Wininstance.disp, DefaultScreen(Wininstance.disp)),
		&Wininstance.color);

	/* Indicamos que el color de dibujo a partir de ahora es el rojo */
	XSetForeground (
		Wininstance.disp,
		XDefaultGC (Wininstance.disp, DefaultScreen(Wininstance.disp)),
		Wininstance.color.pixel);

    for(;;){
        XEvent e;
        XNextEvent(Wininstance.disp, &e);
        if(e.type == MapNotify)
            return 1;
    }

}

void draw(){
        XClearWindow(Wininstance.disp,Wininstance.ventana);
        drawString();
        XFillRectangles (
		Wininstance.disp,
		Wininstance.ventana,
		XDefaultGC (Wininstance.disp, DefaultScreen(Wininstance.disp)),
		recArray,1);

	    XFlush (Wininstance.disp);
}

void drawString(){
        XClearWindow(Wininstance.disp,Wininstance.ventana);

        XDrawImageString (
		Wininstance.disp,
		Wininstance.ventana,
		XDefaultGC (Wininstance.disp, DefaultScreen(Wininstance.disp)),
        10, 10,
		stringDraw,11);

	    XFlush (Wininstance.disp);

}
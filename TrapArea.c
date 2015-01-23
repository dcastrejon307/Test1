#include <stdio.h>
#include <stdint.h> //For C99 compatability

extern int CalTrapArea();

int main(int argc, char* argv[])
{
    //Run Assembly Code
    CalTrapArea();
    
    return 0;
}
;==== Begin code area ====
extern _printf                                       ;External C function for output
extern _scanf                                        ;External C function for input
extern _sin                                          ;External C function for sin math function

segment .data                                       ;Place initialized data in this segment

    stringData db "%s", 10, 0
    input1 db "Enter the length of one side of the parallelogram: ", 0
    input2 db "Enter the length of the second side of the parallelogram: ", 0
    input3 db "Enter the size in degrees of the included angle: ", 0

    floatOutput db "You entered: %5.2Lf", 0         ;Don't forget the uppercase L

    floatData db "%Lf", 0

segment .bss                                        ;Place uninitialized data in this segment

    ;Currently this section is empty

segment .text                                       ;Place executable statements in this segment

    global _CalTrapArea

_CalTrapArea:                                       ;Entry Point Label.

;==== Necessary Operations! Do not remove!
    push        rbp                                 ;Save a copy of the stack base pointer !IMPORTANT
    push        rdi                                 ;Save since we will use this for our external printf function
    push        rsi                                 ;Save since we will use this for our external printf function

;==== Enable Floating Point Operations
    finit                                           ;Reset pointers to st registers; reset control word, status word, and tag word.

;============ INPUT 1 ==============
;==== Ask for first input
    mov qword   rax, 0                              ;A zero in rax indicates that printf receives standard parameters
    mov         rdi, stringData
    mov         rsi, input1
    call        _printf

;==== Grab input from Keyboard
    mov qword  rax, 0                               ;A zero in rax indicates that printf receives standard parameters
    mov        rdi, floatData                       ;Tell scanf to accept a long float as the data input
    push qword 0                                    ;8 byes reserved. Need 10 bytes
    push qword 0                                    ;Another 8 bytes reserved for a total of 16 bytes
    mov        rsi, rsp                             ;rsi now points to the 16 bytes we have open. (rsp = Stack Pointer)
    call       _scanf                                ;C now uses the scanf function

;==== Copy 10 byte number into Float space
    fld tword  [rsp]                                ;Load Float space and push rsp into the float stack. (braquests de-reference)

;============ INPUT 2 ==============
;=== Ask for second input
    mov qword   rax, 0                              ;A zero in rax indicates that printf receives standard parameters
    mov         rdi, stringData
    mov         rsi, input2
    call        _printf

;==== Grab input from Keyboard
    mov qword  rax, 0                               ;A zero in rax indicates that printf receives standard parameters
    mov        rdi, floatData                       ;Tell scanf to accept a long float as the data input
    push qword 0                                    ;8 byes reserved. Need 10 bytes
    push qword 0                                    ;Another 8 bytes reserved for a total of 16 bytes
    mov        rsi, rsp                             ;rsi now points to the 16 bytes we have open. (rsp = Stack Pointer)
    call       _scanf                                ;C now uses the scanf function

;==== Copy 10 byte number into Float space
    fld tword  [rsp]                                ;Load Float space and push rsp into the float stack. (braquests de-reference)

;============ INPUT 3 ==============
;=== Ask for third input
    mov qword   rax, 0                              ;A zero in rax indicates that printf receives standard parameters
    mov         rdi, stringData
    mov         rsi, input3
    call        _printf

;==== Grab input from Keyboard
    mov qword   rax, 0                              ;A zero in rax indicates that printf receives standard parameters
    mov         rdi, floatData                      ;Tell scanf to accept a long float as the data input
    push qword  0                                   ;8 byes reserved. Need 10 bytes
    push qword  0                                   ;Another 8 bytes reserved for a total of 16 bytes
    mov         rsi, rsp                            ;rsi now points to the 16 bytes we have open. (rsp = Stack Pointer)
    call        _scanf                               ;C now uses the scanf function

;==== Copy 10 byte number into Float space
    fld tword  [rsp]                                ;Load Float space and push rsp into the float stack. (braquests de-reference)

;============ TEMP ==============

;============ Output ==============
    mov qword   rax, 0
    mov         rdi, floatOutput
    mov qword   rax, 1                              ;Important for floats??!
    push qword  0                                   ;8 bytes reserved
    push qword  0                                   ;16 bytes reserved
    fstp qword [rsp]                                ;Pop the fp number from the FP stack into the storage at [rsp]
    call       _printf

;============ Restore Registers ============
    pop rsi
    pop rdi
    pop rbp                                         ;Restore base pointer

;==== Time to exit this function ====
;Prepare to exit from this function
    mov qword rax, 0                               ;A zero in rax is the code indicating a successful execution.
    ret                                             ;ret pops the stack taking away 8 bytes

;==== End of function calcAndPrint ====
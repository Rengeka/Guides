# Macros

## What is macro?

A macro is a preprocessor directive that defines a sequence of instructions or code, which can be reused multiple times throughout the program. It can take parameters and is **substituted** by the assembler wherever it is used before actual assembly.

Example:
```asm
%macro MY_MACRO
    push 10
    pop
%endmacro

.func:
    MY_MACRO
```

Is similar to: 
```asm
.func:
    push 10
    pop
```

## %define 

Single-line macros are defined using %define directive

Syntax:
```asm
%define <name>([<param1>, <param2>, ...]) <code>
```

Example (without parameters):
```asm
%define PUSH_EBP push ebp
```

Example (with parameters):
```asm
%define MY_MACRO(x) x+1
```

You can overload such macro:
```asm
%define FOO(x) 1+x 
%define FOO(x,y) 1+x*y
```

The preprocessor will choos the correct one according to parameters

**Note:** If you define: ``` %define FOO 1+1 ``` then no other definition of foo will be accepted!

## %undef

Use %undef to remove macro

Syntax:
```asm
%undef <name>
```

Example:
```asm
%define PUSH_EBP push ebp

.func_1:
    PUSH_EBP    ;   Macro exists here

%undef PUSH_EBP

.func_2:
    PUSH_EBP    ;   Compilation error. Macro no longer exists
```

## %macro

%macro is a definition for multiline macro

Syntax:
```asm
%macro <name> [num_parameters]
    <code>
%endmacro
```

Example:
```asm
%macro MY_MACRO 1
    push ebp 
    mov ebp, esp 
    sub esp, %1     ;   Use %n to access macro parameter 
%endmacro
```

## Greedy macro

Use greedy macro to access dynamic amount of parameters

Example: from 0 parameters (all arguments captured)
```asm
%macro MY_MACRO -1
    push %1
    push %2
    push %3
%endmacro
```

Example: at least 2 parameters
```asm
%macro MY_MACRO +2
    push %1
    push %2
    push %3
%endmacro
```

## %assign

%assign is used to define single-line macros which take no parameters and have a numeric value. This value can be specified in the form of an expression, and it will be evaluated once, when the %assign directive is processed.

```asm
%assign i 0        ; initialize i to 0

; increment i
%assign i i+1      ; now i = 1
```

## %idefine and %iassign

%idefine and %iassign macros are processed during insensitive stage and can be used in if/else statements
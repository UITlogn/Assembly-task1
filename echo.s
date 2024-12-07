section .bss
    s resb 33       ; s: resb: reserve byte (chưa được khởi tạo giá trị) đội dài tối đa 32 (byte)
    len equ $ - s

section .data

section .text
    global _start

_start:
    mov rax, 0      ; 0: read
    mov rdi, 0      ; 0: stdin
    mov rsi, s      ; cần nhập vào s
    mov rdx, len    ; số byte dữ liệu
    syscall

    mov rax, 1      ; 1: write
    mov rdi, 1      ; 1: stdout
    mov rsi, s      ; dữ liệu cần in ra là s
    mov rdx, len    ; số byte dữ liệu
    syscall

    mov rax, 60     ; 60: exit
    mov rdi, 0      ; exit(0)
    syscall
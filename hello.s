section .bss    ; khai báo biến

section .data   ; khởi tạo biến có giá trị
    s   db  "Hello, World!", 10     ; db:define byte, s="Hello, World!\n", 10 là kí tự xuống dòng
    len equ $ - s                   ; len(s)

section .text
    global _start

_start:
    mov rax, 1      ; 1: write
    mov rdi, 1      ; 1: stdout
    mov rsi, s      ; dữ liệu cần in ra là s
    mov rdx, len    ; số byte dữ liệu
    syscall

    mov rax, 60     ; 60: exit
    mov rdi, 0      ; exit(0)
    syscall
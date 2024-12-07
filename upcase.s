section .bss
    s resb 33       ; s: resb: reserve byte (chưa được khởi tạo giá trị) đội dài tối đa 32 (byte)
    len equ $ - s

section .data

section .text
    global _start

_start:
    ; nhập s
    mov rax, 0
    mov rdi, 0
    mov rsi, s
    mov rdx, len
    syscall

    ; chuyển đổi s từ chữ thường thành chữ hoa
    mov rsi, 0      ; i = 0

    loop:
        cmp byte [s + rsi], 0   ; kiểm tra s[i] có phải kí tự kết thúc chuỗi (null) không
        jz done                 ; nếu là null -> done

        ; kiểm tra ký tự có phải là chữ thường (a-z) không 
        cmp byte [s + rsi], 'a' ; so sánh s[i] với 'a'
        jl next                 ; (jump if less) nếu s[i] < 'a' -> không phải chữ thường 
        cmp byte [s + rsi], 'z' ; so sánh s[i] với 'z'
        jg next                 ; (jump if greater) nếu s[i] > 'z' -> không phải chữ thường

        ; nếu s[i] là chữ thường 
        sub byte [s + rsi], 32  ; thì chuyển s[i] thành chữ hoa (s[i] -= 32)

    next:
        inc rsi             ; ++i
        jmp loop            ; quay lại vòng lặp

    done:               ; chạy xong vòng lặp thì in ra s thôi
    
    ; in ra s sau khi đã biến đổi
    mov rax, 1
    mov rdi, 1
    mov rsi, s
    mov rdx, len
    syscall

    ;exit
    mov rax, 60
    mov rdi, 0
    syscall
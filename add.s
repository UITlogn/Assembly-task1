section .bss
    a resb 33
    b resb 33

section .data
    pow dq 0
    numA dq 0
    numB dq 0
    numC dq 0 ; numC = numA + numB

section .text
    global _start

_start:
    ; nhập a (str)
    mov rax, 0
    mov rdi, 0
    mov rsi, a
    mov rdx, 100
    syscall

    ; chuyển a thành số nguyên lưu vào numA
    mov rsi, a          ; *rsi = a + 0 (con trỏ vào vị trí đầu tiên của a)
    mov rax, 0
    loopA:
        movzx rbx, byte [rsi]   ; rbx = *rsi = a[i]
        test rbx, rbx  ; nếu *rsi = null (hết xâu -> done)
        jz doneA
        cmp rbx, '0'    ; rbx < '0' -> done
        jl doneA
        cmp rbx, '9'    ; rbx > '9' -> done
        jg doneA
        imul rax, 10    ; rax *= 10
        sub rbx, '0'
        add rax, rbx    ; rax += rbx - '0' (ascii to int)
        inc rsi         ; ++rsi
    jmp loopA
    doneA:
        mov [numA], rax ; lưu vào numA
    
    ; nhập b (str)
    mov rax, 0
    mov rdi, 0
    mov rsi, b
    mov rdx, 100
    syscall

    ; chuyển b thành số nguyên lưu vào numB
    mov rsi, b          ; *rsi = b + 0 (con trỏ vào vị trí đầu tiên của b)
    mov rax, 0
    loopB:
        movzx rbx, byte [rsi]   ; rbx = *rsi = b[i]
        test rbx, rbx  ; nếu *rsi = null (hết xâu -> done)
        jz doneB
        cmp rbx, '0'    ; rbx < '0' -> done
        jl doneB
        cmp rbx, '9'    ; rbx > '9' -> done
        jg doneB
        imul rax, 10    ; rax *= 10
        sub rbx, '0'
        add rax, rbx    ; rax += rbx - '0' (ascii to int)
        inc rsi         ; ++rsi
    jmp loopB
    doneB:
        mov [numB], rax ; lưu vào numB

    ; numC = numA + numB
    mov rax, 0      ; rax = 0
    add rax, [numA] ; rax += numA
    add rax, [numB] ; rax += numB
    mov [numC], rax ; numC = rax
    
    ; tính pow = 10^(len(numC) - 1)
    mov rax, [numC]     ; rax = numC
    mov rbx, 1          ; rbx = 1: thanh ghi tính giá trị cho pow
    loop:
        mov rdx, 0      ; phải reset thanh ghi lưu số dư (rax%rcx)
        mov rcx, 10     ; rcx = 10
        div rcx         ; rax /= rcx
        cmp rax, 0      ; nếu rax == 0 -> endloop
        jz endloop
        imul rbx, 10    ; rbx *= 10
    jmp loop
    endloop:
    mov [pow], rbx      ; lấy rbx gán lại cho pow

    ; print(numC): hàm in ra số nguyên
    print:
        mov rdx, 0
        mov rax, [numC]
        mov rcx, [pow]
        div rcx         ; numC / pow = rax dư rdx
        mov rdx, 0
        mov rcx, 10
        div rcx         ; tiếp tục lấy rax % 10 dư rdx
        add rdx, 48     ; rdx + '0' (ascii) để thành kí tự
        mov [a], rdx    ; lưu vào a để in ra màn hình
        ; In kí tự a
        mov rax, 1
        mov rdi, 1
        mov rsi, a
        mov rdx, 1
        syscall
        ; pow /= 10
        mov rdx, 0
        mov rax, [pow]
        mov rcx, 10
        div rcx
        mov [pow], rax
        cmp rax, 0  ; pow == 0: break
        jz done
    jmp print
    done:
    
    ;exit
    mov rax, 60
    mov rdi, 0
    syscall
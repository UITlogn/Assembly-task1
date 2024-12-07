## Assembly Task 1

### Bài 1: In Hello World [hello.s]

Cú pháp để in ra màn hình:
```asm
mov rax, 1
mov rdi, 1
mov rsi, s
mov rdx, len
syscall
```
Cụ thể:
* rax = (0: read, 1: write, 60: exit, ...)
* rdi = (0: stdin, 1: stdout, ...)
* rsi = nội dung cần in ra (bytes)
* rds = kích thước (byte)

### Bài 2: Nhập xuất xâu [echo.s]

Cú pháp để nhập vào từ bàn phím (console):
```asm
mov rax, 0
mov rdi, 0
mov rsi, s
mov rdx, len
syscall
```
Cụ thể:
* rsi = địa chỉ nhập
* rds = kích thước (byte)

### Bài 3: Chữ thường thành chữ hoa [upcase.s]

Sau khi nhập vào xâu s, đặt con trỏ rsi trỏ vào đầu xâu s. Chạy vòng lặp cho đến khi con trỏ rsi đến kí tự kết thúc thì dừng. Ở mỗi bước, kiểm tra nếu không phải kí tự trong đoạn 'a'..'z' thì không làm gì, ngược lại thì biến đổi thành kí tự in hoa tương ứng (ascii-32).

Cú pháp vòng lặp trong xâu s:
```asm
mov rsi, s    ; *rsi = s + 0
loop:
    movzx rbx, byte [rsi]    ; rbx = rsi = s[i]
    test rbx, rbx    ; rbx == null: break
    jz done
    
    ; do some thing
    ; continue = next
    ; break = done
    
next:
    inc rsi
    jmp loop
done:
    
```

### Bài 4: Tổng A + B [add.s]

Thuật toán:
* Nhập str a biến đổi thành int numA:
    Tách từng số trong a bằng cách lấy a%10 (đơn vị) vào a/=10 để bỏ đi số cuối
    Lặp lại cho đến khi a = 0
    Khi lấy được một chữ số mới thì thêm vào cuối của biến kết quả bằng cách lấy ans*10+số cuối
* Nhập str b biến đổi thành int numB:
    Tương tự a
* Tính numC = numA + numB
    Dùng lệnh add...
* In ra từng kí tự của numC từ trái sang phải
    Tính pow = 10^(len-1), mục đích là để lấy chữ số ở hàng thứ i là num/(10^i)%10
    Vòng lặp giảm dần pow /= 10 cho đến khi pow==0. Ở mỗi bước in ra một kí tự num/pow%10

Cú pháp:
```asm
add rax, rbx    ; rax += rbx

mul 0x10        ; rdx = rax * 10

imul rax, 0x10  ; rax *= 10

mov rdx, 0      ; rdx phải = 0 trước khi div
div rcx         ; rax /= rcx dư lưu vào rdx
```

### Tài liệu

Intro: https://www.cit.ctu.edu.vn/~dtnghi/cod/nasm.pdf
Input, output: https://cratecode.com/info/x86-assembly-nasm-user-input-output
Lệnh: https://www.felixcloutier.com/x86/
https://www.aldeid.com/wiki/X86-assembly/Instructions
Syscall: https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md#x86_64-64_bit

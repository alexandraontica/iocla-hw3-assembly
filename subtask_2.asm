; subtask 2 - bsearch

section .text
    global binary_search
    ;; no extern functions allowed

binary_search:
    ;; create the new stack frame
    enter 0, 0

    ;; save the preserved registers
    push ebx
    push ecx
    push edx
    push esi
    push edi

    ;; recursive bsearch implementation goes here
    ; fastcall:
    ; ecx = buff
    ; edx = needle

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]

    ; cmp start, end
    cmp eax, ebx
    jge not_found

    ; (end - start) / 2
    sub ebx, eax
    shr ebx, 1

    ; mid
    add eax, ebx

    ; cmp buff[mid], needle
    cmp [ecx + eax * 4], edx
    jg check_left
    jl check_right

    ; needle == buff[mid]
    je end_bsearch

check_left:
    ; check if mid > start
    cmp eax, [ebp + 8]
    jle not_found

    dec eax
    mov esi, [ebp + 8]
    push eax
    push esi
    call binary_search
    add esp, 8
    jmp end_bsearch

check_right:
    ; check if mid < end
    cmp eax, [ebp + 12]
    jge not_found

    inc eax
    mov esi, [ebp + 12]
    push esi
    push eax
    call binary_search
    add esp, 8
    jmp end_bsearch

not_found:
    mov eax, -1

end_bsearch:
    ;; restore the preserved registers
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx

    leave
    ret

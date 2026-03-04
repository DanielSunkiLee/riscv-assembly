.data
arr: .word 1, 5, 3, 4, 10, 22, 2, 3, 44
n:   .word 9

.text
.globl main
main:
    addi sp, sp, 10000

    la a0, arr        # a0 = base address of arr
    lw t1, n, t0      # t1 = length (9)

    # Access arr[i] like Python::
    
    # arr[0] → lw t0, 0(a0)
    # arr[1] → lw t0, 4(a0)
    # arr[i] → multiply i by 4, then lw t0, 0(a0) after add

    # Example: loop through arr[i]
    addi t2, x0, 0        # i = 0
loop:
    bge t2, t1, done      # if i >= n, exit

    slli t3, t2, 2        # t3 = i * 4  (byte offset)
    add  t4, a0, t3       # t4 = &arr[i]
    lw   t5, 0(t4)        # t5 = arr[i]  ← this is your "arr[i]"

    addi t2, t2, 1        # i++
    j loop

done:
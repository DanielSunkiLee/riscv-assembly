.data
arr: .word 93,8,78,-6,51,49,3,2,128,0
n:   .word 9

.text
.globl main
main:
  addi sp, sp, 10000

  addi a0, x0, 0
  
  addi t0,x0,93
  sw t0,0(a0) # take the value inside t0 and store it into the memory address 0(a0)
  addi t0,x0,8
  sw t0, 4(a0)
  addi t0,x0,78
  sw t0, 8(a0)
  addi t0,x0-6,
  sw t0, 12(a0)
  addi t0,x0,51
  sw t0, 16(a0)
  addi t0,x0,49
  sw t0, 20(a0)
  addi t0,x0,3
  sw t0, 24(a0)
  addi t0,x0,2
  sw t0, 28(a0)
  addi t0,x0,128
  sw t0, 32(a0)
  addi t0,x0,0
  sw t0, 36(a0)

  addi a1, x0, 10

  jal ra, SEL_SORT
  jal ra, FIN 
SEL_SORT:
  addi sp,sp, -8
  sw ra, 4(sp)
  sw s0, 0(sp)

  addi t0, x0, 0 # i 
  addi t1, x0, 0 # j
  addi t2, x0, 0 # min_index

  addi s0, a1, 0 # store n( = 10)
  addi a1, a1, -1 # n-1( = 9)

UNSORTED_ARRAY_BOUNDARY_LOOP:
  beq t0, a1, END_UNSORTED_ARRAY_BOUNDARY_LOOP # while i < (n-1)

  addi t2, t0, 0 # min_index = i 
  addi t1, t0, 1 #j = i+1

SUBARRAY_LOOP:
  beq t1, s0, END_SUBARRAY_LOOP # while j < n 

  slli t5, t1, 2 # j*sizeof(int)
  add t6, a0, t5 
  lw t4, 0(t6) # load arr[j]

  slli t5, t2, 2 # min_index*sizeof(int)
  add t6, a0, t5
  lw t3, 0(t6)

  blt t3, t4, MIN_REMAINS_SAME # if arr[min_index] < arr[j], min_index remains the same    
  addi t2, t1, 0 # min_index = j

MIN_REMAINS_SAME:
  addi t1, t1, 1 # j = j+1
  beq x0, x0,SUBARRAY_LOOP

END_SUBARRAY_LOOP:
  slli t5, t0,2 # min_index*sizeof(int)
  add t6, a0, t5 # arr[min_index]
  lw t3, 0(t6)

  slli t1, t0, 2 # i*sizeof(int)
  add t1, t1, a0 # arr[i]
  lw t4, 0(t1)

  sw t3, 0(t1)
  sw t4, 0(t6)

  addi t0, t0, 1 # i = i+1
  beq x0, x0, UNSORTED_ARRAY_BOUNDARY_LOOP


END_UNSORTED_ARRAY_BOUNDARY_LOOP:
  lw s0, 0(sp)
  lw ra, 4(sp)
  addi sp,sp, 8
  jalr x0,ra,0


FIN:
  li a7, 4
  la a0, ans
  ecall

  li a7, 1
  mv a0, t1 # char to print
  ecall

  li a7,4 # print "\n"
  la a0, newline
  ecall
  
  li a7, 10 # exit
  ecall
.data
arr: .word 93,8,78,-6,51,49,3,2,128,0
newline: .asciz "\n" 
tab: .asciz "\t"

.text
.globl main
main:
  la a0, arr
  addi a1, x0, 10 # a1 = len(arr)

  jal ra, SEL_SORT
  jal ra, MIN_MAX

  li a7, 10
  ecall 
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
#get address and value of arr[i]
  slli t5, t0,2 
  add t1, a0, t5 # t1 = address of arr[i]
  lw t3, 0(t1) # t3 = arr[i]

#get address and value of arr[min_index]
  slli t5, t2, 2 # use t2 (=min_index) here
  add t6, a0, t5 # t6 = address of arr[min_index]
  lw t4, 0(t6) # t4 = arr[min_index]

#perform swap
  sw t4, 0(t1) # store arr[min_index] into arr[i]
  sw t3, 0(t6) # store arr[i] into arr[min_index]

  addi t0, t0, 1 # i++
  j UNSORTED_ARRAY_BOUNDARY_LOOP


END_UNSORTED_ARRAY_BOUNDARY_LOOP:
  lw s0, 0(sp)
  lw ra, 4(sp)
  addi sp,sp, 8
  jalr x0,ra,0

MIN_MAX:
  li t0, 0
  la t2, arr
  
  slli t1, t0,2 
  add t1, t2, t1 # t1 = address of arr[i]
  lw a0, 0(t1) # t3 = arr[i]

  li a7, 1
  ecall
  
  li a7,4
  la a0, tab
  ecall

  addi t0, t0, 9

  slli t1, t0,2
  add t1, t2, t1 # t1 = address of arr[i]
  lw a0, 0(t1) # t3 = arr[i]

  li a7, 1
  ecall

  li a7,4
  la a0, newline
  ecall


FIN:
  li a7, 10 # exit
  ecall
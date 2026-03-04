.data 
arr: .word 93,8,78,-6,51,49,3,2,128,0 
newline: .asciz "\n" 

.text 
.globl main 
main: 
  li t0, 0 # total = 0 
  la t1, arr # t1 = pointer 
  li t2,10 # counter 
  li t4, 10 sum_loop: #cumulative num 
  lw t3, 0(t1) # load current element "value" not "address" 
  add t0, t0, t3 # total += element 
  addi t1,t1, 4 # move pointer to next int 
  #"so if you use t3, instead t1 it prints 0" 
  addi t2,t2,-1 # decrement counter bnez t2, sum_loop # if not zero, repeat #divide by len(arr) and print mv a0,t0 div a0, a0, t4 li a7, 1 ecall la a0, newline li a7, 4 ecall li a7, 10 # exit ecall
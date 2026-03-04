.data

q_num: .asciz "I'm thinking of a number 0-100. Try to guess it!"
guess: .asciz "Guess a number: "
high: .asciz "Too high!"
low: .asciz "Too low!"
ans: .asciz "Correct, it was "
newline: .asciz "\n"

.text
main:
  li a7, 42  # randint between 0-100
  li a0, 0
  li a1, 101
  ecall

  mv t1, a0 # t1 = randint
   
  li a7, 4 # print string
  la a0, q_num
  ecall
  

loop:
  li a7,4
  la a0, guess
  ecall
  
  li a7, 5 # read int
  ecall

  mv t0, a0 # move score into t0

  blt t0, t1, too_low
  bgt t0, t1, too_high
  beq t0, t1, fin

too_low : 
  li a7, 4
  la a0, low
  ecall


  j loop

too_high:
  li a7, 4
  la a0, high
  ecall


  j loop

fin:
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
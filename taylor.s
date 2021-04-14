/*
 * taylor.s
 *
 *  Created on: Dec 13, 2020
 *      Author: romarazdan
 */

 .text
 .global main
 .extern printf

 main:
 ldr x0, =i // load i val into x0
 ldr x1, [x0] // since x0 is an index we bracket it then load
 mov x9, x1 // use it
 sub x9, x9, #1 // used to count
 ldr x0, =x // load x into d1
 sub d1, d1, d1 // check d1
 ldr d1, [x0] // access later
 mov x10, #1 // count
 mov x2, #1 // set val to 1 (creates total)
 scvtf d2, x2 // check if float
 cmp x9, #0 // if i = 0
 b.eq done // branch done
 scvtf d3, x10 // 1 val double
 b L1 // branch to taylor loop

 L1:
 fmul d3, d3, d1 // num val (top)
 mov x3, #1 // den val to 1 (bottom)
 scvtf d4, x3 // float vals
 bl factorial // use count to get bottom
 fdiv d5, d3, d4 // num div den
 fadd d2, d5, d2 // increment total
 cmp x10, x9 // comparison to i
 b.eq done // if count = i then done
 add x10, x10, #1 // increment count
 b L1 // repeat

 factorial:
 cmp x10, #1 // check count = 1
 b.eq branch // if = 1, return to branch
 mov x11, #1 // j is set to track traversal

 L2:
 cmp x11, x10 // compare count with j
 b.eq branch // back to L1
 add x11, x11, #1 // add back
 scvtf d0, x11 // put in float for multip. purposes
 fmul d4, d4, d0 // do math
 b L2 // repeat

 branch:
 br x30

 done:
 fsub d0, d0, d0 // check if 0
 fadd d0, d0, d2 // current fib to d0
 ldr x0, =fstring // print
 bl printf
 br x30

 .data
 i:
 .quad 3 // number of terms
 x:
 .double 6.0 // double floating point to represent x

 fstring:
 .ascii "The estimation is %f\n\0"
 .end

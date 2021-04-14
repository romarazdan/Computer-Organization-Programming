/*
 * fibonacci.s
 *
 *  Created on: Nov 3, 2020
 *      Author: romarazdan
 */

.text
.global main
.extern printf

main:
	.global fib
	add x1, xzr, xzr
	add x1, x1, #1 // initializes fibCurrent in reg x1 to 1
	ldr x2, =input // x2 holds address of the input
	ldr x0, [x2] // x0 holds val of n
	add x4, xzr, xzr // initializes fibPrevious in reg x4 to 0

fib:
	sub sp, sp, 32 // subtract space on stack
	stur x4, [sp, 24] // store fibPrevious
	stur x1, [sp, 16] // store fibCurrent
	stur x30, [sp, 8] // store address of return
	stur x0, [sp, 0] // store n
	subs x3, x0, #1 // check if n == 1
	b.ne L1 // if n != 1, then branch to L1, else return fibCurrent
	ldr x0, =string // loads ascii
	bl printf // prints fibCurrent
	ldur x4, [sp, 24] // load fibPrevious
	ldur x1, [sp, 16] // load fibCurrent
	ldur x0, [sp, 0] // load n
	ldur x30, [sp, 8] // load address of return
	add sp, sp, 32 // add space back on stack
	br x30 // return

L1:
	sub x0, x0, #1 // decrease n
	add x5, x1, xzr // x5 holds old val of fibCurrent
	add x1, x1, x4 // fibCurrent += fibPrevious
	mov x4, x5 // fibCurrent = fibPrevious
	bl fib // call fib(Current+Previous, Current, n-1)
	ldur x4, [sp, 24] // load fibPrevious
	ldur x1, [sp, 16] // load fibCurrent
	ldur x0, [sp, 0] // store n
	ldur x30, [sp, 8] //load address of return
	add sp, sp, 32 // add space back to stack
	br x30 // return

.data
input:
	.quad 2
string:
	.asciz "The fibonacci number is: %d\n\0"
.end

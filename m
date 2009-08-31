From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 3/9] m68k/asm-offsets: rename pt_regs offset defines
Date: Mon, 31 Aug 2009 14:43:33 +0200
Message-ID: <20090831124416.666403991@de.ibm.com>
References: <20090831124330.014480226@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate8-bp.emea.ibm.com ([195.212.17.168]:51713 "EHLO
	mtagate8.de.ibm.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752288AbZHaMoT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2009 08:44:19 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7VCiIoA020797
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 12:44:18 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com [9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7VCiICo2728002
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 14:44:18 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7VCiGIC025832
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 14:44:18 +0200
Content-Disposition: inline; filename=m68k_ptregs.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <be>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

In order to be able to use asm-offsets.h in C files the existing namespace
conflicts must be solved first. In asm-offsets.h e.g. PT_D0 gets defined
which is the offset of the d0 member of the pt_regs structure.
However a same define (with a different meaning) exists in asm/ptregs.h.

So rename the defines created with the asm-offset mechanism to PT_OFF_D0
etc. There also already exist a few defines with these names that have
the same meaning. So remove the existing defines and use the asm-offset
generated ones.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/m68k/include/asm/entry_mm.h |    3 ---
 arch/m68k/include/asm/entry_no.h |    8 ++++----
 arch/m68k/include/asm/math-emu.h |   20 ++++++++++----------
 arch/m68k/kernel/asm-offsets.c   |   26 +++++++++++++-------------
 arch/m68k/kernel/entry.S         |   22 +++++++++++-----------
 arch/m68k/math-emu/fp_entry.S    |   30 +++++++++++++++---------------
 6 files changed, 53 insertions(+), 56 deletions(-)

Index: linux-2.6/arch/m68k/include/asm/entry_mm.h
===================================================================
--- linux-2.6.orig/arch/m68k/include/asm/entry_mm.h
+++ linux-2.6/arch/m68k/include/asm/entry_mm.h
@@ -118,9 +118,6 @@ PT_DTRACE_BIT = 2
 #define STR(X) STR1(X)
 #define STR1(X) #X
 
-#define PT_OFF_ORIG_D0	 0x24
-#define PT_OFF_FORMATVEC 0x32
-#define PT_OFF_SR	 0x2C
 #define SAVE_ALL_INT				\
 	"clrl	%%sp@-;"    /* stk_adj */	\
 	"pea	-1:w;"	    /* orig d0 = -1 */	\
Index: linux-2.6/arch/m68k/kernel/asm-offsets.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/asm-offsets.c
+++ linux-2.6/arch/m68k/kernel/asm-offsets.c
@@ -44,20 +44,20 @@ int main(void)
 	DEFINE(TINFO_FLAGS, offsetof(struct thread_info, flags));
 
 	/* offsets into the pt_regs */
-	DEFINE(PT_D0, offsetof(struct pt_regs, d0));
-	DEFINE(PT_ORIG_D0, offsetof(struct pt_regs, orig_d0));
-	DEFINE(PT_D1, offsetof(struct pt_regs, d1));
-	DEFINE(PT_D2, offsetof(struct pt_regs, d2));
-	DEFINE(PT_D3, offsetof(struct pt_regs, d3));
-	DEFINE(PT_D4, offsetof(struct pt_regs, d4));
-	DEFINE(PT_D5, offsetof(struct pt_regs, d5));
-	DEFINE(PT_A0, offsetof(struct pt_regs, a0));
-	DEFINE(PT_A1, offsetof(struct pt_regs, a1));
-	DEFINE(PT_A2, offsetof(struct pt_regs, a2));
-	DEFINE(PT_PC, offsetof(struct pt_regs, pc));
-	DEFINE(PT_SR, offsetof(struct pt_regs, sr));
+	DEFINE(PT_OFF_D0, offsetof(struct pt_regs, d0));
+	DEFINE(PT_OFF_ORIG_D0, offsetof(struct pt_regs, orig_d0));
+	DEFINE(PT_OFF_D1, offsetof(struct pt_regs, d1));
+	DEFINE(PT_OFF_D2, offsetof(struct pt_regs, d2));
+	DEFINE(PT_OFF_D3, offsetof(struct pt_regs, d3));
+	DEFINE(PT_OFF_D4, offsetof(struct pt_regs, d4));
+	DEFINE(PT_OFF_D5, offsetof(struct pt_regs, d5));
+	DEFINE(PT_OFF_A0, offsetof(struct pt_regs, a0));
+	DEFINE(PT_OFF_A1, offsetof(struct pt_regs, a1));
+	DEFINE(PT_OFF_A2, offsetof(struct pt_regs, a2));
+	DEFINE(PT_OFF_PC, offsetof(struct pt_regs, pc));
+	DEFINE(PT_OFF_SR, offsetof(struct pt_regs, sr));
 	/* bitfields are a bit difficult */
-	DEFINE(PT_VECTOR, offsetof(struct pt_regs, pc) + 4);
+	DEFINE(PT_OFF_FORMATVEC, offsetof(struct pt_regs, pc) + 4);
 
 	/* offsets into the irq_handler struct */
 	DEFINE(IRQ_HANDLER, offsetof(struct irq_node, handler));
Index: linux-2.6/arch/m68k/kernel/entry.S
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/entry.S
+++ linux-2.6/arch/m68k/kernel/entry.S
@@ -77,17 +77,17 @@ ENTRY(ret_from_fork)
 	jra	.Lret_from_exception
 
 do_trace_entry:
-	movel	#-ENOSYS,%sp@(PT_D0)	| needed for strace
+	movel	#-ENOSYS,%sp@(PT_OFF_D0)| needed for strace
 	subql	#4,%sp
 	SAVE_SWITCH_STACK
 	jbsr	syscall_trace
 	RESTORE_SWITCH_STACK
 	addql	#4,%sp
-	movel	%sp@(PT_ORIG_D0),%d0
+	movel	%sp@(PT_OFF_ORIG_D0),%d0
 	cmpl	#NR_syscalls,%d0
 	jcs	syscall
 badsys:
-	movel	#-ENOSYS,%sp@(PT_D0)
+	movel	#-ENOSYS,%sp@(PT_OFF_D0)
 	jra	ret_from_syscall
 
 do_trace_exit:
@@ -103,7 +103,7 @@ ENTRY(ret_from_signal)
 	addql	#4,%sp
 /* on 68040 complete pending writebacks if any */
 #ifdef CONFIG_M68040
-	bfextu	%sp@(PT_VECTOR){#0,#4},%d0
+	bfextu	%sp@(PT_OFF_FORMATVEC){#0,#4},%d0
 	subql	#7,%d0				| bus error frame ?
 	jbne	1f
 	movel	%sp,%sp@-
@@ -127,7 +127,7 @@ ENTRY(system_call)
 	jcc	badsys
 syscall:
 	jbsr	@(sys_call_table,%d0:l:4)@(0)
-	movel	%d0,%sp@(PT_D0)		| save the return value
+	movel	%d0,%sp@(PT_OFF_D0)	| save the return value
 ret_from_syscall:
 	|oriw	#0x0700,%sr
 	movew	%curptr@(TASK_INFO+TINFO_FLAGS+2),%d0
@@ -135,7 +135,7 @@ ret_from_syscall:
 1:	RESTORE_ALL
 
 syscall_exit_work:
-	btst	#5,%sp@(PT_SR)		| check if returning to kernel
+	btst	#5,%sp@(PT_OFF_SR)	| check if returning to kernel
 	bnes	1b			| if so, skip resched, signals
 	lslw	#1,%d0
 	jcs	do_trace_exit
@@ -148,7 +148,7 @@ syscall_exit_work:
 
 ENTRY(ret_from_exception)
 .Lret_from_exception:
-	btst	#5,%sp@(PT_SR)		| check if returning to kernel
+	btst	#5,%sp@(PT_OFF_SR)	| check if returning to kernel
 	bnes	1f			| if so, skip resched, signals
 	| only allow interrupts when we are really the last one on the
 	| kernel stack, otherwise stack overflow can occur during
@@ -182,7 +182,7 @@ do_signal_return:
 	jbra	resume_userspace
 
 do_delayed_trace:
-	bclr	#7,%sp@(PT_SR)		| clear trace bit in SR
+	bclr	#7,%sp@(PT_OFF_SR)	| clear trace bit in SR
 	pea	1			| send SIGTRAP
 	movel	%curptr,%sp@-
 	pea	LSIGTRAP
@@ -199,7 +199,7 @@ ENTRY(auto_inthandler)
 	GET_CURRENT(%d0)
 	addqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
 					|  put exception # in d0
-	bfextu	%sp@(PT_VECTOR){#4,#10},%d0
+	bfextu	%sp@(PT_OFF_FORMATVEC){#4,#10},%d0
 	subw	#VEC_SPUR,%d0
 
 	movel	%sp,%sp@-
@@ -216,7 +216,7 @@ ret_from_interrupt:
 	ALIGN
 ret_from_last_interrupt:
 	moveq	#(~ALLOWINT>>8)&0xff,%d0
-	andb	%sp@(PT_SR),%d0
+	andb	%sp@(PT_OFF_SR),%d0
 	jne	2b
 
 	/* check if we need to do software interrupts */
@@ -232,7 +232,7 @@ ENTRY(user_inthandler)
 	GET_CURRENT(%d0)
 	addqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
 					|  put exception # in d0
-	bfextu	%sp@(PT_VECTOR){#4,#10},%d0
+	bfextu	%sp@(PT_OFF_FORMATVEC){#4,#10},%d0
 user_irqvec_fixup = . + 2
 	subw	#VEC_USER,%d0
 
Index: linux-2.6/arch/m68k/math-emu/fp_entry.S
===================================================================
--- linux-2.6.orig/arch/m68k/math-emu/fp_entry.S
+++ linux-2.6/arch/m68k/math-emu/fp_entry.S
@@ -122,17 +122,17 @@ fp_get_data_reg:
 	.long	fp_get_d6, fp_get_d7
 
 fp_get_d0:
-	move.l	(PT_D0+8,%sp),%d0
+	move.l	(PT_OFF_D0+8,%sp),%d0
 	printf	PREGISTER,"{d0->%08x}",1,%d0
 	rts
 
 fp_get_d1:
-	move.l	(PT_D1+8,%sp),%d0
+	move.l	(PT_OFF_D1+8,%sp),%d0
 	printf	PREGISTER,"{d1->%08x}",1,%d0
 	rts
 
 fp_get_d2:
-	move.l	(PT_D2+8,%sp),%d0
+	move.l	(PT_OFF_D2+8,%sp),%d0
 	printf	PREGISTER,"{d2->%08x}",1,%d0
 	rts
 
@@ -173,35 +173,35 @@ fp_put_data_reg:
 
 fp_put_d0:
 	printf	PREGISTER,"{d0<-%08x}",1,%d0
-	move.l	%d0,(PT_D0+8,%sp)
+	move.l	%d0,(PT_OFF_D0+8,%sp)
 	rts
 
 fp_put_d1:
 	printf	PREGISTER,"{d1<-%08x}",1,%d0
-	move.l	%d0,(PT_D1+8,%sp)
+	move.l	%d0,(PT_OFF_D1+8,%sp)
 	rts
 
 fp_put_d2:
 	printf	PREGISTER,"{d2<-%08x}",1,%d0
-	move.l	%d0,(PT_D2+8,%sp)
+	move.l	%d0,(PT_OFF_D2+8,%sp)
 	rts
 
 fp_put_d3:
 	printf	PREGISTER,"{d3<-%08x}",1,%d0
 |	move.l	%d0,%d3
-	move.l	%d0,(PT_D3+8,%sp)
+	move.l	%d0,(PT_OFF_D3+8,%sp)
 	rts
 
 fp_put_d4:
 	printf	PREGISTER,"{d4<-%08x}",1,%d0
 |	move.l	%d0,%d4
-	move.l	%d0,(PT_D4+8,%sp)
+	move.l	%d0,(PT_OFF_D4+8,%sp)
 	rts
 
 fp_put_d5:
 	printf	PREGISTER,"{d5<-%08x}",1,%d0
 |	move.l	%d0,%d5
-	move.l	%d0,(PT_D5+8,%sp)
+	move.l	%d0,(PT_OFF_D5+8,%sp)
 	rts
 
 fp_put_d6:
@@ -225,17 +225,17 @@ fp_get_addr_reg:
 	.long	fp_get_a6, fp_get_a7
 
 fp_get_a0:
-	move.l	(PT_A0+8,%sp),%a0
+	move.l	(PT_OFF_A0+8,%sp),%a0
 	printf	PREGISTER,"{a0->%08x}",1,%a0
 	rts
 
 fp_get_a1:
-	move.l	(PT_A1+8,%sp),%a0
+	move.l	(PT_OFF_A1+8,%sp),%a0
 	printf	PREGISTER,"{a1->%08x}",1,%a0
 	rts
 
 fp_get_a2:
-	move.l	(PT_A2+8,%sp),%a0
+	move.l	(PT_OFF_A2+8,%sp),%a0
 	printf	PREGISTER,"{a2->%08x}",1,%a0
 	rts
 
@@ -276,17 +276,17 @@ fp_put_addr_reg:
 
 fp_put_a0:
 	printf	PREGISTER,"{a0<-%08x}",1,%a0
-	move.l	%a0,(PT_A0+8,%sp)
+	move.l	%a0,(PT_OFF_A0+8,%sp)
 	rts
 
 fp_put_a1:
 	printf	PREGISTER,"{a1<-%08x}",1,%a0
-	move.l	%a0,(PT_A1+8,%sp)
+	move.l	%a0,(PT_OFF_A1+8,%sp)
 	rts
 
 fp_put_a2:
 	printf	PREGISTER,"{a2<-%08x}",1,%a0
-	move.l	%a0,(PT_A2+8,%sp)
+	move.l	%a0,(PT_OFF_A2+8,%sp)
 	rts
 
 fp_put_a3:
Index: linux-2.6/arch/m68k/include/asm/entry_no.h
===================================================================
--- linux-2.6.orig/arch/m68k/include/asm/entry_no.h
+++ linux-2.6/arch/m68k/include/asm/entry_no.h
@@ -72,8 +72,8 @@ LENOSYS = 38
 	lea	%sp@(-32),%sp		/* space for 8 regs */
 	moveml	%d1-%d5/%a0-%a2,%sp@
 	movel	sw_usp,%a0		/* get usp */
-	movel	%a0@-,%sp@(PT_PC)	/* copy exception program counter */
-	movel	%a0@-,%sp@(PT_FORMATVEC)/* copy exception format/vector/sr */
+	movel	%a0@-,%sp@(PT_OFF_PC)	/* copy exception program counter */
+	movel	%a0@-,%sp@(PT_OFF_FORMATVEC)/*copy exception format/vector/sr */
 	bra	7f
 	6:
 	clrl	%sp@-			/* stkadj */
@@ -89,8 +89,8 @@ LENOSYS = 38
 	bnes	8f			/* no, skip */
 	move	#0x2700,%sr		/* disable intrs */
 	movel	sw_usp,%a0		/* get usp */
-	movel	%sp@(PT_PC),%a0@-	/* copy exception program counter */
-	movel	%sp@(PT_FORMATVEC),%a0@-/* copy exception format/vector/sr */
+	movel	%sp@(PT_OFF_PC),%a0@-	/* copy exception program counter */
+	movel	%sp@(PT_OFF_FORMATVEC),%a0@-/*copy exception format/vector/sr */
 	moveml	%sp@,%d1-%d5/%a0-%a2
 	lea	%sp@(32),%sp		/* space for 8 regs */
 	movel	%sp@+,%d0
Index: linux-2.6/arch/m68k/include/asm/math-emu.h
===================================================================
--- linux-2.6.orig/arch/m68k/include/asm/math-emu.h
+++ linux-2.6/arch/m68k/include/asm/math-emu.h
@@ -145,16 +145,16 @@ extern unsigned int fp_debugprint;
  * these are only used during instruction decoding
  * where we always know how deep we're on the stack.
  */
-#define FPS_DO		(PT_D0)
-#define FPS_D1		(PT_D1)
-#define FPS_D2		(PT_D2)
-#define FPS_A0		(PT_A0)
-#define FPS_A1		(PT_A1)
-#define FPS_A2		(PT_A2)
-#define FPS_SR		(PT_SR)
-#define FPS_PC		(PT_PC)
-#define FPS_EA		(PT_PC+6)
-#define FPS_PC2		(PT_PC+10)
+#define FPS_DO		(PT_OFF_D0)
+#define FPS_D1		(PT_OFF_D1)
+#define FPS_D2		(PT_OFF_D2)
+#define FPS_A0		(PT_OFF_A0)
+#define FPS_A1		(PT_OFF_A1)
+#define FPS_A2		(PT_OFF_A2)
+#define FPS_SR		(PT_OFF_SR)
+#define FPS_PC		(PT_OFF_PC)
+#define FPS_EA		(PT_OFF_PC+6)
+#define FPS_PC2		(PT_OFF_PC+10)
 
 .macro	fp_get_fp_reg
 	lea	(FPD_FPREG,FPDATA,%d0.w*4),%a0

-- 

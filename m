Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51761 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756798AbeEJIHI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 May 2018 04:07:08 -0400
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend 22/27] x86_64: assembly, change all ENTRY+END to SYM_CODE_*
Date: Thu, 10 May 2018 10:06:39 +0200
Message-ID: <20180510080644.19752-23-jslaby@suse.cz>
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Message-ID: <20180510080639.kZXmWbuVB-Cklha_qx-pEe-C9PYyHPHcyERINACdJVM@z>

Here, we change all code which is not marked as functions. In other
words, this code has been using END, not ENDPROC. So switch all of this
to appropriate new markings SYM_CODE_START and SYM_CODE_END.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com> [xen bits]
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/entry/entry_64.S        | 56 ++++++++++++++++++++--------------------
 arch/x86/entry/entry_64_compat.S |  8 +++---
 arch/x86/kernel/ftrace_64.S      |  4 +--
 arch/x86/xen/xen-asm_64.S        |  8 +++---
 arch/x86/xen/xen-head.S          |  8 +++---
 5 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c6841c038170..1b0631971dde 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -46,11 +46,11 @@
 .section .entry.text, "ax"
 
 #ifdef CONFIG_PARAVIRT
-ENTRY(native_usergs_sysret64)
+SYM_CODE_START(native_usergs_sysret64)
 	UNWIND_HINT_EMPTY
 	swapgs
 	sysretq
-END(native_usergs_sysret64)
+SYM_CODE_END(native_usergs_sysret64)
 #endif /* CONFIG_PARAVIRT */
 
 .macro TRACE_IRQS_FLAGS flags:req
@@ -163,7 +163,7 @@ END(native_usergs_sysret64)
 #define RSP_SCRATCH	CPU_ENTRY_AREA_entry_stack + \
 			SIZEOF_entry_stack - 8 + CPU_ENTRY_AREA
 
-ENTRY(entry_SYSCALL_64_trampoline)
+SYM_CODE_START(entry_SYSCALL_64_trampoline)
 	UNWIND_HINT_EMPTY
 	swapgs
 
@@ -193,17 +193,17 @@ ENTRY(entry_SYSCALL_64_trampoline)
 	pushq	%rdi
 	movq	$entry_SYSCALL_64_stage2, %rdi
 	JMP_NOSPEC %rdi
-END(entry_SYSCALL_64_trampoline)
+SYM_CODE_END(entry_SYSCALL_64_trampoline)
 
 	.popsection
 
-ENTRY(entry_SYSCALL_64_stage2)
+SYM_CODE_START(entry_SYSCALL_64_stage2)
 	UNWIND_HINT_EMPTY
 	popq	%rdi
 	jmp	entry_SYSCALL_64_after_hwframe
-END(entry_SYSCALL_64_stage2)
+SYM_CODE_END(entry_SYSCALL_64_stage2)
 
-ENTRY(entry_SYSCALL_64)
+SYM_CODE_START(entry_SYSCALL_64)
 	UNWIND_HINT_EMPTY
 	/*
 	 * Interrupts are off on entry.
@@ -336,13 +336,13 @@ syscall_return_via_sysret:
 	popq	%rdi
 	popq	%rsp
 	USERGS_SYSRET64
-END(entry_SYSCALL_64)
+SYM_CODE_END(entry_SYSCALL_64)
 
 /*
  * %rdi: prev task
  * %rsi: next task
  */
-ENTRY(__switch_to_asm)
+SYM_CODE_START(__switch_to_asm)
 	UNWIND_HINT_FUNC
 	/*
 	 * Save callee-saved registers
@@ -384,7 +384,7 @@ ENTRY(__switch_to_asm)
 	popq	%rbp
 
 	jmp	__switch_to
-END(__switch_to_asm)
+SYM_CODE_END(__switch_to_asm)
 
 /*
  * A newly forked process directly context switches into this address.
@@ -393,7 +393,7 @@ END(__switch_to_asm)
  * rbx: kernel thread func (NULL for user thread)
  * r12: kernel thread arg
  */
-ENTRY(ret_from_fork)
+SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
@@ -419,14 +419,14 @@ ENTRY(ret_from_fork)
 	 */
 	movq	$0, RAX(%rsp)
 	jmp	2b
-END(ret_from_fork)
+SYM_CODE_END(ret_from_fork)
 
 /*
  * Build the entry stubs with some assembler magic.
  * We pack 1 stub into every 8-byte block.
  */
 	.align 8
-ENTRY(irq_entries_start)
+SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	UNWIND_HINT_IRET_REGS
@@ -435,7 +435,7 @@ ENTRY(irq_entries_start)
 	.align	8
 	vector=vector+1
     .endr
-END(irq_entries_start)
+SYM_CODE_END(irq_entries_start)
 
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
@@ -561,7 +561,7 @@ END(irq_entries_start)
  * | return address					|
  * +----------------------------------------------------+
  */
-ENTRY(interrupt_entry)
+SYM_CODE_START(interrupt_entry)
 	UNWIND_HINT_FUNC
 	ASM_CLAC
 	cld
@@ -627,7 +627,7 @@ ENTRY(interrupt_entry)
 	TRACE_IRQS_OFF
 
 	ret
-END(interrupt_entry)
+SYM_CODE_END(interrupt_entry)
 
 
 /* Interrupt entry/exit. */
@@ -832,7 +832,7 @@ SYM_CODE_END(common_interrupt)
  * APIC interrupts.
  */
 .macro apicinterrupt3 num sym do_sym
-ENTRY(\sym)
+SYM_CODE_START(\sym)
 	UNWIND_HINT_IRET_REGS
 	pushq	$~(\num)
 .Lcommon_\sym:
@@ -840,7 +840,7 @@ ENTRY(\sym)
 	UNWIND_HINT_REGS indirect=1
 	call	\do_sym	/* rdi points to pt_regs */
 	jmp	ret_from_intr
-END(\sym)
+SYM_CODE_END(\sym)
 .endm
 
 /* Make sure APIC interrupt handlers end up in the irqentry section: */
@@ -902,7 +902,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + ((x) - 1) * 8)
 
 .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
-ENTRY(\sym)
+SYM_CODE_START(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
 	/* Sanity check */
@@ -985,7 +985,7 @@ ENTRY(\sym)
 
 	jmp	error_exit			/* %ebx: no swapgs flag */
 	.endif
-END(\sym)
+SYM_CODE_END(\sym)
 .endm
 
 idtentry divide_error			do_divide_error			has_error_code=0
@@ -1102,7 +1102,7 @@ SYM_CODE_END(xen_do_hypervisor_callback)
  * We distinguish between categories by comparing each saved segment register
  * with its current contents: any discrepancy means we in category 1.
  */
-ENTRY(xen_failsafe_callback)
+SYM_CODE_START(xen_failsafe_callback)
 	UNWIND_HINT_EMPTY
 	movl	%ds, %ecx
 	cmpw	%cx, 0x10(%rsp)
@@ -1132,7 +1132,7 @@ ENTRY(xen_failsafe_callback)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
-END(xen_failsafe_callback)
+SYM_CODE_END(xen_failsafe_callback)
 
 apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
 	xen_hvm_callback_vector xen_evtchn_do_upcall
@@ -1340,7 +1340,7 @@ SYM_CODE_END(error_exit)
  *	%r14: Used to save/restore the CR3 of the interrupted context
  *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
-ENTRY(nmi)
+SYM_CODE_START(nmi)
 	UNWIND_HINT_IRET_REGS
 
 	/*
@@ -1673,15 +1673,15 @@ nmi_restore:
 	 * about espfix64 on the way back to kernel mode.
 	 */
 	iretq
-END(nmi)
+SYM_CODE_END(nmi)
 
-ENTRY(ignore_sysret)
+SYM_CODE_START(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
 	sysret
-END(ignore_sysret)
+SYM_CODE_END(ignore_sysret)
 
-ENTRY(rewind_stack_do_exit)
+SYM_CODE_START(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
@@ -1691,4 +1691,4 @@ ENTRY(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
 
 	call	do_exit
-END(rewind_stack_do_exit)
+SYM_CODE_END(rewind_stack_do_exit)
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 076659472d40..b4a2ee901899 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -196,7 +196,7 @@ ENDPROC(entry_SYSENTER_compat)
  * esp  user stack
  * 0(%esp) arg6
  */
-ENTRY(entry_SYSCALL_compat)
+SYM_CODE_START(entry_SYSCALL_compat)
 	/* Interrupts are off on entry. */
 	swapgs
 
@@ -311,7 +311,7 @@ sysret32_from_system_call:
 	xorl	%r10d, %r10d
 	swapgs
 	sysretl
-END(entry_SYSCALL_compat)
+SYM_CODE_END(entry_SYSCALL_compat)
 
 /*
  * 32-bit legacy system call entry.
@@ -339,7 +339,7 @@ END(entry_SYSCALL_compat)
  * edi  arg5
  * ebp  arg6
  */
-ENTRY(entry_INT80_compat)
+SYM_CODE_START(entry_INT80_compat)
 	/*
 	 * Interrupts are off on entry.
 	 */
@@ -414,4 +414,4 @@ ENTRY(entry_INT80_compat)
 	/* Go back to user mode. */
 	TRACE_IRQS_ON
 	jmp	swapgs_restore_regs_and_return_to_usermode
-END(entry_INT80_compat)
+SYM_CODE_END(entry_INT80_compat)
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index b50fbb405763..141341eaa267 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -319,7 +319,7 @@ ENTRY(ftrace_graph_caller)
 	retq
 ENDPROC(ftrace_graph_caller)
 
-ENTRY(return_to_handler)
+SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_EMPTY
 	subq  $24, %rsp
 
@@ -335,5 +335,5 @@ ENTRY(return_to_handler)
 	movq (%rsp), %rax
 	addq $24, %rsp
 	JMP_NOSPEC %rdi
-END(return_to_handler)
+SYM_CODE_END(return_to_handler)
 #endif
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index a69a171f7cea..5a3f5c18cd0c 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -19,11 +19,11 @@
 #include <linux/linkage.h>
 
 .macro xen_pv_trap name
-ENTRY(xen_\name)
+SYM_CODE_START(xen_\name)
 	pop %rcx
 	pop %r11
 	jmp  \name
-END(xen_\name)
+SYM_CODE_END(xen_\name)
 .endm
 
 xen_pv_trap divide_error
@@ -56,7 +56,7 @@ xen_pv_trap entry_INT80_compat
 xen_pv_trap hypervisor_callback
 
 	__INIT
-ENTRY(xen_early_idt_handler_array)
+SYM_CODE_START(xen_early_idt_handler_array)
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	pop %rcx
@@ -65,7 +65,7 @@ ENTRY(xen_early_idt_handler_array)
 	i = i + 1
 	.fill xen_early_idt_handler_array + i*XEN_EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
 	.endr
-END(xen_early_idt_handler_array)
+SYM_CODE_END(xen_early_idt_handler_array)
 	__FINIT
 
 hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 5077ead5e59c..32606eeec053 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -22,7 +22,7 @@
 
 #ifdef CONFIG_XEN_PV
 	__INIT
-ENTRY(startup_xen)
+SYM_CODE_START(startup_xen)
 	UNWIND_HINT_EMPTY
 	cld
 
@@ -52,13 +52,13 @@ ENTRY(startup_xen)
 #endif
 
 	jmp xen_start_kernel
-END(startup_xen)
+SYM_CODE_END(startup_xen)
 	__FINIT
 #endif
 
 .pushsection .text
 	.balign PAGE_SIZE
-ENTRY(hypercall_page)
+SYM_CODE_START(hypercall_page)
 	.rept (PAGE_SIZE / 32)
 		UNWIND_HINT_EMPTY
 		.skip 32
@@ -69,7 +69,7 @@ ENTRY(hypercall_page)
 	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
 #include <asm/xen-hypercalls.h>
 #undef HYPERCALL
-END(hypercall_page)
+SYM_CODE_END(hypercall_page)
 .popsection
 
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
-- 
2.16.3

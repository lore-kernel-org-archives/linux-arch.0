From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v5 22/27] x86_64: assembly, change all ENTRY+END to SYM_CODE_*
Date: Thu, 30 Nov 2017 15:46:48 +0100
Message-ID: <20171130144653.23688-23-jslaby@suse.cz>
References: <20171130144653.23688-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130144653.23688-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
List-Id: linux-arch.vger.kernel.org

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
 arch/x86/kernel/ftrace_64.S      | 16 ++++++------
 arch/x86/xen/xen-asm_64.S        |  4 +--
 arch/x86/xen/xen-head.S          |  8 +++---
 5 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3543ee220ab3..be1d53f3ac5f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -44,11 +44,11 @@
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
@@ -161,7 +161,7 @@ END(native_usergs_sysret64)
 #define RSP_SCRATCH	CPU_ENTRY_AREA_tss + TSS_STRUCT_SYSENTER_stack + \
 			SIZEOF_SYSENTER_stack - 8 + CPU_ENTRY_AREA
 
-ENTRY(entry_SYSCALL_64_trampoline)
+SYM_CODE_START(entry_SYSCALL_64_trampoline)
 	UNWIND_HINT_EMPTY
 	swapgs
 
@@ -187,11 +187,11 @@ ENTRY(entry_SYSCALL_64_trampoline)
 	 */
 	pushq	$entry_SYSCALL_64_after_hwframe
 	retq
-END(entry_SYSCALL_64_trampoline)
+SYM_CODE_END(entry_SYSCALL_64_trampoline)
 
 	.popsection
 
-ENTRY(entry_SYSCALL_64)
+SYM_CODE_START(entry_SYSCALL_64)
 	UNWIND_HINT_EMPTY
 	/*
 	 * Interrupts are off on entry.
@@ -409,7 +409,7 @@ syscall_return_via_sysret:
 	popq	%rdi
 	popq	%rsp
 	USERGS_SYSRET64
-END(entry_SYSCALL_64)
+SYM_CODE_END(entry_SYSCALL_64)
 
 SYM_CODE_START_LOCAL(stub_ptregs_64)
 	/*
@@ -439,11 +439,11 @@ SYM_CODE_START_LOCAL(stub_ptregs_64)
 SYM_CODE_END(stub_ptregs_64)
 
 .macro ptregs_stub func
-ENTRY(ptregs_\func)
+SYM_CODE_START(ptregs_\func)
 	UNWIND_HINT_FUNC
 	leaq	\func(%rip), %rax
 	jmp	stub_ptregs_64
-END(ptregs_\func)
+SYM_CODE_END(ptregs_\func)
 .endm
 
 /* Instantiate ptregs_stub for each ptregs-using syscall */
@@ -456,7 +456,7 @@ END(ptregs_\func)
  * %rdi: prev task
  * %rsi: next task
  */
-ENTRY(__switch_to_asm)
+SYM_CODE_START(__switch_to_asm)
 	UNWIND_HINT_FUNC
 	/*
 	 * Save callee-saved registers
@@ -487,7 +487,7 @@ ENTRY(__switch_to_asm)
 	popq	%rbp
 
 	jmp	__switch_to
-END(__switch_to_asm)
+SYM_CODE_END(__switch_to_asm)
 
 /*
  * A newly forked process directly context switches into this address.
@@ -496,7 +496,7 @@ END(__switch_to_asm)
  * rbx: kernel thread func (NULL for user thread)
  * r12: kernel thread arg
  */
-ENTRY(ret_from_fork)
+SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
@@ -522,14 +522,14 @@ ENTRY(ret_from_fork)
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
@@ -538,7 +538,7 @@ ENTRY(irq_entries_start)
 	.align	8
 	vector=vector+1
     .endr
-END(irq_entries_start)
+SYM_CODE_END(irq_entries_start)
 
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
@@ -874,14 +874,14 @@ SYM_CODE_END(common_interrupt)
  * APIC interrupts.
  */
 .macro apicinterrupt3 num sym do_sym
-ENTRY(\sym)
+SYM_CODE_START(\sym)
 	UNWIND_HINT_IRET_REGS
 	ASM_CLAC
 	pushq	$~(\num)
 .Lcommon_\sym:
 	interrupt \do_sym
 	jmp	ret_from_intr
-END(\sym)
+SYM_CODE_END(\sym)
 .endm
 
 /* Make sure APIC interrupt handlers end up in the irqentry section: */
@@ -947,7 +947,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * orig_ax on the stack.  (That is, RDI..R12 are not on the stack and
  * space has not been allocated for them.)
  */
-ENTRY(switch_to_thread_stack)
+SYM_CODE_START(switch_to_thread_stack)
 	UNWIND_HINT_FUNC
 
 	pushq	%rdi
@@ -968,10 +968,10 @@ ENTRY(switch_to_thread_stack)
 
 	movq	(%rdi), %rdi
 	ret
-END(switch_to_thread_stack)
+SYM_CODE_END(switch_to_thread_stack)
 
 .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
-ENTRY(\sym)
+SYM_CODE_START(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
 	/* Sanity check */
@@ -1056,7 +1056,7 @@ ENTRY(\sym)
 
 	jmp	error_exit			/* %ebx: no swapgs flag */
 	.endif
-END(\sym)
+SYM_CODE_END(\sym)
 .endm
 
 idtentry divide_error			do_divide_error			has_error_code=0
@@ -1173,7 +1173,7 @@ SYM_CODE_END(xen_do_hypervisor_callback)
  * We distinguish between categories by comparing each saved segment register
  * with its current contents: any discrepancy means we in category 1.
  */
-ENTRY(xen_failsafe_callback)
+SYM_CODE_START(xen_failsafe_callback)
 	UNWIND_HINT_EMPTY
 	movl	%ds, %ecx
 	cmpw	%cx, 0x10(%rsp)
@@ -1205,7 +1205,7 @@ ENTRY(xen_failsafe_callback)
 	SAVE_EXTRA_REGS
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
-END(xen_failsafe_callback)
+SYM_CODE_END(xen_failsafe_callback)
 
 apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
 	xen_hvm_callback_vector xen_evtchn_do_upcall
@@ -1409,7 +1409,7 @@ SYM_CODE_END(error_exit)
  *	%r14: Used to save/restore the CR3 of the interrupted context
  *	      when KAISER is in use.  Do not clobber.
  */
-ENTRY(nmi)
+SYM_CODE_START(nmi)
 	UNWIND_HINT_IRET_REGS
 
 	/*
@@ -1759,15 +1759,15 @@ nmi_restore:
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
@@ -1777,4 +1777,4 @@ ENTRY(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
 
 	call	do_exit
-END(rewind_stack_do_exit)
+SYM_CODE_END(rewind_stack_do_exit)
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index d40f6767e7bd..38be8f5dcbef 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -186,7 +186,7 @@ ENDPROC(entry_SYSENTER_compat)
  * esp  user stack
  * 0(%esp) arg6
  */
-ENTRY(entry_SYSCALL_compat)
+SYM_CODE_START(entry_SYSCALL_compat)
 	/* Interrupts are off on entry. */
 	swapgs
 
@@ -284,7 +284,7 @@ sysret32_from_system_call:
 	xorq	%r10, %r10
 	swapgs
 	sysretl
-END(entry_SYSCALL_compat)
+SYM_CODE_END(entry_SYSCALL_compat)
 
 /*
  * 32-bit legacy system call entry.
@@ -312,7 +312,7 @@ END(entry_SYSCALL_compat)
  * edi  arg5
  * ebp  arg6
  */
-ENTRY(entry_INT80_compat)
+SYM_CODE_START(entry_INT80_compat)
 	/*
 	 * Interrupts are off on entry.
 	 */
@@ -363,7 +363,7 @@ ENTRY(entry_INT80_compat)
 	/* Go back to user mode. */
 	TRACE_IRQS_ON
 	jmp	swapgs_restore_regs_and_return_to_usermode
-END(entry_INT80_compat)
+SYM_CODE_END(entry_INT80_compat)
 
 ENTRY(stub32_clone)
 	/*
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 085c74a4f98b..33e95d785295 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -150,7 +150,7 @@ SYM_FUNC_START(function_hook)
 	retq
 SYM_FUNC_END(function_hook)
 
-ENTRY(ftrace_caller)
+SYM_CODE_START(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
@@ -184,9 +184,9 @@ SYM_CODE_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 /* This is weak to keep gas from relaxing the jumps */
 WEAK(ftrace_stub)
 	retq
-END(ftrace_caller)
+SYM_CODE_END(ftrace_caller)
 
-ENTRY(ftrace_regs_caller)
+SYM_CODE_START(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
 	pushfq
 
@@ -255,12 +255,12 @@ SYM_CODE_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 
 	jmp ftrace_epilogue
 
-END(ftrace_regs_caller)
+SYM_CODE_END(ftrace_regs_caller)
 
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
-ENTRY(function_hook)
+SYM_CODE_START(function_hook)
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
 
@@ -291,11 +291,11 @@ trace:
 	restore_mcount_regs
 
 	jmp fgraph_trace
-END(function_hook)
+SYM_CODE_END(function_hook)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-ENTRY(ftrace_graph_caller)
+SYM_CODE_START(ftrace_graph_caller)
 	/* Saves rbp into %rdx and fills first parameter  */
 	save_mcount_regs
 
@@ -313,7 +313,7 @@ ENTRY(ftrace_graph_caller)
 	restore_mcount_regs
 
 	retq
-END(ftrace_graph_caller)
+SYM_CODE_END(ftrace_graph_caller)
 
 SYM_CODE_START_NOALIGN(return_to_handler)
 	subq  $24, %rsp
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 1e419040bef1..0f6c1348fb87 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -18,11 +18,11 @@
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
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 497cc55a0c16..a672cdc3009d 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -20,7 +20,7 @@
 
 #ifdef CONFIG_XEN_PV
 	__INIT
-ENTRY(startup_xen)
+SYM_CODE_START(startup_xen)
 	UNWIND_HINT_EMPTY
 	cld
 
@@ -36,13 +36,13 @@ ENTRY(startup_xen)
 	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
 
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
@@ -53,7 +53,7 @@ ENTRY(hypercall_page)
 	.type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
 #include <asm/xen-hypercalls.h>
 #undef HYPERCALL
-END(hypercall_page)
+SYM_CODE_END(hypercall_page)
 .popsection
 
 	ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
-- 
2.15.0

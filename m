From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v7 23/28] x86_64/asm: change all ENTRY+END to SYM_CODE_*
Date: Wed, 30 Jan 2019 13:47:06 +0100
Message-ID: <20190130124711.12463-24-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: bp@alien8.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
List-Id: linux-arch.vger.kernel.org

Here, we change all assembly code which is marked using END (and not
ENDPROC). We switch all these to appropriate new markings SYM_CODE_START
and SYM_CODE_END.

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
 arch/x86/entry/entry_64.S        | 48 ++++++++++++++++----------------
 arch/x86/entry/entry_64_compat.S |  8 +++---
 arch/x86/kernel/ftrace_64.S      |  4 +--
 arch/x86/xen/xen-asm_64.S        |  8 +++---
 arch/x86/xen/xen-head.S          |  8 +++---
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 2fe59c693732..88e865ec9695 100644
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
@@ -142,7 +142,7 @@ END(native_usergs_sysret64)
  * with them due to bugs in both AMD and Intel CPUs.
  */
 
-ENTRY(entry_SYSCALL_64)
+SYM_CODE_START(entry_SYSCALL_64)
 	UNWIND_HINT_EMPTY
 	/*
 	 * Interrupts are off on entry.
@@ -273,13 +273,13 @@ syscall_return_via_sysret:
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
@@ -321,7 +321,7 @@ ENTRY(__switch_to_asm)
 	popq	%rbp
 
 	jmp	__switch_to
-END(__switch_to_asm)
+SYM_CODE_END(__switch_to_asm)
 
 /*
  * A newly forked process directly context switches into this address.
@@ -330,7 +330,7 @@ END(__switch_to_asm)
  * rbx: kernel thread func (NULL for user thread)
  * r12: kernel thread arg
  */
-ENTRY(ret_from_fork)
+SYM_CODE_START(ret_from_fork)
 	UNWIND_HINT_EMPTY
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
@@ -357,14 +357,14 @@ ENTRY(ret_from_fork)
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
@@ -373,7 +373,7 @@ ENTRY(irq_entries_start)
 	.align	8
 	vector=vector+1
     .endr
-END(irq_entries_start)
+SYM_CODE_END(irq_entries_start)
 
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
@@ -499,7 +499,7 @@ END(irq_entries_start)
  * | return address					|
  * +----------------------------------------------------+
  */
-ENTRY(interrupt_entry)
+SYM_CODE_START(interrupt_entry)
 	UNWIND_HINT_FUNC
 	ASM_CLAC
 	cld
@@ -565,7 +565,7 @@ ENTRY(interrupt_entry)
 	TRACE_IRQS_OFF
 
 	ret
-END(interrupt_entry)
+SYM_CODE_END(interrupt_entry)
 _ASM_NOKPROBE(interrupt_entry)
 
 
@@ -772,7 +772,7 @@ _ASM_NOKPROBE(common_interrupt)
  * APIC interrupts.
  */
 .macro apicinterrupt3 num sym do_sym
-ENTRY(\sym)
+SYM_CODE_START(\sym)
 	UNWIND_HINT_IRET_REGS
 	pushq	$~(\num)
 .Lcommon_\sym:
@@ -780,7 +780,7 @@ ENTRY(\sym)
 	UNWIND_HINT_REGS indirect=1
 	call	\do_sym	/* rdi points to pt_regs */
 	jmp	ret_from_intr
-END(\sym)
+SYM_CODE_END(\sym)
 _ASM_NOKPROBE(\sym)
 .endm
 
@@ -879,7 +879,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
 .macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1
-ENTRY(\sym)
+SYM_CODE_START(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
 	/* Sanity check */
@@ -963,7 +963,7 @@ ENTRY(\sym)
 	jmp	error_exit
 	.endif
 _ASM_NOKPROBE(\sym)
-END(\sym)
+SYM_CODE_END(\sym)
 .endm
 
 idtentry divide_error			do_divide_error			has_error_code=0
@@ -1080,7 +1080,7 @@ SYM_CODE_END(xen_do_hypervisor_callback)
  * We distinguish between categories by comparing each saved segment register
  * with its current contents: any discrepancy means we in category 1.
  */
-ENTRY(xen_failsafe_callback)
+SYM_CODE_START(xen_failsafe_callback)
 	UNWIND_HINT_EMPTY
 	movl	%ds, %ecx
 	cmpw	%cx, 0x10(%rsp)
@@ -1110,7 +1110,7 @@ ENTRY(xen_failsafe_callback)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
-END(xen_failsafe_callback)
+SYM_CODE_END(xen_failsafe_callback)
 #endif /* CONFIG_XEN_PV */
 
 #ifdef CONFIG_XEN_PVHVM
@@ -1322,7 +1322,7 @@ SYM_CODE_END(error_exit)
  *	%r14: Used to save/restore the CR3 of the interrupted context
  *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
-ENTRY(nmi)
+SYM_CODE_START(nmi)
 	UNWIND_HINT_IRET_REGS
 
 	/*
@@ -1656,15 +1656,15 @@ nmi_restore:
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
@@ -1674,4 +1674,4 @@ ENTRY(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC sp_offset=PTREGS_SIZE
 
 	call	do_exit
-END(rewind_stack_do_exit)
+SYM_CODE_END(rewind_stack_do_exit)
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 5c7e71669239..da296435676e 100644
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
@@ -416,4 +416,4 @@ ENTRY(entry_INT80_compat)
 	/* Go back to user mode. */
 	TRACE_IRQS_ON
 	jmp	swapgs_restore_regs_and_return_to_usermode
-END(entry_INT80_compat)
+SYM_CODE_END(entry_INT80_compat)
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 9483375619d6..b09428941320 100644
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
index 63d2295701d6..2a65d59aa853 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -20,11 +20,11 @@
 #include <linux/linkage.h>
 
 .macro xen_pv_trap name
-ENTRY(xen_\name)
+SYM_CODE_START(xen_\name)
 	pop %rcx
 	pop %r11
 	jmp  \name
-END(xen_\name)
+SYM_CODE_END(xen_\name)
 _ASM_NOKPROBE(xen_\name)
 .endm
 
@@ -58,7 +58,7 @@ xen_pv_trap entry_INT80_compat
 xen_pv_trap hypervisor_callback
 
 	__INIT
-ENTRY(xen_early_idt_handler_array)
+SYM_CODE_START(xen_early_idt_handler_array)
 	i = 0
 	.rept NUM_EXCEPTION_VECTORS
 	pop %rcx
@@ -67,7 +67,7 @@ ENTRY(xen_early_idt_handler_array)
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
2.20.1

From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend 25/27] x86_32: assembly, change all ENTRY+END to SYM_CODE_*
Date: Thu, 10 May 2018 10:06:42 +0200
Message-ID: <20180510080644.19752-26-jslaby@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Here, we change all code which is not marked as functions. In other
words, this code has been using END, not ENDPROC. So switch all of this
to appropriate new markings SYM_CODE_START and SYM_CODE_END.

And since we removed the last user of END on X86, make sure, that END is
not defined there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/entry/entry_32.S   | 104 ++++++++++++++++++++++----------------------
 arch/x86/kernel/ftrace_32.S |  12 ++---
 include/linux/linkage.h     |   2 +
 3 files changed, 60 insertions(+), 58 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 7742435271c1..913e4b50e028 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -227,7 +227,7 @@
  * %eax: prev task
  * %edx: next task
  */
-ENTRY(__switch_to_asm)
+SYM_CODE_START(__switch_to_asm)
 	/*
 	 * Save callee-saved registers
 	 * This must match the order in struct inactive_task_frame
@@ -264,7 +264,7 @@ ENTRY(__switch_to_asm)
 	popl	%ebp
 
 	jmp	__switch_to
-END(__switch_to_asm)
+SYM_CODE_END(__switch_to_asm)
 
 /*
  * The unwinder expects the last frame on the stack to always be at the same
@@ -290,7 +290,7 @@ ENDPROC(schedule_tail_wrapper)
  * ebx: kernel thread func (NULL for user thread)
  * edi: kernel thread arg
  */
-ENTRY(ret_from_fork)
+SYM_CODE_START(ret_from_fork)
 	call	schedule_tail_wrapper
 
 	testl	%ebx, %ebx
@@ -313,7 +313,7 @@ ENTRY(ret_from_fork)
 	 */
 	movl	$0, PT_EAX(%esp)
 	jmp	2b
-END(ret_from_fork)
+SYM_CODE_END(ret_from_fork)
 
 /*
  * Return to user mode is not as complex as all this looks,
@@ -349,7 +349,7 @@ SYM_CODE_INNER_LABEL_ALIGN(resume_userspace, SYM_L_LOCAL)
 SYM_CODE_END(ret_from_exception)
 
 #ifdef CONFIG_PREEMPT
-ENTRY(resume_kernel)
+SYM_CODE_START(resume_kernel)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 .Lneed_resched:
 	cmpl	$0, PER_CPU_VAR(__preempt_count)
@@ -358,7 +358,7 @@ ENTRY(resume_kernel)
 	jz	restore_all
 	call	preempt_schedule_irq
 	jmp	.Lneed_resched
-END(resume_kernel)
+SYM_CODE_END(resume_kernel)
 #endif
 
 SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
@@ -661,7 +661,7 @@ ENDPROC(entry_INT80_32)
  * We pack 1 stub into every 8-byte block.
  */
 	.align 8
-ENTRY(irq_entries_start)
+SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	pushl	$(~vector+0x80)			/* Note: always in signed byte range */
@@ -669,7 +669,7 @@ ENTRY(irq_entries_start)
 	jmp	common_interrupt
 	.align	8
     .endr
-END(irq_entries_start)
+SYM_CODE_END(irq_entries_start)
 
 /*
  * the CPU automatically disables interrupts when executing an IRQ vector,
@@ -705,14 +705,14 @@ ENDPROC(name)
 /* The include is where all of the SMP etc. interrupts come from */
 #include <asm/entry_arch.h>
 
-ENTRY(coprocessor_error)
+SYM_CODE_START(coprocessor_error)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_coprocessor_error
 	jmp	common_exception
-END(coprocessor_error)
+SYM_CODE_END(coprocessor_error)
 
-ENTRY(simd_coprocessor_error)
+SYM_CODE_START(simd_coprocessor_error)
 	ASM_CLAC
 	pushl	$0
 #ifdef CONFIG_X86_INVD_BUG
@@ -724,96 +724,96 @@ ENTRY(simd_coprocessor_error)
 	pushl	$do_simd_coprocessor_error
 #endif
 	jmp	common_exception
-END(simd_coprocessor_error)
+SYM_CODE_END(simd_coprocessor_error)
 
-ENTRY(device_not_available)
+SYM_CODE_START(device_not_available)
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
 	pushl	$do_device_not_available
 	jmp	common_exception
-END(device_not_available)
+SYM_CODE_END(device_not_available)
 
 #ifdef CONFIG_PARAVIRT
-ENTRY(native_iret)
+SYM_CODE_START(native_iret)
 	iret
 	_ASM_EXTABLE(native_iret, iret_exc)
-END(native_iret)
+SYM_CODE_END(native_iret)
 #endif
 
-ENTRY(overflow)
+SYM_CODE_START(overflow)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_overflow
 	jmp	common_exception
-END(overflow)
+SYM_CODE_END(overflow)
 
-ENTRY(bounds)
+SYM_CODE_START(bounds)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_bounds
 	jmp	common_exception
-END(bounds)
+SYM_CODE_END(bounds)
 
-ENTRY(invalid_op)
+SYM_CODE_START(invalid_op)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_invalid_op
 	jmp	common_exception
-END(invalid_op)
+SYM_CODE_END(invalid_op)
 
-ENTRY(coprocessor_segment_overrun)
+SYM_CODE_START(coprocessor_segment_overrun)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_coprocessor_segment_overrun
 	jmp	common_exception
-END(coprocessor_segment_overrun)
+SYM_CODE_END(coprocessor_segment_overrun)
 
-ENTRY(invalid_TSS)
+SYM_CODE_START(invalid_TSS)
 	ASM_CLAC
 	pushl	$do_invalid_TSS
 	jmp	common_exception
-END(invalid_TSS)
+SYM_CODE_END(invalid_TSS)
 
-ENTRY(segment_not_present)
+SYM_CODE_START(segment_not_present)
 	ASM_CLAC
 	pushl	$do_segment_not_present
 	jmp	common_exception
-END(segment_not_present)
+SYM_CODE_END(segment_not_present)
 
-ENTRY(stack_segment)
+SYM_CODE_START(stack_segment)
 	ASM_CLAC
 	pushl	$do_stack_segment
 	jmp	common_exception
-END(stack_segment)
+SYM_CODE_END(stack_segment)
 
-ENTRY(alignment_check)
+SYM_CODE_START(alignment_check)
 	ASM_CLAC
 	pushl	$do_alignment_check
 	jmp	common_exception
-END(alignment_check)
+SYM_CODE_END(alignment_check)
 
-ENTRY(divide_error)
+SYM_CODE_START(divide_error)
 	ASM_CLAC
 	pushl	$0				# no error code
 	pushl	$do_divide_error
 	jmp	common_exception
-END(divide_error)
+SYM_CODE_END(divide_error)
 
 #ifdef CONFIG_X86_MCE
-ENTRY(machine_check)
+SYM_CODE_START(machine_check)
 	ASM_CLAC
 	pushl	$0
 	pushl	machine_check_vector
 	jmp	common_exception
-END(machine_check)
+SYM_CODE_END(machine_check)
 #endif
 
-ENTRY(spurious_interrupt_bug)
+SYM_CODE_START(spurious_interrupt_bug)
 	ASM_CLAC
 	pushl	$0
 	pushl	$do_spurious_interrupt_bug
 	jmp	common_exception
-END(spurious_interrupt_bug)
+SYM_CODE_END(spurious_interrupt_bug)
 
 #ifdef CONFIG_XEN
 ENTRY(xen_hypervisor_callback)
@@ -915,12 +915,12 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
 
 #endif /* CONFIG_HYPERV */
 
-ENTRY(page_fault)
+SYM_CODE_START(page_fault)
 	ASM_CLAC
 	pushl	$do_page_fault
 	ALIGN
 	jmp common_exception
-END(page_fault)
+SYM_CODE_END(page_fault)
 
 SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	/* the function address is in %gs's slot on the stack */
@@ -954,7 +954,7 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	jmp	ret_from_exception
 SYM_CODE_END(common_exception)
 
-ENTRY(debug)
+SYM_CODE_START(debug)
 	/*
 	 * #DB can happen at the first instruction of
 	 * entry_SYSENTER_32 or in Xen's SYSENTER prologue.  If this
@@ -990,7 +990,7 @@ ENTRY(debug)
 	call	do_debug
 	movl	%ebx, %esp
 	jmp	ret_from_exception
-END(debug)
+SYM_CODE_END(debug)
 
 /*
  * NMI is doubly nasty.  It can happen on the first instruction of
@@ -999,7 +999,7 @@ END(debug)
  * switched stacks.  We handle both conditions by simply checking whether we
  * interrupted kernel code running on the SYSENTER stack.
  */
-ENTRY(nmi)
+SYM_CODE_START(nmi)
 	ASM_CLAC
 #ifdef CONFIG_X86_ESPFIX32
 	pushl	%eax
@@ -1059,9 +1059,9 @@ ENTRY(nmi)
 	lss	12+4(%esp), %esp		# back to espfix stack
 	jmp	.Lirq_return
 #endif
-END(nmi)
+SYM_CODE_END(nmi)
 
-ENTRY(int3)
+SYM_CODE_START(int3)
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
 	SAVE_ALL
@@ -1071,22 +1071,22 @@ ENTRY(int3)
 	movl	%esp, %eax			# pt_regs pointer
 	call	do_int3
 	jmp	ret_from_exception
-END(int3)
+SYM_CODE_END(int3)
 
-ENTRY(general_protection)
+SYM_CODE_START(general_protection)
 	pushl	$do_general_protection
 	jmp	common_exception
-END(general_protection)
+SYM_CODE_END(general_protection)
 
 #ifdef CONFIG_KVM_GUEST
-ENTRY(async_page_fault)
+SYM_CODE_START(async_page_fault)
 	ASM_CLAC
 	pushl	$do_async_page_fault
 	jmp	common_exception
-END(async_page_fault)
+SYM_CODE_END(async_page_fault)
 #endif
 
-ENTRY(rewind_stack_do_exit)
+SYM_CODE_START(rewind_stack_do_exit)
 	/* Prevent any naive code from trying to unwind to our caller. */
 	xorl	%ebp, %ebp
 
@@ -1095,4 +1095,4 @@ ENTRY(rewind_stack_do_exit)
 
 	call	do_exit
 1:	jmp 1b
-END(rewind_stack_do_exit)
+SYM_CODE_END(rewind_stack_do_exit)
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index e2463acbd2f9..0404a2103730 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -35,7 +35,7 @@ SYM_FUNC_START(function_hook)
 	ret
 SYM_FUNC_END(function_hook)
 
-ENTRY(ftrace_caller)
+SYM_CODE_START(ftrace_caller)
 
 #ifdef USING_FRAME_POINTER
 # ifdef CC_USING_FENTRY
@@ -100,7 +100,7 @@ ftrace_graph_call:
 /* This is weak to keep gas from relaxing the jumps */
 WEAK(ftrace_stub)
 	ret
-END(ftrace_caller)
+SYM_CODE_END(ftrace_caller)
 
 SYM_CODE_START(ftrace_regs_caller)
 	/*
@@ -173,7 +173,7 @@ SYM_CODE_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 SYM_CODE_END(ftrace_regs_caller)
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
-ENTRY(function_hook)
+SYM_CODE_START(function_hook)
 	cmpl	$__PAGE_OFFSET, %esp
 	jb	ftrace_stub			/* Paging not enabled yet? */
 
@@ -206,11 +206,11 @@ ftrace_stub:
 	popl	%ecx
 	popl	%eax
 	jmp	ftrace_stub
-END(function_hook)
+SYM_CODE_END(function_hook)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-ENTRY(ftrace_graph_caller)
+SYM_CODE_START(ftrace_graph_caller)
 	pushl	%eax
 	pushl	%ecx
 	pushl	%edx
@@ -229,7 +229,7 @@ ENTRY(ftrace_graph_caller)
 	popl	%ecx
 	popl	%eax
 	ret
-END(ftrace_graph_caller)
+SYM_CODE_END(ftrace_graph_caller)
 
 .globl return_to_handler
 return_to_handler:
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 60236d3f4a06..320b42b83883 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -120,11 +120,13 @@
 	SYM_FUNC_START_WEAK_NOALIGN(name)
 #endif
 
+#ifndef CONFIG_X86
 #ifndef END
 /* deprecated, use SYM_FUNC_END, SYM_DATA_END, or SYM_END */
 #define END(name) \
 	.size name, .-name
 #endif
+#endif /* CONFIG_X86 */
 
 #ifndef CONFIG_X86_64
 /* If symbol 'name' is treated as a subroutine (gets called, and returns)
-- 
2.16.3

From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v7 10/28] x86/asm/entry: annotate interrupt symbols properly
Date: Wed, 30 Jan 2019 13:46:53 +0100
Message-ID: <20190130124711.12463-11-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: bp@alien8.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

* annotate functions properly by SYM_CODE_START, SYM_CODE_START_LOCAL*
  and SYM_CODE_END -- these are not C-like functions, so we have to
  annotate them using CODE.
* use SYM_INNER_LABEL* for labels being in the middle of other functions

[v4] alignments preserved

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/entry/entry_32.S | 15 ++++++++-------
 arch/x86/entry/entry_64.S |  9 ++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 306ae3e9a24c..2a37764f498e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -754,7 +754,7 @@ ret_from_intr:
 	cmpl	$USER_RPL, %eax
 	jb	resume_kernel			# not returning to v8086 or userspace
 
-ENTRY(resume_userspace)
+SYM_INNER_LABEL_ALIGN(resume_userspace, SYM_L_LOCAL)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
@@ -1032,7 +1032,7 @@ restore_all_kernel:
 	jmp	.Lirq_return
 
 .section .fixup, "ax"
-ENTRY(iret_exc	)
+SYM_CODE_START(iret_exc)
 	pushl	$0				# no error code
 	pushl	$do_iret_error
 
@@ -1049,6 +1049,7 @@ ENTRY(iret_exc	)
 #endif
 
 	jmp	common_exception
+SYM_CODE_END(iret_exc)
 .previous
 	_ASM_EXTABLE(.Lirq_return, iret_exc)
 ENDPROC(entry_INT80_32)
@@ -1107,7 +1108,7 @@ END(irq_entries_start)
  * so IRQ-flags tracing has to follow that:
  */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
-common_interrupt:
+SYM_CODE_START_LOCAL(common_interrupt)
 	ASM_CLAC
 	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
 
@@ -1117,7 +1118,7 @@ common_interrupt:
 	movl	%esp, %eax
 	call	do_IRQ
 	jmp	ret_from_intr
-ENDPROC(common_interrupt)
+SYM_CODE_END(common_interrupt)
 
 #define BUILD_INTERRUPT3(name, nr, fn)			\
 ENTRY(name)						\
@@ -1269,7 +1270,7 @@ ENTRY(xen_hypervisor_callback)
 
 	jmp	xen_iret_crit_fixup
 
-ENTRY(xen_do_upcall)
+SYM_INNER_LABEL_ALIGN(xen_do_upcall, SYM_L_GLOBAL)
 1:	mov	%esp, %eax
 	call	xen_evtchn_do_upcall
 #ifndef CONFIG_PREEMPT
@@ -1356,7 +1357,7 @@ ENTRY(page_fault)
 	jmp common_exception
 END(page_fault)
 
-common_exception:
+SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	/* the function address is in %gs's slot on the stack */
 	pushl	%fs
 	pushl	%es
@@ -1387,7 +1388,7 @@ common_exception:
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC %edi
 	jmp	ret_from_exception
-END(common_exception)
+SYM_CODE_END(common_exception)
 
 ENTRY(debug)
 	/*
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 463f9edd78a4..76d52e489e1a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -576,7 +576,7 @@ _ASM_NOKPROBE(interrupt_entry)
 	 * then jump to common_interrupt.
 	 */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
-common_interrupt:
+SYM_CODE_START_LOCAL(common_interrupt)
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
@@ -672,7 +672,7 @@ GLOBAL(restore_regs_and_return_to_kernel)
 	 */
 	INTERRUPT_RETURN
 
-ENTRY(native_iret)
+SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
 	UNWIND_HINT_IRET_REGS
 	/*
 	 * Are we returning to a stack segment from the LDT?  Note: in
@@ -683,8 +683,7 @@ ENTRY(native_iret)
 	jnz	native_irq_return_ldt
 #endif
 
-.global native_irq_return_iret
-native_irq_return_iret:
+SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
 	/*
 	 * This may fault.  Non-paranoid faults on return to userspace are
 	 * handled by fixup_bad_iret.  These include #SS, #GP, and #NP.
@@ -766,7 +765,7 @@ native_irq_return_ldt:
 	 */
 	jmp	native_irq_return_iret
 #endif
-END(common_interrupt)
+SYM_CODE_END(common_interrupt)
 _ASM_NOKPROBE(common_interrupt)
 
 /*
-- 
2.20.1

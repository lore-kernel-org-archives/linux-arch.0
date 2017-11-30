From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v5 09/27] x86: entry, annotate interrupt symbols properly
Date: Thu, 30 Nov 2017 15:46:35 +0100
Message-ID: <20171130144653.23688-10-jslaby@suse.cz>
References: <20171130144653.23688-1-jslaby@suse.cz>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48125 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752950AbdK3OrA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Nov 2017 09:47:00 -0500
In-Reply-To: <20171130144653.23688-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

* annotate functions properly by SYM_CODE_START, SYM_CODE_START_LOCAL*
  and SYM_CODE_END -- these are not C-like functions, so we have to
  annotate them using CODE.
* use SYM_CODE_INNER_LABEL* for labels being in the middle of other
  functions

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
index bd003ed5180f..b99e552f932a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -325,7 +325,7 @@ ret_from_intr:
 	cmpl	$USER_RPL, %eax
 	jb	resume_kernel			# not returning to v8086 or userspace
 
-ENTRY(resume_userspace)
+SYM_CODE_INNER_LABEL_ALIGN(resume_userspace, SYM_L_LOCAL)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
@@ -555,10 +555,11 @@ restore_all:
 	INTERRUPT_RETURN
 
 .section .fixup, "ax"
-ENTRY(iret_exc	)
+SYM_CODE_START(iret_exc)
 	pushl	$0				# no error code
 	pushl	$do_iret_error
 	jmp	common_exception
+SYM_CODE_END(iret_exc)
 .previous
 	_ASM_EXTABLE(.Lirq_return, iret_exc)
 
@@ -650,7 +651,7 @@ END(irq_entries_start)
  * so IRQ-flags tracing has to follow that:
  */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
-common_interrupt:
+SYM_CODE_START_LOCAL(common_interrupt)
 	ASM_CLAC
 	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
 	SAVE_ALL
@@ -659,7 +660,7 @@ common_interrupt:
 	movl	%esp, %eax
 	call	do_IRQ
 	jmp	ret_from_intr
-ENDPROC(common_interrupt)
+SYM_CODE_END(common_interrupt)
 
 #define BUILD_INTERRUPT3(name, nr, fn)	\
 ENTRY(name)				\
@@ -811,7 +812,7 @@ ENTRY(xen_hypervisor_callback)
 
 	jmp	xen_iret_crit_fixup
 
-ENTRY(xen_do_upcall)
+SYM_CODE_INNER_LABEL_ALIGN(xen_do_upcall, SYM_L_GLOBAL)
 1:	mov	%esp, %eax
 	call	xen_evtchn_do_upcall
 #ifndef CONFIG_PREEMPT
@@ -890,7 +891,7 @@ ENTRY(page_fault)
 	jmp common_exception
 END(page_fault)
 
-common_exception:
+SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	/* the function address is in %gs's slot on the stack */
 	pushl	%fs
 	pushl	%es
@@ -920,7 +921,7 @@ common_exception:
 	movl	%esp, %eax			# pt_regs pointer
 	call	*%edi
 	jmp	ret_from_exception
-END(common_exception)
+SYM_CODE_END(common_exception)
 
 ENTRY(debug)
 	/*
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 61acc911c68d..d1efae953752 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -681,7 +681,7 @@ END(irq_entries_start)
 	 * then jump to common_interrupt.
 	 */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
-common_interrupt:
+SYM_CODE_START_LOCAL(common_interrupt)
 	ASM_CLAC
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	interrupt do_IRQ
@@ -780,7 +780,7 @@ GLOBAL(restore_regs_and_return_to_kernel)
 	addq	$8, %rsp	/* skip regs->orig_ax */
 	INTERRUPT_RETURN
 
-ENTRY(native_iret)
+SYM_CODE_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
 	UNWIND_HINT_IRET_REGS
 	/*
 	 * Are we returning to a stack segment from the LDT?  Note: in
@@ -791,8 +791,7 @@ ENTRY(native_iret)
 	jnz	native_irq_return_ldt
 #endif
 
-.global native_irq_return_iret
-native_irq_return_iret:
+SYM_CODE_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
 	/*
 	 * This may fault.  Non-paranoid faults on return to userspace are
 	 * handled by fixup_bad_iret.  These include #SS, #GP, and #NP.
@@ -869,7 +868,7 @@ native_irq_return_ldt:
 	 */
 	jmp	native_irq_return_iret
 #endif
-END(common_interrupt)
+SYM_CODE_END(common_interrupt)
 
 /*
  * APIC interrupts.
-- 
2.15.0

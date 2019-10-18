Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:57704 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439842AbfJRQat (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:49 -0400
Date: Fri, 18 Oct 2019 16:30:31 -0000
From: "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/entry: Annotate interrupt symbols properly
In-Reply-To: <20191011115108.12392-11-jslaby@suse.cz>
References: <20191011115108.12392-11-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623168.29376.17128924745763941780.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Message-ID: <20191018163031.XW0EQJamIwTNKJ1HMZQ_9EK3jBnYcGUFOX9msPCMl6I@z>

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     cc66936e504a5b91dda52fda90203e174a7a71aa
Gitweb:        https://git.kernel.org/tip/cc66936e504a5b91dda52fda90203e174a7a71aa
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:50 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 10:40:11 +02:00

x86/asm/entry: Annotate interrupt symbols properly

* annotate functions properly by SYM_CODE_START, SYM_CODE_START_LOCAL*
  and SYM_CODE_END -- these are not C-like functions, so they have to
  be annotated using CODE.
* use SYM_INNER_LABEL* for labels being in the middle of other functions
  This prevents nested labels annotations.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-arch@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191011115108.12392-11-jslaby@suse.cz
---
 arch/x86/entry/entry_32.S | 28 ++++++++++++++--------------
 arch/x86/entry/entry_64.S | 13 ++++++-------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index f83ca5a..f37ff58 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -807,8 +807,7 @@ END(ret_from_fork)
  */
 
 	# userspace resumption stub bypassing syscall exit tracing
-	ALIGN
-ret_from_exception:
+SYM_CODE_START_LOCAL(ret_from_exception)
 	preempt_stop(CLBR_ANY)
 ret_from_intr:
 #ifdef CONFIG_VM86
@@ -825,13 +824,13 @@ ret_from_intr:
 	cmpl	$USER_RPL, %eax
 	jb	restore_all_kernel		# not returning to v8086 or userspace
 
-ENTRY(resume_userspace)
+SYM_INNER_LABEL_ALIGN(resume_userspace, SYM_L_LOCAL)
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 	movl	%esp, %eax
 	call	prepare_exit_to_usermode
 	jmp	restore_all
-END(ret_from_exception)
+SYM_CODE_END(ret_from_exception)
 
 GLOBAL(__begin_SYSENTER_singlestep_region)
 /*
@@ -1100,7 +1099,7 @@ restore_all_kernel:
 	jmp	.Lirq_return
 
 .section .fixup, "ax"
-ENTRY(iret_exc	)
+SYM_CODE_START(iret_exc)
 	pushl	$0				# no error code
 	pushl	$do_iret_error
 
@@ -1117,6 +1116,7 @@ ENTRY(iret_exc	)
 #endif
 
 	jmp	common_exception
+SYM_CODE_END(iret_exc)
 .previous
 	_ASM_EXTABLE(.Lirq_return, iret_exc)
 ENDPROC(entry_INT80_32)
@@ -1182,7 +1182,7 @@ ENTRY(spurious_entries_start)
     .endr
 END(spurious_entries_start)
 
-common_spurious:
+SYM_CODE_START_LOCAL(common_spurious)
 	ASM_CLAC
 	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
 	SAVE_ALL switch_stacks=1
@@ -1191,7 +1191,7 @@ common_spurious:
 	movl	%esp, %eax
 	call	smp_spurious_interrupt
 	jmp	ret_from_intr
-ENDPROC(common_spurious)
+SYM_CODE_END(common_spurious)
 #endif
 
 /*
@@ -1199,7 +1199,7 @@ ENDPROC(common_spurious)
  * so IRQ-flags tracing has to follow that:
  */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
-common_interrupt:
+SYM_CODE_START_LOCAL(common_interrupt)
 	ASM_CLAC
 	addl	$-0x80, (%esp)			/* Adjust vector into the [-256, -1] range */
 
@@ -1209,7 +1209,7 @@ common_interrupt:
 	movl	%esp, %eax
 	call	do_IRQ
 	jmp	ret_from_intr
-ENDPROC(common_interrupt)
+SYM_CODE_END(common_interrupt)
 
 #define BUILD_INTERRUPT3(name, nr, fn)			\
 ENTRY(name)						\
@@ -1361,7 +1361,7 @@ ENTRY(xen_hypervisor_callback)
 
 	jmp	xen_iret_crit_fixup
 
-ENTRY(xen_do_upcall)
+SYM_INNER_LABEL_ALIGN(xen_do_upcall, SYM_L_GLOBAL)
 1:	mov	%esp, %eax
 	call	xen_evtchn_do_upcall
 #ifndef CONFIG_PREEMPTION
@@ -1447,7 +1447,7 @@ ENTRY(page_fault)
 	jmp	common_exception_read_cr2
 END(page_fault)
 
-common_exception_read_cr2:
+SYM_CODE_START_LOCAL_NOALIGN(common_exception_read_cr2)
 	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1
 
@@ -1470,9 +1470,9 @@ common_exception_read_cr2:
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC %edi
 	jmp	ret_from_exception
-END(common_exception_read_cr2)
+SYM_CODE_END(common_exception_read_cr2)
 
-common_exception:
+SYM_CODE_START_LOCAL_NOALIGN(common_exception)
 	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1
 	ENCODE_FRAME_POINTER
@@ -1492,7 +1492,7 @@ common_exception:
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC %edi
 	jmp	ret_from_exception
-END(common_exception)
+SYM_CODE_END(common_exception)
 
 ENTRY(debug)
 	/*
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index db43526..607e25f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -589,18 +589,18 @@ _ASM_NOKPROBE(interrupt_entry)
  * The interrupt stubs push (~vector+0x80) onto the stack and
  * then jump to common_spurious/interrupt.
  */
-common_spurious:
+SYM_CODE_START_LOCAL(common_spurious)
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
 	call	smp_spurious_interrupt		/* rdi points to pt_regs */
 	jmp	ret_from_intr
-END(common_spurious)
+SYM_CODE_END(common_spurious)
 _ASM_NOKPROBE(common_spurious)
 
 /* common_interrupt is a hotpath. Align it */
 	.p2align CONFIG_X86_L1_CACHE_SHIFT
-common_interrupt:
+SYM_CODE_START_LOCAL(common_interrupt)
 	addq	$-0x80, (%rsp)			/* Adjust vector to [-256, -1] range */
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
@@ -695,7 +695,7 @@ GLOBAL(restore_regs_and_return_to_kernel)
 	 */
 	INTERRUPT_RETURN
 
-ENTRY(native_iret)
+SYM_INNER_LABEL_ALIGN(native_iret, SYM_L_GLOBAL)
 	UNWIND_HINT_IRET_REGS
 	/*
 	 * Are we returning to a stack segment from the LDT?  Note: in
@@ -706,8 +706,7 @@ ENTRY(native_iret)
 	jnz	native_irq_return_ldt
 #endif
 
-.global native_irq_return_iret
-native_irq_return_iret:
+SYM_INNER_LABEL(native_irq_return_iret, SYM_L_GLOBAL)
 	/*
 	 * This may fault.  Non-paranoid faults on return to userspace are
 	 * handled by fixup_bad_iret.  These include #SS, #GP, and #NP.
@@ -789,7 +788,7 @@ native_irq_return_ldt:
 	 */
 	jmp	native_irq_return_iret
 #endif
-END(common_interrupt)
+SYM_CODE_END(common_interrupt)
 _ASM_NOKPROBE(common_interrupt)
 
 /*

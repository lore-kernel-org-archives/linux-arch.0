Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756792AbeEJIHH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 May 2018 04:07:07 -0400
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend 19/27] x86: assembly, make some functions local
Date: Thu, 10 May 2018 10:06:36 +0200
Message-ID: <20180510080644.19752-20-jslaby@suse.cz>
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180510080636.-AIAS46iWMCE6M_z1Yw2r7a1Y-lOQMUlkT3zVZS6mws@z>

There is a couple of assembly functions, which are invoked only locally
in the file they are defined. In C, we mark them "static". In assembly,
annotate them using SYM_{FUNC,CODE}_START_LOCAL (and switch their
ENDPROC to SYM_{FUNC,CODE}_END too). Whether FUNC or CODE depends on
ENDPROC/END for a particular function (C or non-C).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/boot/compressed/efi_thunk_64.S |  8 ++++----
 arch/x86/entry/entry_64.S               | 21 +++++++++++----------
 arch/x86/lib/copy_page_64.S             |  4 ++--
 arch/x86/lib/memcpy_64.S                | 12 ++++++------
 arch/x86/lib/memset_64.S                |  8 ++++----
 arch/x86/platform/efi/efi_thunk_64.S    | 12 ++++++------
 arch/x86/xen/xen-pvh.S                  |  4 ++--
 7 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index d66000d23921..31312070db22 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -99,12 +99,12 @@ ENTRY(efi64_thunk)
 	ret
 ENDPROC(efi64_thunk)
 
-ENTRY(efi_exit32)
+SYM_FUNC_START_LOCAL(efi_exit32)
 	movq	func_rt_ptr(%rip), %rax
 	push	%rax
 	mov	%rdi, %rax
 	ret
-ENDPROC(efi_exit32)
+SYM_FUNC_END(efi_exit32)
 
 	.code32
 /*
@@ -112,7 +112,7 @@ ENDPROC(efi_exit32)
  *
  * The stack should represent the 32-bit calling convention.
  */
-ENTRY(efi_enter32)
+SYM_FUNC_START_LOCAL(efi_enter32)
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
 	movl	%eax, %es
@@ -172,7 +172,7 @@ ENTRY(efi_enter32)
 	btsl	$X86_CR0_PG_BIT, %eax
 	movl	%eax, %cr0
 	lret
-ENDPROC(efi_enter32)
+SYM_FUNC_END(efi_enter32)
 
 	.data
 	.balign	8
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index fda55310de2a..c6841c038170 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1068,7 +1068,8 @@ idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
  * existing activation in its critical region -- if so, we pop the current
  * activation and restart the handler using the previous one.
  */
-ENTRY(xen_do_hypervisor_callback)		/* do_hypervisor_callback(struct *pt_regs) */
+/* do_hypervisor_callback(struct *pt_regs) */
+SYM_CODE_START_LOCAL(xen_do_hypervisor_callback)
 
 /*
  * Since we don't modify %rdi, evtchn_do_upall(struct *pt_regs) will
@@ -1086,7 +1087,7 @@ ENTRY(xen_do_hypervisor_callback)		/* do_hypervisor_callback(struct *pt_regs) */
 	call	xen_maybe_preempt_hcall
 #endif
 	jmp	error_exit
-END(xen_do_hypervisor_callback)
+SYM_CODE_END(xen_do_hypervisor_callback)
 
 /*
  * Hypervisor uses this for application faults while it executes.
@@ -1175,7 +1176,7 @@ idtentry machine_check		do_mce			has_error_code=0	paranoid=1
  * Use slow, but surefire "are we in kernel?" check.
  * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
  */
-ENTRY(paranoid_entry)
+SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
@@ -1192,7 +1193,7 @@ ENTRY(paranoid_entry)
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
 	ret
-END(paranoid_entry)
+SYM_CODE_END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
@@ -1206,7 +1207,7 @@ END(paranoid_entry)
  *
  * On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it)
  */
-ENTRY(paranoid_exit)
+SYM_CODE_START_LOCAL(paranoid_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF_DEBUG
@@ -1221,13 +1222,13 @@ ENTRY(paranoid_exit)
 	RESTORE_CR3	scratch_reg=%rbx save_reg=%r14
 .Lparanoid_exit_restore:
 	jmp restore_regs_and_return_to_kernel
-END(paranoid_exit)
+SYM_CODE_END(paranoid_exit)
 
 /*
  * Save all registers in pt_regs, and switch GS if needed.
  * Return: EBX=0: came from user mode; EBX=1: otherwise
  */
-ENTRY(error_entry)
+SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
@@ -1314,7 +1315,7 @@ ENTRY(error_entry)
 	mov	%rax, %rsp
 	decl	%ebx
 	jmp	.Lerror_entry_from_usermode_after_swapgs
-END(error_entry)
+SYM_CODE_END(error_entry)
 
 
 /*
@@ -1322,14 +1323,14 @@ END(error_entry)
  *   1: already in kernel mode, don't need SWAPGS
  *   0: user gsbase is loaded, we need SWAPGS and standard preparation for return to usermode
  */
-ENTRY(error_exit)
+SYM_CODE_START_LOCAL(error_exit)
 	UNWIND_HINT_REGS
 	DISABLE_INTERRUPTS(CLBR_ANY)
 	TRACE_IRQS_OFF
 	testl	%ebx, %ebx
 	jnz	retint_kernel
 	jmp	retint_user
-END(error_exit)
+SYM_CODE_END(error_exit)
 
 /*
  * Runs on exception stack.  Xen PV does not go through this path at all,
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index fd2d09afa097..f505870bd93b 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -21,7 +21,7 @@ ENTRY(copy_page)
 ENDPROC(copy_page)
 EXPORT_SYMBOL(copy_page)
 
-ENTRY(copy_page_regs)
+SYM_FUNC_START_LOCAL(copy_page_regs)
 	subq	$2*8,	%rsp
 	movq	%rbx,	(%rsp)
 	movq	%r12,	1*8(%rsp)
@@ -86,4 +86,4 @@ ENTRY(copy_page_regs)
 	movq	1*8(%rsp), %r12
 	addq	$2*8, %rsp
 	ret
-ENDPROC(copy_page_regs)
+SYM_FUNC_END(copy_page_regs)
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 4911b1c61aa8..728703c47d58 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -27,7 +27,7 @@
  * rax original destination
  */
 SYM_FUNC_START_ALIAS(__memcpy)
-ENTRY(memcpy)
+SYM_FUNC_START_LOCAL(memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
@@ -39,7 +39,7 @@ ENTRY(memcpy)
 	movl %edx, %ecx
 	rep movsb
 	ret
-ENDPROC(memcpy)
+SYM_FUNC_END(memcpy)
 SYM_FUNC_END_ALIAS(__memcpy)
 EXPORT_SYMBOL(memcpy)
 EXPORT_SYMBOL(__memcpy)
@@ -48,14 +48,14 @@ EXPORT_SYMBOL(__memcpy)
  * memcpy_erms() - enhanced fast string memcpy. This is faster and
  * simpler than memcpy. Use memcpy_erms when possible.
  */
-ENTRY(memcpy_erms)
+SYM_FUNC_START_LOCAL(memcpy_erms)
 	movq %rdi, %rax
 	movq %rdx, %rcx
 	rep movsb
 	ret
-ENDPROC(memcpy_erms)
+SYM_FUNC_END(memcpy_erms)
 
-ENTRY(memcpy_orig)
+SYM_FUNC_START_LOCAL(memcpy_orig)
 	movq %rdi, %rax
 
 	cmpq $0x20, %rdx
@@ -180,7 +180,7 @@ ENTRY(memcpy_orig)
 
 .Lend:
 	retq
-ENDPROC(memcpy_orig)
+SYM_FUNC_END(memcpy_orig)
 
 #ifndef CONFIG_UML
 /*
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 927ac44d34aa..564abf9ecedb 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -59,16 +59,16 @@ EXPORT_SYMBOL(__memset)
  *
  * rax   original destination
  */
-ENTRY(memset_erms)
+SYM_FUNC_START_LOCAL(memset_erms)
 	movq %rdi,%r9
 	movb %sil,%al
 	movq %rdx,%rcx
 	rep stosb
 	movq %r9,%rax
 	ret
-ENDPROC(memset_erms)
+SYM_FUNC_END(memset_erms)
 
-ENTRY(memset_orig)
+SYM_FUNC_START_LOCAL(memset_orig)
 	movq %rdi,%r10
 
 	/* expand byte value  */
@@ -139,4 +139,4 @@ ENTRY(memset_orig)
 	subq %r8,%rdx
 	jmp .Lafter_bad_alignment
 .Lfinal:
-ENDPROC(memset_orig)
+SYM_FUNC_END(memset_orig)
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 46c58b08739c..d677a7eb2d0a 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -67,7 +67,7 @@ ENDPROC(efi64_thunk)
  *
  * This function must be invoked with a 1:1 mapped stack.
  */
-ENTRY(__efi64_thunk)
+SYM_FUNC_START_LOCAL(__efi64_thunk)
 	movl	%ds, %eax
 	push	%rax
 	movl	%es, %eax
@@ -114,14 +114,14 @@ ENTRY(__efi64_thunk)
 	or	%rcx, %rax
 1:
 	ret
-ENDPROC(__efi64_thunk)
+SYM_FUNC_END(__efi64_thunk)
 
-ENTRY(efi_exit32)
+SYM_FUNC_START_LOCAL(efi_exit32)
 	movq	func_rt_ptr(%rip), %rax
 	push	%rax
 	mov	%rdi, %rax
 	ret
-ENDPROC(efi_exit32)
+SYM_FUNC_END(efi_exit32)
 
 	.code32
 /*
@@ -129,7 +129,7 @@ ENDPROC(efi_exit32)
  *
  * The stack should represent the 32-bit calling convention.
  */
-ENTRY(efi_enter32)
+SYM_FUNC_START_LOCAL(efi_enter32)
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
 	movl	%eax, %es
@@ -145,7 +145,7 @@ ENTRY(efi_enter32)
 	pushl	%eax
 
 	lret
-ENDPROC(efi_enter32)
+SYM_FUNC_END(efi_enter32)
 
 	.data
 	.balign	8
diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index 52b28793a625..a20a55cc5135 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -54,7 +54,7 @@
  * charge of setting up it's own stack, GDT and IDT.
  */
 
-ENTRY(pvh_start_xen)
+SYM_CODE_START_LOCAL(pvh_start_xen)
 	cld
 
 	lgdt (_pa(gdt))
@@ -133,7 +133,7 @@ ENTRY(pvh_start_xen)
 
 	ljmp $__BOOT_CS, $_pa(startup_32)
 #endif
-END(pvh_start_xen)
+SYM_CODE_END(pvh_start_xen)
 
 	.section ".init.data","aw"
 	.balign 8
-- 
2.16.3

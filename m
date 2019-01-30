From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v7 06/28] x86/asm: annotate local pseudo-functions
Date: Wed, 30 Jan 2019 13:46:49 +0100
Message-ID: <20190130124711.12463-7-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: bp@alien8.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Use the newly added SYM_CODE_START_LOCAL* to annotate starts of all
pseudo-functions (those ending END until now) which do not have ".globl"
annotation. This is needed to balance END for tools that generate
debuginfo. Note that we switch from END to SYM_CODE_END too so that
everybody can see the pairing.

We are not annotating C-like functions (which handle frame ptr etc.)
here, hence we use SYM_CODE_* macros here, not SYM_FUNC_*.  Note that
early_idt_handler_common already had ENDPROC -- switch that to
SYM_CODE_END for the same reason as above.

bogus_64_magic, bad_address, bad_get_user*, and bad_put_user are now
aligned, as they are separate functions. They do not mind to be aligned
-- no need to be compact there.

early_idt_handler_common is aligned now too, as it is after
early_idt_handler_array, so as well no need to be compact there.

verify_cpu is self-standing and included in other .S files, so align it
too.

The others have alignment preserved to what it used to be (using the
_NOALIGN variant of macros).

[v3] annotate more functions
[v4] describe the alignments changes

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
---
 arch/x86/entry/entry_32.S        | 5 ++---
 arch/x86/entry/entry_64.S        | 3 ++-
 arch/x86/kernel/acpi/wakeup_64.S | 3 ++-
 arch/x86/kernel/head_32.S        | 4 ++--
 arch/x86/kernel/head_64.S        | 4 ++--
 arch/x86/kernel/verify_cpu.S     | 4 ++--
 arch/x86/lib/getuser.S           | 8 ++++----
 arch/x86/lib/putuser.S           | 4 ++--
 8 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d309f30cf7af..306ae3e9a24c 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -737,8 +737,7 @@ END(ret_from_fork)
  */
 
 	# userspace resumption stub bypassing syscall exit tracing
-	ALIGN
-ret_from_exception:
+SYM_CODE_START_LOCAL(ret_from_exception)
 	preempt_stop(CLBR_ANY)
 ret_from_intr:
 #ifdef CONFIG_VM86
@@ -761,7 +760,7 @@ ENTRY(resume_userspace)
 	movl	%esp, %eax
 	call	prepare_exit_to_usermode
 	jmp	restore_all
-END(ret_from_exception)
+SYM_CODE_END(ret_from_exception)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f0efdb7b629..463f9edd78a4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1006,7 +1006,7 @@ EXPORT_SYMBOL(native_load_gs_index)
 	_ASM_EXTABLE(.Lgs_change, bad_gs)
 	.section .fixup, "ax"
 	/* running with kernelgs */
-bad_gs:
+SYM_CODE_START_LOCAL_NOALIGN(bad_gs)
 	SWAPGS					/* switch back to user gs */
 .macro ZAP_GS
 	/* This can't be a string because the preprocessor needs to see it. */
@@ -1017,6 +1017,7 @@ bad_gs:
 	xorl	%eax, %eax
 	movl	%eax, %gs
 	jmp	2b
+SYM_CODE_END(bad_gs)
 	.previous
 
 /* Call softirq on interrupt stack. Interrupts are off. */
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 551758f48eb7..6c60fe346583 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -36,8 +36,9 @@ ENTRY(wakeup_long64)
 	jmp	*%rax
 ENDPROC(wakeup_long64)
 
-bogus_64_magic:
+SYM_CODE_START_LOCAL(bogus_64_magic)
 	jmp	bogus_64_magic
+SYM_CODE_END(bogus_64_magic)
 
 ENTRY(do_suspend_lowlevel)
 	FRAME_BEGIN
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index d1e213da4782..0bae769b7b59 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -409,7 +409,7 @@ ENTRY(early_idt_handler_array)
 	.endr
 ENDPROC(early_idt_handler_array)
 	
-early_idt_handler_common:
+SYM_CODE_START_LOCAL(early_idt_handler_common)
 	/*
 	 * The stack is the hardware frame, an error code or zero, and the
 	 * vector number.
@@ -460,7 +460,7 @@ early_idt_handler_common:
 	decl	%ss:early_recursion_flag
 	addl	$4, %esp	/* pop pt_regs->orig_ax */
 	iret
-ENDPROC(early_idt_handler_common)
+SYM_CODE_END(early_idt_handler_common)
 
 /* This is the default interrupt "handler" :-) */
 ENTRY(early_ignore_irq)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d994162cce31..251f02c743fe 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -293,7 +293,7 @@ ENTRY(early_idt_handler_array)
 	UNWIND_HINT_IRET_REGS offset=16
 END(early_idt_handler_array)
 
-early_idt_handler_common:
+SYM_CODE_START_LOCAL(early_idt_handler_common)
 	/*
 	 * The stack is the hardware frame, an error code or zero, and the
 	 * vector number.
@@ -335,7 +335,7 @@ early_idt_handler_common:
 20:
 	decl early_recursion_flag(%rip)
 	jmp restore_regs_and_return_to_kernel
-END(early_idt_handler_common)
+SYM_CODE_END(early_idt_handler_common)
 
 	__INITDATA
 
diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
index 3d3c2f71f617..fd60f1ac5fec 100644
--- a/arch/x86/kernel/verify_cpu.S
+++ b/arch/x86/kernel/verify_cpu.S
@@ -33,7 +33,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/msr-index.h>
 
-ENTRY(verify_cpu)
+SYM_FUNC_START_LOCAL(verify_cpu)
 	pushf				# Save caller passed flags
 	push	$0			# Kill any dangerous flags
 	popf
@@ -139,4 +139,4 @@ ENTRY(verify_cpu)
 	popf				# Restore caller passed flags
 	xorl %eax, %eax
 	ret
-ENDPROC(verify_cpu)
+SYM_FUNC_END(verify_cpu)
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 74fdff968ea3..3ca4eab3a3e6 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -115,21 +115,21 @@ ENDPROC(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
 
-bad_get_user:
+SYM_CODE_START_LOCAL(bad_get_user)
 	xor %edx,%edx
 	mov $(-EFAULT),%_ASM_AX
 	ASM_CLAC
 	ret
-END(bad_get_user)
+SYM_CODE_END(bad_get_user)
 
 #ifdef CONFIG_X86_32
-bad_get_user_8:
+SYM_CODE_START_LOCAL(bad_get_user_8)
 	xor %edx,%edx
 	xor %ecx,%ecx
 	mov $(-EFAULT),%_ASM_AX
 	ASM_CLAC
 	ret
-END(bad_get_user_8)
+SYM_CODE_END(bad_get_user_8)
 #endif
 
 	_ASM_EXTABLE_UA(1b, bad_get_user)
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index d2e5c9c39601..67ef9b4c7eea 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -89,10 +89,10 @@ ENTRY(__put_user_8)
 ENDPROC(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
-bad_put_user:
+SYM_CODE_START_LOCAL(bad_put_user)
 	movl $-EFAULT,%eax
 	EXIT
-END(bad_put_user)
+SYM_CODE_END(bad_put_user)
 
 	_ASM_EXTABLE_UA(1b, bad_put_user)
 	_ASM_EXTABLE_UA(2b, bad_put_user)
-- 
2.20.1

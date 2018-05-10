From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend 16/27] x86: assembly, use SYM_CODE_INNER_LABEL instead of GLOBAL
Date: Thu, 10 May 2018 10:06:33 +0200
Message-ID: <20180510080644.19752-17-jslaby@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andy Lutomirski <luto@amacapital.net>
List-Id: linux-arch.vger.kernel.org

GLOBAL had several meanings and is going away. In this patch, convert
all the inner function labels marked with GLOBAL to use
SYM_CODE_INNER_LABEL instead.

Note that retint_user needs not be global, perhaps since commit
2ec67971facc ("x86/entry/64/compat: Remove most of the fast system call
machinery"), where entry_64_compat's caller was removed. So mark the
label as LOCAL.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/entry/entry_64.S                |  8 ++++----
 arch/x86/entry/entry_64_compat.S         |  4 ++--
 arch/x86/entry/vdso/vdso32/system_call.S |  2 +-
 arch/x86/kernel/ftrace_32.S              |  2 +-
 arch/x86/kernel/ftrace_64.S              | 16 ++++++++--------
 arch/x86/realmode/rm/reboot.S            |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0380041a5357..fda55310de2a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -225,7 +225,7 @@ ENTRY(entry_SYSCALL_64)
 	pushq	%r11				/* pt_regs->flags */
 	pushq	$__USER_CS			/* pt_regs->cs */
 	pushq	%rcx				/* pt_regs->ip */
-GLOBAL(entry_SYSCALL_64_after_hwframe)
+SYM_CODE_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	pushq	%rax				/* pt_regs->orig_ax */
 
 	PUSH_AND_CLEAR_REGS rax=$-ENOSYS
@@ -653,12 +653,12 @@ ret_from_intr:
 	jz	retint_kernel
 
 	/* Interrupt came from user space */
-GLOBAL(retint_user)
+SYM_CODE_INNER_LABEL(retint_user, SYM_L_LOCAL)
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
 	TRACE_IRQS_IRETQ
 
-GLOBAL(swapgs_restore_regs_and_return_to_usermode)
+SYM_CODE_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
 	/* Assert that pt_regs indicates user mode. */
 	testb	$3, CS(%rsp)
@@ -717,7 +717,7 @@ retint_kernel:
 	 */
 	TRACE_IRQS_IRETQ
 
-GLOBAL(restore_regs_and_return_to_kernel)
+SYM_CODE_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
 #ifdef CONFIG_DEBUG_ENTRY
 	/* Assert that pt_regs indicates kernel mode. */
 	testb	$3, CS(%rsp)
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 2d10f72697f3..076659472d40 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -146,7 +146,7 @@ ENTRY(entry_SYSENTER_compat)
 	pushq	$X86_EFLAGS_FIXED
 	popfq
 	jmp	.Lsysenter_flags_fixed
-GLOBAL(__end_entry_SYSENTER_compat)
+SYM_CODE_INNER_LABEL(__end_entry_SYSENTER_compat, SYM_L_GLOBAL)
 ENDPROC(entry_SYSENTER_compat)
 
 /*
@@ -215,7 +215,7 @@ ENTRY(entry_SYSCALL_compat)
 	pushq	%r11			/* pt_regs->flags */
 	pushq	$__USER32_CS		/* pt_regs->cs */
 	pushq	%rcx			/* pt_regs->ip */
-GLOBAL(entry_SYSCALL_compat_after_hwframe)
+SYM_CODE_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 	movl	%eax, %eax		/* discard orig_ax high bits */
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index 263d7433dea8..dbda9c96a303 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -62,7 +62,7 @@ __kernel_vsyscall:
 
 	/* Enter using int $0x80 */
 	int	$0x80
-GLOBAL(int80_landing_pad)
+SYM_CODE_INNER_LABEL(int80_landing_pad, SYM_L_GLOBAL)
 
 	/*
 	 * Restore EDX and ECX in case they were clobbered.  EBP is not
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 4c8440de3355..890c9068146f 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -141,7 +141,7 @@ ENTRY(ftrace_regs_caller)
 	movl	function_trace_op, %ecx		/* Save ftrace_pos in 3rd parameter */
 	pushl	%esp				/* Save pt_regs as 4th parameter */
 
-GLOBAL(ftrace_regs_call)
+SYM_CODE_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	call	ftrace_stub
 
 	addl	$4, %esp			/* Skip pt_regs */
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 91b2cff4b79a..b50fbb405763 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -158,14 +158,14 @@ ENTRY(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
-GLOBAL(ftrace_caller_op_ptr)
+SYM_CODE_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
 	/* regs go into 4th parameter (but make it NULL) */
 	movq $0, %rcx
 
-GLOBAL(ftrace_call)
+SYM_CODE_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call ftrace_stub
 
 	restore_mcount_regs
@@ -178,10 +178,10 @@ GLOBAL(ftrace_call)
 	 * think twice before adding any new code or changing the
 	 * layout here.
 	 */
-GLOBAL(ftrace_epilogue)
+SYM_CODE_INNER_LABEL(ftrace_epilogue, SYM_L_GLOBAL)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-GLOBAL(ftrace_graph_call)
+SYM_CODE_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 	jmp ftrace_stub
 #endif
 
@@ -198,7 +198,7 @@ ENTRY(ftrace_regs_caller)
 	save_mcount_regs 8
 	/* save_mcount_regs fills in first two parameters */
 
-GLOBAL(ftrace_regs_caller_op_ptr)
+SYM_CODE_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
@@ -225,7 +225,7 @@ GLOBAL(ftrace_regs_caller_op_ptr)
 	/* regs go into 4th parameter */
 	leaq (%rsp), %rcx
 
-GLOBAL(ftrace_regs_call)
+SYM_CODE_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	call ftrace_stub
 
 	/* Copy flags back to SS, to restore them */
@@ -255,7 +255,7 @@ GLOBAL(ftrace_regs_call)
 	 * The trampoline will add the code to jump
 	 * to the return.
 	 */
-GLOBAL(ftrace_regs_caller_end)
+SYM_CODE_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 
 	jmp ftrace_epilogue
 
@@ -277,7 +277,7 @@ fgraph_trace:
 	jnz ftrace_graph_caller
 #endif
 
-GLOBAL(ftrace_stub)
+SYM_CODE_INNER_LABEL(ftrace_stub, SYM_L_GLOBAL)
 	retq
 
 trace:
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index cd2f97b9623b..614e1d21536d 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -33,7 +33,7 @@ ENTRY(machine_real_restart_asm)
 	movl	%eax, %cr0
 	ljmpl	$__KERNEL32_CS, $pa_machine_real_restart_paging_off
 
-GLOBAL(machine_real_restart_paging_off)
+SYM_CODE_INNER_LABEL(machine_real_restart_paging_off, SYM_L_GLOBAL)
 	xorl	%eax, %eax
 	xorl	%edx, %edx
 	movl	$MSR_EFER, %ecx
-- 
2.16.3

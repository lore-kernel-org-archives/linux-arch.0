From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 7/7] x86_64,entry: Use split-phase syscall_trace_enter for 64-bit syscalls
Date: Tue, 15 Jul 2014 12:32:36 -0700
Message-ID: <5cb038436f48107f7b855ce2431bb6d63d3e9294.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:59387 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933383AbaGOTdT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 15:33:19 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so7899181pad.28
        for <linux-arch@vger.kernel.org>; Tue, 15 Jul 2014 12:33:17 -0700 (PDT)
In-Reply-To: <cover.1405452484.git.luto@amacapital.net>
In-Reply-To: <cover.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, James Morris <james.l.morris@oracle.com>
Cc: Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@plumgrid.com>, Andy Lutomirski <luto@amacapital.net>

On KVM on my box, this reduces the overhead from an always-accept
seccomp filter from ~130ns to ~17ns.  Most of that comes from
avoiding IRET on every syscall when seccomp is enabled.

In extremely approximate hacked-up benchmarking, just bypassing IRET
saves about 80ns, so there's another 43ns of savings here from
simplifying the seccomp path.

The diffstat is also rather nice :)

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/entry_64.S | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 432c190..13e0c1d 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -479,22 +479,6 @@ sysret_signal:
 
 #ifdef CONFIG_AUDITSYSCALL
 	/*
-	 * Fast path for syscall audit without full syscall trace.
-	 * We just call __audit_syscall_entry() directly, and then
-	 * jump back to the normal fast path.
-	 */
-auditsys:
-	movq %r10,%r9			/* 6th arg: 4th syscall arg */
-	movq %rdx,%r8			/* 5th arg: 3rd syscall arg */
-	movq %rsi,%rcx			/* 4th arg: 2nd syscall arg */
-	movq %rdi,%rdx			/* 3rd arg: 1st syscall arg */
-	movq %rax,%rsi			/* 2nd arg: syscall number */
-	movl $AUDIT_ARCH_X86_64,%edi	/* 1st arg: audit arch */
-	call __audit_syscall_entry
-	LOAD_ARGS 0		/* reload call-clobbered registers */
-	jmp system_call_fastpath
-
-	/*
 	 * Return fast path for syscall audit.  Call __audit_syscall_exit()
 	 * directly and then jump back to the fast path with TIF_SYSCALL_AUDIT
 	 * masked off.
@@ -511,17 +495,25 @@ sysret_audit:
 
 	/* Do syscall tracing */
 tracesys:
-#ifdef CONFIG_AUDITSYSCALL
-	testl $(_TIF_WORK_SYSCALL_ENTRY & ~_TIF_SYSCALL_AUDIT),TI_flags+THREAD_INFO(%rsp,RIP-ARGOFFSET)
-	jz auditsys
-#endif
+	leaq -REST_SKIP(%rsp), %rdi
+	movq $AUDIT_ARCH_X86_64, %rsi
+	call syscall_trace_enter_phase1
+	test %rax, %rax
+	jnz tracesys_phase2		/* if needed, run the slow path */
+	LOAD_ARGS 0			/* else restore clobbered regs */
+	jmp system_call_fastpath	/*      and return to the fast path */
+
+tracesys_phase2:
 	SAVE_REST
 	FIXUP_TOP_OF_STACK %rdi
-	movq %rsp,%rdi
-	call syscall_trace_enter
+	movq %rsp, %rdi
+	movq $AUDIT_ARCH_X86_64, %rsi
+	movq %rax,%rdx
+	call syscall_trace_enter_phase2
+
 	/*
 	 * Reload arg registers from stack in case ptrace changed them.
-	 * We don't reload %rax because syscall_trace_enter() returned
+	 * We don't reload %rax because syscall_trace_entry_phase2() returned
 	 * the value it wants us to use in the table lookup.
 	 */
 	LOAD_ARGS ARGOFFSET, 1
@@ -532,7 +524,7 @@ tracesys:
 	andl $__SYSCALL_MASK,%eax
 	cmpl $__NR_syscall_max,%eax
 #endif
-	ja   int_ret_from_sys_call	/* RAX(%rsp) set to -ENOSYS above */
+	ja   int_ret_from_sys_call	/* RAX(%rsp) is already set */
 	movq %r10,%rcx	/* fixup for C */
 	call *sys_call_table(,%rax,8)
 	movq %rax,RAX-ARGOFFSET(%rsp)
-- 
1.9.3

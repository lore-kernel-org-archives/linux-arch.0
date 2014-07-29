Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:37382 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbaG2Dip (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jul 2014 23:38:45 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so11627527pad.21
        for <linux-arch@vger.kernel.org>; Mon, 28 Jul 2014 20:38:45 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v4 1/5] x86,x32,audit: Fix x32's AUDIT_ARCH wrt audit
Date: Mon, 28 Jul 2014 20:38:28 -0700
Message-ID: <ed503c590487ac761b9bf39dac4fe26c64022962.1406604806.git.luto@amacapital.net>
In-Reply-To: <cover.1406604806.git.luto@amacapital.net>
References: <cover.1406604806.git.luto@amacapital.net>
In-Reply-To: <cover.1406604806.git.luto@amacapital.net>
References: <cover.1406604806.git.luto@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com, Frederic Weisbecker <fweisbec@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Message-ID: <20140729033828.CYGNZN5GBJR-jZXgtZof7bw1OIf5AWgwJhyvJLpckIo@z>

is_compat_task() is the wrong check for audit arch; the check should
be is_ia32_task(): x32 syscalls should be AUDIT_ARCH_X86_64, not
AUDIT_ARCH_I386.

CONFIG_AUDITSYSCALL is currently incompatible with x32, so this has
no visible effect.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/ptrace.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 93c182a..39296d2 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1441,15 +1441,6 @@ void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 	force_sig_info(SIGTRAP, &info, tsk);
 }
 
-
-#ifdef CONFIG_X86_32
-# define IS_IA32	1
-#elif defined CONFIG_IA32_EMULATION
-# define IS_IA32	is_compat_task()
-#else
-# define IS_IA32	0
-#endif
-
 /*
  * We must return the syscall number to actually look up in the table.
  * This can be -1L to skip running any syscall at all.
@@ -1487,7 +1478,7 @@ long syscall_trace_enter(struct pt_regs *regs)
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->orig_ax);
 
-	if (IS_IA32)
+	if (is_ia32_task())
 		audit_syscall_entry(AUDIT_ARCH_I386,
 				    regs->orig_ax,
 				    regs->bx, regs->cx,
-- 
1.9.3


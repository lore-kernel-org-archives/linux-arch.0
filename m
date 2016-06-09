Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33269 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbcFIVCa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2016 17:02:30 -0400
Received: by mail-pa0-f52.google.com with SMTP id ec8so16603380pac.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Jun 2016 14:02:30 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 09/14] MIPS/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:01:59 -0700
Message-ID: <1465506124-21866-10-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Ralf Baechle <ralf@linux-mips.org>, "Maciej W. Rozycki" <macro@imgtec.com>, James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
Message-ID: <20160609210159.aFgbR3FzPb6C1VO5RI4KJwh_YQhIqUxYP-XxDh1qwZM@z>

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/ptrace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index c50af846ecf9..6103b24d1bfc 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -888,17 +888,16 @@ long arch_ptrace(struct task_struct *child, long request,
  */
 asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 {
-	long ret = 0;
 	user_exit();
 
 	current_thread_info()->syscall = syscall;
 
-	if (secure_computing(NULL) == -1)
-		return -1;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs))
-		ret = -1;
+		return -1;
+
+	if (secure_computing(NULL) == -1)
+		return -1;
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
-- 
2.7.4


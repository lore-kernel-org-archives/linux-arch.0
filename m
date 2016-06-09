Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34755 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbcFIVCd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2016 17:02:33 -0400
Received: by mail-pf0-f175.google.com with SMTP id 62so16361490pfd.1
        for <linux-arch@vger.kernel.org>; Thu, 09 Jun 2016 14:02:33 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 06/14] x86/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:01:56 -0700
Message-ID: <1465506124-21866-7-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>
Message-ID: <20160609210156.1lAq2LtWAA2Loxp_IwySbzPCogxf1mGagFbynsiVt5U@z>

This moves seccomp after ptrace on x86 to that seccomp can catch changes
made by ptrace. Emulation should skip the rest of processing too.

We can get rid of test_thread_flag because there's no longer any
opportunity for seccomp to mess with ptrace state before invoking
ptrace.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/common.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index df56ca394877..81c0e12d831c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -73,6 +73,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 	struct thread_info *ti = pt_regs_to_thread_info(regs);
 	unsigned long ret = 0;
+	bool emulated = false;
 	u32 work;
 
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
@@ -80,11 +81,19 @@ static long syscall_trace_enter(struct pt_regs *regs)
 
 	work = ACCESS_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
 
+	if (unlikely(work & _TIF_SYSCALL_EMU))
+		emulated = true;
+
+	if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
+	    tracehook_report_syscall_entry(regs))
+		return -1L;
+
+	if (emulated)
+		return -1L;
+
 #ifdef CONFIG_SECCOMP
 	/*
-	 * Do seccomp first -- it should minimize exposure of other
-	 * code, and keeping seccomp fast is probably more valuable
-	 * than the rest of this.
+	 * Do seccomp after ptrace, to catch any tracer changes.
 	 */
 	if (work & _TIF_SECCOMP) {
 		struct seccomp_data sd;
@@ -117,13 +126,6 @@ static long syscall_trace_enter(struct pt_regs *regs)
 	}
 #endif
 
-	if (unlikely(work & _TIF_SYSCALL_EMU))
-		ret = -1L;
-
-	if ((ret || test_thread_flag(TIF_SYSCALL_TRACE)) &&
-	    tracehook_report_syscall_entry(regs))
-		ret = -1L;
-
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->orig_ax);
 
-- 
2.7.4


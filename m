Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33001 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbcFIVCe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2016 17:02:34 -0400
Received: by mail-pf0-f180.google.com with SMTP id y124so16392210pfy.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Jun 2016 14:02:34 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 10/14] parisc/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:02:00 -0700
Message-ID: <1465506124-21866-11-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
Message-ID: <20160609210200.f8HvEvvT2OP2vyoWNTHGw9cnbvduivJEwqsXqTZxjQw@z>

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/kernel/ptrace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 8edc47c0b98e..e02d7b4d2b69 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -311,10 +311,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
-	/* Do the secure computing check first. */
-	if (secure_computing(NULL) == -1)
-		return -1;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs)) {
 		/*
@@ -325,6 +321,11 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 		regs->gr[20] = -1UL;
 		goto out;
 	}
+
+	/* Do the secure computing check after ptrace. */
+	if (secure_computing(NULL) == -1)
+		return -1;
+
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gr[20]);
-- 
2.7.4


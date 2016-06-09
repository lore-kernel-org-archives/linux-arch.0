Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35896 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbcFIVC3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2016 17:02:29 -0400
Received: by mail-pf0-f174.google.com with SMTP id t190so16329904pfb.3
        for <linux-arch@vger.kernel.org>; Thu, 09 Jun 2016 14:02:29 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 07/14] arm/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:01:57 -0700
Message-ID: <1465506124-21866-8-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
Message-ID: <20160609210157.FYPZbUBMSTFtSdWio0bfKS11g9anY1KJiFYqYnAFBQA@z>

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/kernel/ptrace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ad5e90ab165c..dc7b372872ff 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -932,18 +932,19 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 {
 	current_thread_info()->syscall = scno;
 
-	/* Do the secure computing check first; failures should be fast. */
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
+
+	/* Do seccomp after ptrace; syscall may have changed. */
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 	if (secure_computing(NULL) == -1)
 		return -1;
 #else
 	/* XXX: remove this once OABI gets fixed */
-	secure_computing_strict(scno);
+	secure_computing_strict(current_thread_info()->syscall);
 #endif
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
-
+	/* Tracer or seccomp may have changed syscall. */
 	scno = current_thread_info()->syscall;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-- 
2.7.4


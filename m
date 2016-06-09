Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36136 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbcFIVCb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2016 17:02:31 -0400
Received: by mail-pa0-f48.google.com with SMTP id b5so16518667pas.3
        for <linux-arch@vger.kernel.org>; Thu, 09 Jun 2016 14:02:31 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 13/14] tile/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:02:03 -0700
Message-ID: <1465506124-21866-14-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Chris Metcalf <cmetcalf@mellanox.com>, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, x86@kernel.org
Message-ID: <20160609210203.BPhYGwetOlN0MfmqBMsEikQHX8ym97Kag8qGhv6pCPM@z>

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
---
 arch/tile/kernel/ptrace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/tile/kernel/ptrace.c b/arch/tile/kernel/ptrace.c
index 8c6d2f2fefa3..d89b7011667c 100644
--- a/arch/tile/kernel/ptrace.c
+++ b/arch/tile/kernel/ptrace.c
@@ -255,14 +255,15 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 {
 	u32 work = ACCESS_ONCE(current_thread_info()->flags);
 
-	if (secure_computing(NULL) == -1)
+	if ((work & _TIF_SYSCALL_TRACE) &&
+	    tracehook_report_syscall_entry(regs)) {
+		regs->regs[TREG_SYSCALL_NR] = -1;
 		return -1;
-
-	if (work & _TIF_SYSCALL_TRACE) {
-		if (tracehook_report_syscall_entry(regs))
-			regs->regs[TREG_SYSCALL_NR] = -1;
 	}
 
+	if (secure_computing(NULL) == -1)
+		return -1;
+
 	if (work & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_enter(regs, regs->regs[TREG_SYSCALL_NR]);
 
-- 
2.7.4


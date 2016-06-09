Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34764 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbcFIVCb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2016 17:02:31 -0400
Received: by mail-pf0-f169.google.com with SMTP id 62so16361862pfd.1
        for <linux-arch@vger.kernel.org>; Thu, 09 Jun 2016 14:02:31 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 14/14] um/ptrace: run seccomp after ptrace
Date: Thu,  9 Jun 2016 14:02:04 -0700
Message-ID: <1465506124-21866-15-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Andy Lutomirski <luto@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, James Hogan <james.hogan@imgtec.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>, Mark Rutland <mark.rutland@arm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, x86@kernel.org
Message-ID: <20160609210204.ZdmFDgRqxJbnsDo8OHw_X98phKMFf9sFUP8eRBT9Lsg@z>

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
---
 arch/um/kernel/skas/syscall.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 9c5570f0f397..ef4b8f949b51 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -20,12 +20,12 @@ void handle_syscall(struct uml_pt_regs *r)
 	UPT_SYSCALL_NR(r) = PT_SYSCALL_NR(r->gp);
 	PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);
 
-	/* Do the secure computing check first; failures should be fast. */
-	if (secure_computing(NULL) == -1)
+	if (syscall_trace_enter(regs))
 		return;
 
-	if (syscall_trace_enter(regs))
-		goto out;
+	/* Do the seccomp check after ptrace; failures should be fast. */
+	if (secure_computing(NULL) == -1)
+		return;
 
 	/* Update the syscall number after orig_ax has potentially been updated
 	 * with ptrace.
@@ -37,6 +37,5 @@ void handle_syscall(struct uml_pt_regs *r)
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
 
-out:
 	syscall_trace_leave(regs);
 }
-- 
2.7.4


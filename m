From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 04/11] signal/parisc: Document a conflict with SI_USER with SIGFPE
Date: Thu, 11 Jan 2018 18:59:33 -0600
Message-ID: <20180112005940.23279-4-ebiederm@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:35540 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933242AbeALBB2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jan 2018 20:01:28 -0500
In-Reply-To: <87373b6ghs.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org

Setting si_code to 0 results in a userspace seeing an si_code of 0.
This is the same si_code as SI_USER.  Posix and common sense requires
that SI_USER not be a signal specific si_code.  As such this use of 0
for the si_code is a pretty horribly broken ABI.

Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
value of __SI_KILL and now sees a value of SIL_KILL with the result
that uid and pid fields are copied and which might copying the si_addr
field by accident but certainly not by design.  Making this a very
flakey implementation.

Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
appropriate fields will reliably be copied.

This bug is 13 years old and parsic machines are no longer being built
so I don't know if it possible or worth fixing it.  But it is at least
worth documenting this so other architectures don't make the same
mistake.

Possible ABI fixes includee:
  - Send the signal without siginfo
  - Don't generate a signal
  - Possibly assign and use an appropriate si_code
  - Don't handle cases which can't happen

Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Ref: 313c01d3e3fd ("[PATCH] PA-RISC update for 2.6.0")
Histroy Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/parisc/include/uapi/asm/siginfo.h | 7 +++++++
 arch/parisc/kernel/traps.c             | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/uapi/asm/siginfo.h b/arch/parisc/include/uapi/asm/siginfo.h
index 4a1062e05aaf..be40331f757d 100644
--- a/arch/parisc/include/uapi/asm/siginfo.h
+++ b/arch/parisc/include/uapi/asm/siginfo.h
@@ -8,4 +8,11 @@
 
 #include <asm-generic/siginfo.h>
 
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME	0	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
 #endif
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 8453724b8009..c919e6c0a687 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -629,7 +629,7 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 			si.si_signo = SIGFPE;
 			/* Set to zero, and let the userspace app figure it out from
 			   the insn pointed to by si_addr */
-			si.si_code = 0;
+			si.si_code = FPE_FIXME;
 			si.si_addr = (void __user *) regs->iaoq[0];
 			force_sig_info(SIGFPE, &si, current);
 			return;
-- 
2.14.1

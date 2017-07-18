Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:35123 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbdGROQH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jul 2017 10:16:07 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Jul 2017 09:06:47 -0500
Message-ID: <20170718140651.15973-3-ebiederm@xmission.com>
In-Reply-To: <87o9shg7t7.fsf_-_@xmission.com>
References: <87o9shg7t7.fsf_-_@xmission.com>
Subject: [PATCH 3/7] signal/sparc: Document a conflict with SI_USER with SIGFPE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Message-ID: <20170718140647.nTi9SrDWDgM_WnXsVlJu5NHT1EjnysHvCMiFHuUd3gg@z>

Setting si_code to __SI_FAULT results in a userspace seeing
an si_code of 0.  This is the same si_code as SI_USER.  Posix
and common sense requires that SI_USER not be a signal specific
si_code.  As such this use of 0 for the si_code is a pretty
horribly broken ABI.

This was introduced in 2.3.41 so this mess has had a long time for
people to be able to start depending on it.

As this bug has existed for 17 years already I don't know if it is
worth fixing.  It is definitely worth documenting what is going
on so that no one decides to copy this bad decision.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/include/uapi/asm/siginfo.h | 7 +++++++
 arch/sparc/kernel/traps_32.c          | 2 +-
 arch/sparc/kernel/traps_64.c          | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/siginfo.h b/arch/sparc/include/uapi/asm/siginfo.h
index 2d9b79ccaa50..da2126e0c536 100644
--- a/arch/sparc/include/uapi/asm/siginfo.h
+++ b/arch/sparc/include/uapi/asm/siginfo.h
@@ -17,6 +17,13 @@
 #define SI_NOINFO	32767		/* no information in siginfo_t */
 
 /*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME	(__SI_FAULT|0)	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+/*
  * SIGEMT si_codes
  */
 #define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 466d4aed06c7..581cf35ee7e3 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -306,7 +306,7 @@ void do_fpe_trap(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 	info.si_errno = 0;
 	info.si_addr = (void __user *)pc;
 	info.si_trapno = 0;
-	info.si_code = __SI_FAULT;
+	info.si_code = FPE_FIXME;
 	if ((fsr & 0x1c000) == (1 << 14)) {
 		if (fsr & 0x10)
 			info.si_code = FPE_FLTINV;
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 196ee5eb4d48..e882e128faa3 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2258,7 +2258,7 @@ static void do_fpe_common(struct pt_regs *regs)
 		info.si_errno = 0;
 		info.si_addr = (void __user *)regs->tpc;
 		info.si_trapno = 0;
-		info.si_code = __SI_FAULT;
+		info.si_code = FPE_FIXME;
 		if ((fsr & 0x1c000) == (1 << 14)) {
 			if (fsr & 0x10)
 				info.si_code = FPE_FLTINV;
-- 
2.10.1

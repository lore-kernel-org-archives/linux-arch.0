Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:35145 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdF3Mr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2017 08:47:29 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 30 Jun 2017 07:39:02 -0500
Message-ID: <20170630123906.8865-4-ebiederm@xmission.com>
In-Reply-To: <87efu22set.fsf@xmission.com>
References: <87efu22set.fsf@xmission.com>
Subject: [PATCH 4/8] signal/mips: Document a conflict with SI_USER with SIGFPE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Thiemo Seufer <ths@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20170630123902.oe-giMLJSQyalAY7OZrIgqAP-xCW9vkBHtLp2kQuyDU@z>

Setting si_code to __SI_FAULT results in a userspace seeing
an si_code of 0.  This is the same si_code as SI_USER.  Posix
and common sense requires that SI_USER not be a signal specific
si_code.  As such this use of 0 for the si_code is a pretty
horribly broken ABI.

This use of of __SI_FAULT is only a decade old.  Which compared
to the other pieces of kernel code that has made this mistake
is almost yesterday.

This is probably worth fixing but I don't know mips well enough
to know what si_code to would be the proper one to use.

Cc: Thiemo Seufer <ths@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Ref: 948a34cf3988 ("[MIPS] Maintain si_code field properly for FP exceptions")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/mips/include/uapi/asm/siginfo.h | 5 +++++
 arch/mips/kernel/traps.c             | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/siginfo.h b/arch/mips/include/uapi/asm/siginfo.h
index 8069cf766603..0d80df888325 100644
--- a/arch/mips/include/uapi/asm/siginfo.h
+++ b/arch/mips/include/uapi/asm/siginfo.h
@@ -123,4 +123,9 @@ typedef struct siginfo {
 #define SI_TIMER __SI_CODE(__SI_TIMER, -3) /* sent by timer expiration */
 #define SI_MESGQ __SI_CODE(__SI_MESGQ, -4) /* sent by real time mesq state change */
 
+/*
+ * SIGFPE si_codes
+ */
+#define FPE_FIXME	(__SI_FAULT|0)	/* Broken dup of SI_USER */
+
 #endif /* _UAPI_ASM_SIGINFO_H */
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9681b5877140..477dfca99147 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -732,7 +732,7 @@ void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 	else if (fcr31 & FPU_CSR_INE_X)
 		si.si_code = FPE_FLTRES;
 	else
-		si.si_code = __SI_FAULT;
+		si.si_code = FPE_FIXME;
 	force_sig_info(SIGFPE, &si, tsk);
 }
 
-- 
2.10.1

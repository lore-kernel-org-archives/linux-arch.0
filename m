From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 05/11] signal/metag: Document a conflict with SI_USER with SIGFPE
Date: Thu, 11 Jan 2018 18:59:34 -0600
Message-ID: <20180112005940.23279-5-ebiederm@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87373b6ghs.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, James Hogan <james.hogan@imgtec.com>, linux-metag@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Setting si_code to 0 results in a userspace seeing an si_code of 0.
This is the same si_code as SI_USER.  Posix and common sense requires
that SI_USER not be a signal specific si_code.  As such this use of 0
for the si_code is a pretty horribly broken ABI.

Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
value of __SI_KILL and now sees a value of SIL_KILL with the result
hat uid and pid fields are copied and which might copying the si_addr
field by accident but certainly not by design.  Making this a very
flakey implementation.

Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
appropriate fields will reliably be copied.

Possible ABI fixes includee:
  - Send the signal without siginfo
  - Don't generate a signal
  - Possibly assign and use an appropriate si_code
  - Don't handle cases which can't happen

Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-metag@vger.kernel.org
Ref: ac919f0883e5 ("metag: Traps")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/metag/include/uapi/asm/siginfo.h | 7 +++++++
 arch/metag/kernel/traps.c             | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/metag/include/uapi/asm/siginfo.h b/arch/metag/include/uapi/asm/siginfo.h
index b54ef7186ca3..9a3f6cde9487 100644
--- a/arch/metag/include/uapi/asm/siginfo.h
+++ b/arch/metag/include/uapi/asm/siginfo.h
@@ -6,4 +6,11 @@
 
 #include <asm-generic/siginfo.h>
 
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME      0       /* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
 #endif
diff --git a/arch/metag/kernel/traps.c b/arch/metag/kernel/traps.c
index 444851e510d5..3b62b1b0c0b5 100644
--- a/arch/metag/kernel/traps.c
+++ b/arch/metag/kernel/traps.c
@@ -735,7 +735,7 @@ TBIRES fpe_handler(TBIRES State, int SigNum, int Triggers, int Inst, PTBI pTBI)
 	else if (error_state & TXSTAT_FPE_INEXACT_BIT)
 		info.si_code = FPE_FLTRES;
 	else
-		info.si_code = 0;
+		info.si_code = FPE_FIXME;
 	info.si_errno = 0;
 	info.si_addr = (__force void __user *)regs->ctx.CurrPC;
 	force_sig_info(SIGFPE, &info, current);
-- 
2.14.1

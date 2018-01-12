Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:52791 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933728AbeALBBj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jan 2018 20:01:39 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu, 11 Jan 2018 18:59:37 -0600
Message-ID: <20180112005940.23279-8-ebiederm@xmission.com>
In-Reply-To: <87373b6ghs.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
Subject: [PATCH 08/11] signal/arm: Document conflicts with SI_USER and SIGFPE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Russell King <rmk@flint.arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Message-ID: <20180112005937.S_0KMtmtRgAldP93Zz7FLloD6vBKt-8Sfs4onT_PHDQ@z>

Setting si_code to 0 results in a userspace seeing an si_code of 0.
This is the same si_code as SI_USER.  Posix and common sense requires
that SI_USER not be a signal specific si_code.  As such this use of 0
for the si_code is a pretty horribly broken ABI.

Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
value of __SI_KILL and now sees a value of SIL_KILL with the result
that uid and pid fields are copied and which might copying the si_addr
field by accident but certainly not by design.  Making this a very
flakey implementation.

Utilizing FPE_FIXME, siginfo_layout will now return SIL_FAULT and the
appropriate fields will be reliably copied.

Possible ABI fixes includee:
- Send the signal without siginfo
- Don't generate a signal
- Possibly assign and use an appropriate si_code
- Don't handle cases which can't happen

Cc: Russell King <rmk@flint.arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Ref: 451436b7bbb2 ("[ARM] Add support code for ARM hardware vector floating point")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/include/uapi/asm/siginfo.h | 13 +++++++++++++
 arch/arm/vfp/vfpmodule.c            |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/uapi/asm/siginfo.h

diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/asm/siginfo.h
new file mode 100644
index 000000000000..d0513880be21
--- /dev/null
+++ b/arch/arm/include/uapi/asm/siginfo.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_SIGINFO_H
+#define __ASM_SIGINFO_H
+
+#include <asm-generic/siginfo.h>
+
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME	0	/* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+#endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index a71a48e71fff..03c6a3c72f9c 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -257,7 +257,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_
 
 	if (exceptions == VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		vfp_raise_sigfpe(0, regs);
+		vfp_raise_sigfpe(FPE_FIXME, regs);
 		return;
 	}
 
-- 
2.14.1

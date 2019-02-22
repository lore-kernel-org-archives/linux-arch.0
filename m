Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfBVM00 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:26:26 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 17/23] arm64: compat: Get sigreturn trampolines from vDSO
Date: Fri, 22 Feb 2019 12:24:24 +0000
Message-ID: <20190222122430.21180-18-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222122424.8A5pnzkbXz4vAlm0SVPPRF_UPwjgoUKbrDOP6_zQ4bU@z>

When the compat vDSO is enabled, the sigreturn trampolines are not
anymore available through [sigpage] but through [vdso].

Add the relevant code the enable the feature.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vdso.h |  3 +++
 arch/arm64/kernel/signal32.c  | 29 +++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 839ce0031bd5..9b197e5ea759 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -28,6 +28,9 @@
 #ifndef __ASSEMBLY__
 
 #include <generated/vdso-offsets.h>
+#ifdef CONFIG_COMPAT_VDSO
+#include <generated/vdso32-offsets.h>
+#endif
 
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index d916fd7f6409..b8b53213cde6 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -29,6 +29,7 @@
 #include <asm/traps.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
+#include <asm/vdso.h>
 
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
@@ -333,7 +334,6 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	compat_ulong_t retcode;
 	compat_ulong_t spsr = regs->pstate & ~(PSR_f | PSR_AA32_E_BIT);
 	int thumb;
-	void *sigreturn_base;
 
 	/* Check if the handler is written for ARM or Thumb */
 	thumb = handler & 1;
@@ -353,14 +353,39 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+#ifdef CONFIG_COMPAT_VDSO
+		void *vdso_base = current->mm->context.vdso;
+		void *vdso_trampoline;
+
+		if (ka->sa.sa_flags & SA_SIGINFO) {
+			if (thumb) {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_rt_sigreturn_thumb);
+			} else {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_rt_sigreturn_arm);
+			}
+		} else {
+			if (thumb) {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_sigreturn_thumb);
+			} else {
+				vdso_trampoline = VDSO_SYMBOL(vdso_base,
+							compat_sigreturn_arm);
+			}
+		}
+
+		retcode = ptr_to_compat(vdso_trampoline) + thumb;
+#else
 		unsigned int idx = thumb << 1;
-		sigreturn_base = current->mm->context.vdso;
+		void *sigreturn_base = current->mm->context.vdso;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
 			idx += 3;
 
 		retcode = ptr_to_compat(sigreturn_base) +
 			  (idx << 2) + thumb;
+#endif
 	}
 
 	regs->regs[0]	= usig;
-- 
2.20.1

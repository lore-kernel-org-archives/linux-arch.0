From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 01/11] prctl: Support movement of arch prctls out of common code
Date: Mon, 14 May 2018 18:14:17 +0100
Message-ID: <1526318067-4964-2-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, James Hogan <jhogan@kernel.org>, Kees Cook <keescook@chromium.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, x86@kernel.org, Yoshinori Sato <ysato@users.sourceforge.>
List-Id: linux-arch.vger.kernel.org

The core framework for the prctl() syscall is unloved and looking
rather crusty these days.  It also relies on defining ancillary
boilerplate macros for each prctl() in order to control conditional
compilation of the different prctl calls.  We have better ways to
do this now, using Kconfig.

This patch defines a new arch hook arch_syscall().  Architectures
that implemement arch-specific syscalls can now select
HAVE_ARCH_SYSCALL in their Kconfig and define this function
appropriately.

The core prctl() implementation now matches option against the list
of common or legacy prctls, deferring to prctl_arch() if an
unrecognised option is encountered.

(arch_prctl() would have been a nicer name, but it conflicts with the
pre-existing syscall of the same name on x86, particularly in the um
code.)

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: James Hogan <jhogan@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: x86@kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/Kconfig                     |  3 +++
 include/linux/prctl.h            | 19 +++++++++++++++++++
 include/uapi/linux/prctl.h       |  6 +++---
 kernel/sys.c                     |  2 +-
 tools/include/uapi/linux/prctl.h |  6 +++---
 5 files changed, 29 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/prctl.h

diff --git a/arch/Kconfig b/arch/Kconfig
index 8e0d665..b34b3e8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -969,4 +969,7 @@ config REFCOUNT_FULL
 	  against various use-after-free conditions that can be used in
 	  security flaw exploits.
 
+config HAVE_PRCTL_ARCH
+	bool
+
 source "kernel/gcov/Kconfig"
diff --git a/include/linux/prctl.h b/include/linux/prctl.h
new file mode 100644
index 0000000..5ce3713
--- /dev/null
+++ b/include/linux/prctl.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PRCTL_H
+#define _LINUX_PRCTL_H
+
+#include <linux/errno.h>
+#include <uapi/linux/prctl.h>
+
+#ifdef CONFIG_HAVE_PRCTL_ARCH
+extern int prctl_arch(int option, unsigned long arg2,
+	unsigned long arg3, unsigned long arg4, unsigned long arg5);
+#else
+static inline int prctl_arch(int option, unsigned long arg2,
+	unsigned long arg3, unsigned long arg4, unsigned long arg5)
+{
+	return -EINVAL;
+}
+#endif
+
+#endif /* ! _LINUX_PRCTL_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index af5f8c2..c911ff0 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_PRCTL_H
-#define _LINUX_PRCTL_H
+#ifndef _UAPI_LINUX_PRCTL_H
+#define _UAPI_LINUX_PRCTL_H
 
 #include <linux/types.h>
 
@@ -207,4 +207,4 @@ struct prctl_mm_map {
 # define PR_SVE_VL_LEN_MASK		0xffff
 # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
 
-#endif /* _LINUX_PRCTL_H */
+#endif /* _UAPI_LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index ad69218..5077f1e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2451,7 +2451,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = SVE_GET_VL();
 		break;
 	default:
-		error = -EINVAL;
+		error = prctl_arch(option, arg2, arg3, arg4, arg5);
 		break;
 	}
 	return error;
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index af5f8c2..c911ff0 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _LINUX_PRCTL_H
-#define _LINUX_PRCTL_H
+#ifndef _UAPI_LINUX_PRCTL_H
+#define _UAPI_LINUX_PRCTL_H
 
 #include <linux/types.h>
 
@@ -207,4 +207,4 @@ struct prctl_mm_map {
 # define PR_SVE_VL_LEN_MASK		0xffff
 # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
 
-#endif /* _LINUX_PRCTL_H */
+#endif /* _UAPI_LINUX_PRCTL_H */
-- 
2.1.4

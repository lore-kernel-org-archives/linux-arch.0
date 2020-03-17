From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v4 12/26] linux/time64.h: Extract common header for vDSO
Date: Tue, 17 Mar 2020 12:22:06 +0000
Message-ID: <20200317122220.30393-13-vincenzo.frascino@arm.com>
References: <20200317122220.30393-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:36832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgCQMXa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 08:23:30 -0400
In-Reply-To: <20200317122220.30393-1-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, linux-mips@vger.kernel.org, x86@kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Split time64.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/time64.h | 10 +---------
 include/vdso/time64.h  | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 9 deletions(-)
 create mode 100644 include/vdso/time64.h

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 19125489ae94..c9dcb3e5781f 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -3,6 +3,7 @@
 #define _LINUX_TIME64_H
 
 #include <linux/math64.h>
+#include <vdso/time64.h>
 
 typedef __s64 time64_t;
 typedef __u64 timeu64_t;
@@ -19,15 +20,6 @@ struct itimerspec64 {
 	struct timespec64 it_value;
 };
 
-/* Parameters used to convert the timespec values: */
-#define MSEC_PER_SEC	1000L
-#define USEC_PER_MSEC	1000L
-#define NSEC_PER_USEC	1000L
-#define NSEC_PER_MSEC	1000000L
-#define USEC_PER_SEC	1000000L
-#define NSEC_PER_SEC	1000000000L
-#define FSEC_PER_SEC	1000000000000000LL
-
 /* Located here for timespec[64]_valid_strict */
 #define TIME64_MAX			((s64)~((u64)1 << 63))
 #define TIME64_MIN			(-TIME64_MAX - 1)
diff --git a/include/vdso/time64.h b/include/vdso/time64.h
new file mode 100644
index 000000000000..9d43c3f5e89d
--- /dev/null
+++ b/include/vdso/time64.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_TIME64_H
+#define __VDSO_TIME64_H
+
+/* Parameters used to convert the timespec values: */
+#define MSEC_PER_SEC	1000L
+#define USEC_PER_MSEC	1000L
+#define NSEC_PER_USEC	1000L
+#define NSEC_PER_MSEC	1000000L
+#define USEC_PER_SEC	1000000L
+#define NSEC_PER_SEC	1000000000L
+#define FSEC_PER_SEC	1000000000000000LL
+
+#endif /* __VDSO_TIME64_H */
-- 
2.25.1

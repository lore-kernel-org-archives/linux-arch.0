Return-Path: <SRS0=WjNt=46=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:58542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbgCMPoe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Mar 2020 11:44:34 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 09/26] linux/math64.h: Extract common header for vDSO
Date: Fri, 13 Mar 2020 15:43:28 +0000
Message-ID: <20200313154345.56760-10-vincenzo.frascino@arm.com>
In-Reply-To: <20200313154345.56760-1-vincenzo.frascino@arm.com>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>, Marc Zyngier <maz@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
Message-ID: <20200313154328.0hKdX4x_KmIVnOTSnlNrv6Rg5LX9bIwvuPcGvSUOX44@z>

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Split math64.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/math64.h | 20 +-------------------
 include/vdso/math64.h  | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 19 deletions(-)
 create mode 100644 include/vdso/math64.h

diff --git a/include/linux/math64.h b/include/linux/math64.h
index 65bef21cdddb..11a267413e8e 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -3,6 +3,7 @@
 #define _LINUX_MATH64_H
 
 #include <linux/types.h>
+#include <vdso/math64.h>
 #include <asm/div64.h>
 
 #if BITS_PER_LONG == 64
@@ -142,25 +143,6 @@ static inline s64 div_s64(s64 dividend, s32 divisor)
 
 u32 iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder);
 
-static __always_inline u32
-__iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
-{
-	u32 ret = 0;
-
-	while (dividend >= divisor) {
-		/* The following asm() prevents the compiler from
-		   optimising this loop into a modulo operation.  */
-		asm("" : "+rm"(dividend));
-
-		dividend -= divisor;
-		ret++;
-	}
-
-	*remainder = dividend;
-
-	return ret;
-}
-
 #ifndef mul_u32_u32
 /*
  * Many a GCC version messes this up and generates a 64x64 mult :-(
diff --git a/include/vdso/math64.h b/include/vdso/math64.h
new file mode 100644
index 000000000000..7da703ee5561
--- /dev/null
+++ b/include/vdso/math64.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_MATH64_H
+#define __VDSO_MATH64_H
+
+static __always_inline u32
+__iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
+{
+	u32 ret = 0;
+
+	while (dividend >= divisor) {
+		/* The following asm() prevents the compiler from
+		   optimising this loop into a modulo operation.  */
+		asm("" : "+rm"(dividend));
+
+		dividend -= divisor;
+		ret++;
+	}
+
+	*remainder = dividend;
+
+	return ret;
+}
+
+#endif /* __VDSO_MATH64_H */
-- 
2.25.1

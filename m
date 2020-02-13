From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 02/19] linux/bits.h: Extract common header for vDSO
Date: Thu, 13 Feb 2020 16:15:57 +0000
Message-ID: <20200213161614.23246-3-vincenzo.frascino@arm.com>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <20200213161614.23246-1-vincenzo.frascino@arm.com>
Sender: linux-mips-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, ndesaulniers@google.com, avagin@openvz.org
List-Id: linux-arch.vger.kernel.org

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Split bits.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/common/bits.h | 9 +++++++++
 include/linux/bits.h  | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)
 create mode 100644 include/common/bits.h

diff --git a/include/common/bits.h b/include/common/bits.h
new file mode 100644
index 000000000000..6da493992e52
--- /dev/null
+++ b/include/common/bits.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __COMMON_BITS_H
+#define __COMMON_BITS_H
+
+#include <common/const.h>
+
+#define BIT(nr)			(UL(1) << (nr))
+
+#endif	/* __COMMON_BITS_H */
diff --git a/include/linux/bits.h b/include/linux/bits.h
index 669d69441a62..aeb76fede77a 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -3,9 +3,9 @@
 #define __LINUX_BITS_H
 
 #include <linux/const.h>
+#include <common/bits.h>
 #include <asm/bitsperlong.h>
 
-#define BIT(nr)			(UL(1) << (nr))
 #define BIT_ULL(nr)		(ULL(1) << (nr))
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-- 
2.25.0

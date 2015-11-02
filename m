From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 4/5] __div64_32(): make it overridable at compile time
Date: Mon, 02 Nov 2015 17:33:29 -0500
Message-ID: <1446503610-6942-5-git-send-email-nicolas.pitre@linaro.org>
References: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>
Cc: Arnd Bergmann <arnd@arndb.de>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Some architectures may want to override the default implementation
at compile time to do things inline.  For example, ARM uses a
non-standard calling convention for better efficiency in this case.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 include/asm-generic/div64.h | 2 ++
 lib/div64.c                 | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index 34722c5a80..6daad94055 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -204,7 +204,9 @@ static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
 }
 #endif
 
+#ifndef __div64_32
 extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
+#endif
 
 /* The unnecessary pointer compare is there
  * to check for type safety (n must be 64bit)
diff --git a/lib/div64.c b/lib/div64.c
index 19ea7ed4b9..69df4f6d52 100644
--- a/lib/div64.c
+++ b/lib/div64.c
@@ -13,7 +13,8 @@
  *
  * Code generated for this function might be very inefficient
  * for some CPUs. __div64_32() can be overridden by linking arch-specific
- * assembly versions such as arch/ppc/lib/div64.S and arch/sh/lib/div64.S.
+ * assembly versions such as arch/ppc/lib/div64.S and arch/sh/lib/div64.S
+ * or by defining a preprocessor macro in arch/include/asm/div64.h.
  */
 
 #include <linux/export.h>
@@ -23,6 +24,7 @@
 /* Not needed on 64bit architectures */
 #if BITS_PER_LONG == 32
 
+#ifndef __div64_32
 uint32_t __attribute__((weak)) __div64_32(uint64_t *n, uint32_t base)
 {
 	uint64_t rem = *n;
@@ -55,8 +57,8 @@ uint32_t __attribute__((weak)) __div64_32(uint64_t *n, uint32_t base)
 	*n = res;
 	return rem;
 }
-
 EXPORT_SYMBOL(__div64_32);
+#endif
 
 #ifndef div_s64_rem
 s64 div_s64_rem(s64 dividend, s32 divisor, s32 *remainder)
-- 
2.4.3

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 3/5] __div64_const32(): abstract out the actual 128-bit cross
 product code
Date: Mon, 02 Nov 2015 17:33:28 -0500
Message-ID: <1446503610-6942-4-git-send-email-nicolas.pitre@linaro.org>
References: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>
Cc: Arnd Bergmann <arnd@arndb.de>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The default C implementation for the 128-bit cross product is abstracted
into the __arch_xprod_64() macro that can be overridden to let
architectures provide their own assembly optimized implementation.

There are many advantages to an assembly version for this operation.
Carry bit handling becomes trivial, and 32-bit shifts may be achieved
simply by inverting register pairs on some architectures.  This has the
potential to be quite faster and use much fewer instructions.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 include/asm-generic/div64.h | 81 ++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index c3612873e4..34722c5a80 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -73,7 +73,7 @@
 	 * do the trick here).						\
 	 */								\
 	uint64_t ___res, ___x, ___t, ___m, ___n = (n);			\
-	uint32_t ___p, ___bias, ___m_lo, ___m_hi, ___n_lo, ___n_hi;	\
+	uint32_t ___p, ___bias;						\
 									\
 	/* determine number of bits to represent b */			\
 	___p = 1 << __div64_fls(___b);					\
@@ -148,41 +148,62 @@
 	 * 2) whether or not there might be an overflow in the cross	\
 	 *    product determined by (___m & ((1 << 63) | (1 << 31))).	\
 	 *								\
-	 * Select the best way to do (m_bias + m * n) / (p << 64).	\
+	 * Select the best way to do (m_bias + m * n) / (1 << 64).	\
 	 * From now on there will be actual runtime code generated.	\
 	 */								\
-									\
-	___m_lo = ___m;							\
-	___m_hi = ___m >> 32;						\
-	___n_lo = ___n;							\
-	___n_hi = ___n >> 32;						\
-									\
-	if (!___bias) {							\
-		___res = ((uint64_t)___m_lo * ___n_lo) >> 32;		\
-	} else if (!(___m & ((1ULL << 63) | (1ULL << 31)))) {		\
-		___res = (___m + (uint64_t)___m_lo * ___n_lo) >> 32;	\
-	} else {							\
-		___res = ___m + (uint64_t)___m_lo * ___n_lo;		\
-		___t = (___res < ___m) ? (1ULL << 32) : 0;		\
-		___res = (___res >> 32) + ___t;				\
-	}								\
-									\
-	if (!(___m & ((1ULL << 63) | (1ULL << 31)))) {			\
-		___res += (uint64_t)___m_lo * ___n_hi;			\
-		___res += (uint64_t)___m_hi * ___n_lo;			\
-		___res >>= 32;						\
-	} else {							\
-		___t = ___res += (uint64_t)___m_lo * ___n_hi;		\
-		___res += (uint64_t)___m_hi * ___n_lo;			\
-		___t = (___res < ___t) ? (1ULL << 32) : 0;		\
-		___res = (___res >> 32) + ___t;				\
-	}								\
-									\
-	___res += (uint64_t)___m_hi * ___n_hi;				\
+	___res = __arch_xprod_64(___m, ___n, ___bias);			\
 									\
 	___res /= ___p;							\
 })
 
+#ifndef __arch_xprod_64
+/*
+ * Default C implementation for __arch_xprod_64()
+ *
+ * Prototype: uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
+ * Semantic:  retval = ((bias ? m : 0) + m * n) >> 64
+ *
+ * The product is a 128-bit value, scaled down to 64 bits.
+ * Assuming constant propagation to optimize away unused conditional code.
+ * Architectures may provide their own optimized assembly implementation.
+ */
+static inline uint64_t __arch_xprod_64(const uint64_t m, uint64_t n, bool bias)
+{
+	uint32_t m_lo = m;
+	uint32_t m_hi = m >> 32;
+	uint32_t n_lo = n;
+	uint32_t n_hi = n >> 32;
+	uint64_t res, tmp;
+
+	if (!bias) {
+		res = ((uint64_t)m_lo * n_lo) >> 32;
+	} else if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
+		/* there can't be any overflow here */
+		res = (m + (uint64_t)m_lo * n_lo) >> 32;
+	} else {
+		res = m + (uint64_t)m_lo * n_lo;
+		tmp = (res < m) ? (1ULL << 32) : 0;
+		res = (res >> 32) + tmp;
+	}
+
+	if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
+		/* there can't be any overflow here */
+		res += (uint64_t)m_lo * n_hi;
+		res += (uint64_t)m_hi * n_lo;
+		res >>= 32;
+	} else {
+		tmp = res += (uint64_t)m_lo * n_hi;
+		res += (uint64_t)m_hi * n_lo;
+		tmp = (res < tmp) ? (1ULL << 32) : 0;
+		res = (res >> 32) + tmp;
+	}
+
+	res += (uint64_t)m_hi * n_hi;
+
+	return res;
+}
+#endif
+
 extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 
 /* The unnecessary pointer compare is there
-- 
2.4.3

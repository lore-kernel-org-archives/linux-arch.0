From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 2/5] do_div(): generic optimization for constant divisor on
 32-bit machines
Date: Mon, 02 Nov 2015 17:33:27 -0500
Message-ID: <1446503610-6942-3-git-send-email-nicolas.pitre@linaro.org>
References: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:30573 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbbKBWsi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Nov 2015 17:48:38 -0500
In-reply-to: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>
Cc: Arnd Bergmann <arnd@arndb.de>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

64-by-32-bit divisions are prominent in the kernel, even on 32-bit
machines.  Luckily, many of them use a constant divisor that allows
for a much faster multiplication by the divisor's reciprocal.

The compiler already performs this optimization when compiling a 32-by-32
division with a constant divisor. Unfortunately, on 32-bit machines, gcc
does not optimize 64-by-32 divisions in that case, except for constant
divisors that happen to be a power of 2.

Let's avoid the slow path whenever the divisor is constant by manually
computing the reciprocal ourselves and performing the multiplication
inline.  This improves performance of 64-by-32 divisions by about two
orders of magnitude in most cases.

The algorithm used here comes from the existing ARM code.

The __div64_const32_is_OK macro can be predefined by architectures to
disable this optimization in some cases. For example, some ancient gcc
version on ARM would crash with an ICE when fed this code.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 include/asm-generic/div64.h | 159 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/include/asm-generic/div64.h b/include/asm-generic/div64.h
index 47aa1e2134..c3612873e4 100644
--- a/include/asm-generic/div64.h
+++ b/include/asm-generic/div64.h
@@ -4,6 +4,9 @@
  * Copyright (C) 2003 Bernardo Innocenti <bernie@develer.com>
  * Based on former asm-ppc/div64.h and asm-m68knommu/div64.h
  *
+ * Optimization for constant divisors on 32-bit machines:
+ * Copyright (C) 2006-2015 Nicolas Pitre
+ *
  * The semantics of do_div() are:
  *
  * uint32_t do_div(uint64_t *n, uint32_t base)
@@ -32,6 +35,154 @@
 
 #elif BITS_PER_LONG == 32
 
+/* macroized fls implementation to ensure proper constant propagation */
+#define __div64_fls(bits)						\
+({								\
+	unsigned int __left = (bits), __nr = 0;			\
+	if (__left & 0xffff0000) __nr += 16, __left >>= 16;	\
+	if (__left & 0x0000ff00) __nr +=  8, __left >>=  8;	\
+	if (__left & 0x000000f0) __nr +=  4, __left >>=  4;	\
+	if (__left & 0x0000000c) __nr +=  2, __left >>=  2;	\
+	if (__left & 0x00000002) __nr +=  1;			\
+	__nr;							\
+})
+
+/*
+ * If the divisor happens to be constant, we determine the appropriate
+ * inverse at compile time to turn the division into a few inline
+ * multiplications which ought to be much faster. And yet only if compiling
+ * with a sufficiently recent gcc version to perform proper 64-bit constant
+ * propagation.
+ *
+ * (It is unfortunate that gcc doesn't perform all this internally.)
+ */
+
+#ifndef __div64_const32_is_OK
+#define __div64_const32_is_OK (__GNUC__ >= 4)
+#endif
+
+#define __div64_const32(n, ___b)					\
+({									\
+	/*								\
+	 * Multiplication by reciprocal of b: n / b = n * (p / b) / p	\
+	 *								\
+	 * We rely on the fact that most of this code gets optimized	\
+	 * away at compile time due to constant propagation and only	\
+	 * a few multiplication instructions should remain.		\
+	 * Hence this monstrous macro (static inline doesn't always	\
+	 * do the trick here).						\
+	 */								\
+	uint64_t ___res, ___x, ___t, ___m, ___n = (n);			\
+	uint32_t ___p, ___bias, ___m_lo, ___m_hi, ___n_lo, ___n_hi;	\
+									\
+	/* determine number of bits to represent b */			\
+	___p = 1 << __div64_fls(___b);					\
+									\
+	/* compute m = ((p << 64) + b - 1) / b */			\
+	___m = (~0ULL / ___b) * ___p;					\
+	___m += (((~0ULL % ___b + 1) * ___p) + ___b - 1) / ___b;	\
+									\
+	/* one less than the dividend with highest result */		\
+	___x = ~0ULL / ___b * ___b - 1;					\
+									\
+	/* test our ___m with res = m * x / (p << 64) */		\
+	___res = ((___m & 0xffffffff) * (___x & 0xffffffff)) >> 32;	\
+	___t = ___res += (___m & 0xffffffff) * (___x >> 32);		\
+	___res += (___x & 0xffffffff) * (___m >> 32);			\
+	___t = (___res < ___t) ? (1ULL << 32) : 0;			\
+	___res = (___res >> 32) + ___t;					\
+	___res += (___m >> 32) * (___x >> 32);				\
+	___res /= ___p;							\
+									\
+	/* Now sanitize and optimize what we've got. */			\
+	if (~0ULL % (___b / (___b & -___b)) == 0) {			\
+		/* special case, can be simplified to ... */		\
+		___n /= (___b & -___b);					\
+		___m = ~0ULL / (___b / (___b & -___b));			\
+		___p = 1;						\
+		___bias = 1;						\
+	} else if (___res != ___x / ___b) {				\
+		/*							\
+		 * We can't get away without a bias to compensate	\
+		 * for bit truncation errors.  To avoid it we'd need an	\
+		 * additional bit to represent m which would overflow	\
+		 * a 64-bit variable.					\
+		 *							\
+		 * Instead we do m = p / b and n / b = (n * m + m) / p.	\
+		 */							\
+		___bias = 1;						\
+		/* Compute m = (p << 64) / b */				\
+		___m = (~0ULL / ___b) * ___p;				\
+		___m += ((~0ULL % ___b + 1) * ___p) / ___b;		\
+	} else {							\
+		/*							\
+		 * Reduce m / p, and try to clear bit 31 of m when	\
+		 * possible, otherwise that'll need extra overflow	\
+		 * handling later.					\
+		 */							\
+		uint32_t ___bits = -(___m & -___m);			\
+		___bits |= ___m >> 32;					\
+		___bits = (~___bits) << 1;				\
+		/*							\
+		 * If ___bits == 0 then setting bit 31 is  unavoidable.	\
+		 * Simply apply the maximum possible reduction in that	\
+		 * case. Otherwise the MSB of ___bits indicates the	\
+		 * best reduction we should apply.			\
+		 */							\
+		if (!___bits) {						\
+			___p /= (___m & -___m);				\
+			___m /= (___m & -___m);				\
+		} else {						\
+			___p >>= __div64_fls(___bits);			\
+			___m >>= __div64_fls(___bits);			\
+		}							\
+		/* No bias needed. */					\
+		___bias = 0;						\
+	}								\
+									\
+	/*								\
+	 * Now we have a combination of 2 conditions:			\
+	 *								\
+	 * 1) whether or not we need to apply a bias, and		\
+	 *								\
+	 * 2) whether or not there might be an overflow in the cross	\
+	 *    product determined by (___m & ((1 << 63) | (1 << 31))).	\
+	 *								\
+	 * Select the best way to do (m_bias + m * n) / (p << 64).	\
+	 * From now on there will be actual runtime code generated.	\
+	 */								\
+									\
+	___m_lo = ___m;							\
+	___m_hi = ___m >> 32;						\
+	___n_lo = ___n;							\
+	___n_hi = ___n >> 32;						\
+									\
+	if (!___bias) {							\
+		___res = ((uint64_t)___m_lo * ___n_lo) >> 32;		\
+	} else if (!(___m & ((1ULL << 63) | (1ULL << 31)))) {		\
+		___res = (___m + (uint64_t)___m_lo * ___n_lo) >> 32;	\
+	} else {							\
+		___res = ___m + (uint64_t)___m_lo * ___n_lo;		\
+		___t = (___res < ___m) ? (1ULL << 32) : 0;		\
+		___res = (___res >> 32) + ___t;				\
+	}								\
+									\
+	if (!(___m & ((1ULL << 63) | (1ULL << 31)))) {			\
+		___res += (uint64_t)___m_lo * ___n_hi;			\
+		___res += (uint64_t)___m_hi * ___n_lo;			\
+		___res >>= 32;						\
+	} else {							\
+		___t = ___res += (uint64_t)___m_lo * ___n_hi;		\
+		___res += (uint64_t)___m_hi * ___n_lo;			\
+		___t = (___res < ___t) ? (1ULL << 32) : 0;		\
+		___res = (___res >> 32) + ___t;				\
+	}								\
+									\
+	___res += (uint64_t)___m_hi * ___n_hi;				\
+									\
+	___res /= ___p;							\
+})
+
 extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 
 /* The unnecessary pointer compare is there
@@ -46,6 +197,14 @@ extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 		/* constant power of 2: gcc is fine */	\
 		__rem = (n) & (__base - 1);		\
 		(n) /= __base;				\
+	} else if (__div64_const32_is_OK &&		\
+		   __builtin_constant_p(__base) &&	\
+		   __base != 0) {			\
+		uint32_t __res_lo, __n_lo = (n);	\
+		(n) = __div64_const32(n, __base);	\
+		/* the remainder can be computed with 32-bit regs */ \
+		__res_lo = (n);				\
+		__rem = __n_lo - __res_lo * __base;	\
 	} else if (likely(((n) >> 32) == 0)) {		\
 		__rem = (uint32_t)(n) % __base;		\
 		(n) = (uint32_t)(n) / __base;		\
-- 
2.4.3

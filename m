Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55510 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751078AbeACWil (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jan 2018 17:38:41 -0500
From: Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 3/4] arm64: implement nospec_{load,ptr}()
Date: Wed,  3 Jan 2018 22:38:26 +0000
Message-ID: <20180103223827.39601-4-mark.rutland@arm.com>
In-Reply-To: <20180103223827.39601-1-mark.rutland@arm.com>
References: <20180103223827.39601-1-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20180103223826.OB4O1aY3pYehEI9lx7a05UH6loJZq-0noZRpEJqS81E@z>

This patch implements nospec_load() and nospec_ptr() for arm64,
following the recommended architectural sequence.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/barrier.h | 61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 77651c49ef44..5d17919e2688 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -40,6 +40,67 @@
 #define dma_rmb()	dmb(oshld)
 #define dma_wmb()	dmb(oshst)
 
+#define __load_no_speculate_n(ptr, lo, hi, failval, cmpptr, w, sz)	\
+({									\
+	typeof(*ptr)	__nln_val;					\
+	typeof(*ptr)	__failval = 					\
+		(typeof(*ptr))(unsigned long)(failval);			\
+									\
+	asm volatile (							\
+	"	cmp	%[c], %[l]\n"					\
+	"	ccmp	%[c], %[h], 2, cs\n"				\
+	"	b.cs	1f\n"						\
+	"	ldr" #sz " %" #w "[v], %[p]\n"				\
+	"1:	csel	%" #w "[v], %" #w "[v], %" #w "[f], cc\n"	\
+	"	hint	#0x14 // CSDB\n"				\
+	: [v] "=&r" (__nln_val)						\
+	: [p] "m" (*(ptr)), [l] "r" (lo), [h] "r" (hi),			\
+	  [f] "rZ" (__failval), [c] "r" (cmpptr)			\
+	: "cc");							\
+									\
+	__nln_val;							\
+})
+
+#define __load_no_speculate(ptr, lo, hi, failval, cmpptr)		\
+({									\
+	typeof(*(ptr)) __nl_val;					\
+									\
+	switch (sizeof(__nl_val)) {					\
+	case 1:								\
+		__nl_val = __load_no_speculate_n(ptr, lo, hi, failval,	\
+						 cmpptr, w, b);		\
+		break;							\
+	case 2:								\
+		__nl_val = __load_no_speculate_n(ptr, lo, hi, failval,	\
+						 cmpptr, w, h);		\
+		break;							\
+	case 4:								\
+		__nl_val = __load_no_speculate_n(ptr, lo, hi, failval,	\
+						 cmpptr, w, );		\
+		break;							\
+	case 8:								\
+		__nl_val = __load_no_speculate_n(ptr, lo, hi, failval,	\
+						 cmpptr, x, );		\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+									\
+	__nl_val;							\
+})
+
+#define nospec_load(ptr, lo, hi)					\
+({									\
+	typeof(ptr) __nl_ptr = (ptr);					\
+	__load_no_speculate(__nl_ptr, lo, hi, 0, __nl_ptr);		\
+})
+
+#define nospec_ptr(ptr, lo, hi)						\
+({									\
+	typeof(ptr) __np_ptr = (ptr);					\
+	__load_no_speculate(&__np_ptr, lo, hi, 0, __np_ptr);		\
+})
+
 #define __smp_mb()	dmb(ish)
 #define __smp_rmb()	dmb(ishld)
 #define __smp_wmb()	dmb(ishst)
-- 
2.11.0

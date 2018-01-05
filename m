From: Mark Rutland <mark.rutland@arm.com>
Subject: [RFCv2 3/4] arm64: implement nospec_ptr()
Date: Fri,  5 Jan 2018 14:57:49 +0000
Message-ID: <20180105145750.53294-4-mark.rutland@arm.com>
References: <20180105145750.53294-1-mark.rutland@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46086 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752195AbeAEO6J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Jan 2018 09:58:09 -0500
In-Reply-To: <20180105145750.53294-1-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: dan.j.williams@intel.com, elena.reshetova@intel.com, corbet@lwn.net, alan@linux.intel.com, peterz@infradead.org, will.deacon@arm.com, gregkh@linuxfoundation.org, tglx@linutronix.de, Mark Rutland <mark.rutland@arm.com>

This patch implements nospec_ptr() for arm64, following the recommended
architectural sequence.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/arm64/include/asm/barrier.h | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 77651c49ef44..b4819f6a0e5c 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -40,6 +40,61 @@
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

From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 04/18] arm: implement nospec_ptr()
Date: Fri, 05 Jan 2018 17:10:14 -0800
Message-ID: <151520101463.32271.9320376934909324865.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

This patch implements nospec_ptr() for arm, following the recommended
architectural sequences for the arm and thumb instruction sets.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm/include/asm/barrier.h |   75 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 40f5c410fd8c..6384c90e4b72 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -37,6 +37,81 @@
 #define dmb(x) __asm__ __volatile__ ("" : : : "memory")
 #endif
 
+#ifdef CONFIG_THUMB2_KERNEL
+#define __load_no_speculate_n(ptr, lo, hi, failval, cmpptr, sz)	\
+({								\
+	typeof(*ptr) __nln_val;					\
+	typeof(*ptr) __failval =				\
+		(typeof(*ptr)(unsigned long)(failval));		\
+								\
+	asm volatile (						\
+	"	cmp	%[c], %[l]\n"				\
+	"	it	hs\n"					\
+	"	cmphs	%[h], %[c]\n"				\
+	"	blo	1f\n"					\
+	"	ld" #sz " %[v], %[p]\n"				\
+	"1:	it	lo\n"					\
+	"	movlo	%[v], %[f]\n"				\
+	"	.inst 0xf3af8014 @ CSDB\n"			\
+	: [v] "=&r" (__nln_val)					\
+	: [p] "m" (*(ptr)), [l] "r" (lo), [h] "r" (hi),		\
+	  [f] "r" (__failval), [c] "r" (cmpptr)			\
+	: "cc");						\
+								\
+	__nln_val;						\
+})
+#else
+#define __load_no_speculate_n(ptr, lo, hi, failval, cmpptr, sz)	\
+({								\
+	typeof(*ptr) __nln_val;					\
+	typeof(*ptr) __failval =				\
+		(typeof(*ptr)(unsigned long)(failval));		\
+								\
+	asm volatile (						\
+	"	cmp	%[c], %[l]\n"				\
+	"	cmphs	%[h], %[c]\n"				\
+	"	ldr" #sz "hi %[v], %[p]\n"			\
+	"	movls	%[v], %[f]\n"				\
+	"	.inst 0xe320f014 @ CSDB\n"			\
+	: [v] "=&r" (__nln_val)					\
+	: [p] "m" (*(ptr)), [l] "r" (lo), [h] "r" (hi),		\
+	  [f] "r" (__failval), [c] "r" (cmpptr)			\
+	: "cc");						\
+								\
+	__nln_val;						\
+})
+#endif
+
+#define __load_no_speculate(ptr, lo, hi, failval, cmpptr)		\
+({									\
+	typeof(*(ptr)) __nl_val;					\
+									\
+	switch (sizeof(__nl_val)) {					\
+	case 1:								\
+		__nl_val = __load_no_speculate_n(ptr, lo, hi, failval,	\
+						 cmpptr, b);		\
+		break;							\
+	case 2:								\
+		__nl_val = __load_no_speculate_n(ptr, lo, hi, failval,	\
+						 cmpptr, h);		\
+		break;							\
+	case 4:								\
+		__nl_val = __load_no_speculate_n(ptr, lo, hi, failval,	\
+						 cmpptr, );		\
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
 #ifdef CONFIG_ARM_HEAVY_MB
 extern void (*soc_mb)(void);
 extern void arm_heavy_mb(void);

From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 03/18] arm64: implement nospec_ptr()
Date: Fri, 05 Jan 2018 17:10:09 -0800
Message-ID: <151520100890.32271.10501551400360324504.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, peterz@infradead.org, netdev@vger.kernel.org, Will Deacon <will.deacon@arm.com>, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, alan@linux.intel.com
List-Id: linux-arch.vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

This patch implements nospec_ptr() for arm64, following the recommended
architectural sequence.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm64/include/asm/barrier.h |   55 ++++++++++++++++++++++++++++++++++++++
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

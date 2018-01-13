From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 2/9] arm64: implement ifence_array_ptr()
Date: Sat, 13 Jan 2018 10:17:34 -0800
Message-ID: <151586745407.5820.16345523612044599487.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151586744180.5820.13215059696964205856.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26623 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751475AbeAMSZt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 13 Jan 2018 13:25:49 -0500
In-Reply-To: <151586744180.5820.13215059696964205856.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, gregkh@linuxfoundation.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@linux.intel.com

From: Mark Rutland <mark.rutland@arm.com>

This patch implements ifence_array_ptr() for arm64, using an
LDR+CSEL+CSDB sequence to inhibit speculative use of the returned value.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/arm64/include/asm/barrier.h |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 77651c49ef44..74ffcddb26e6 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -40,6 +40,30 @@
 #define dma_rmb()	dmb(oshld)
 #define dma_wmb()	dmb(oshst)
 
+#define ifence_array_ptr(arr, idx, sz)					\
+({									\
+	typeof(&(arr)[0]) __nap_arr = (arr);				\
+	typeof(idx) __nap_idx = (idx);					\
+	typeof(sz) __nap_sz = (sz);					\
+									\
+	unsigned long __nap_ptr = (unsigned long)__nap_arr +		\
+				  sizeof(__nap_arr[0]) * idx;		\
+									\
+	asm volatile(							\
+	"	cmp	%[i], %[s]\n"					\
+	"	b.cs	1f\n"						\
+	"	ldr	%[p], %[pp]\n"					\
+	"1:	csel	%[p], %[p], xzr, cc\n"				\
+	"	hint	#0x14 // CSDB\n"				\
+	: [p] "=&r" (__nap_ptr)						\
+	: [pp] "m" (__nap_ptr),						\
+	  [i] "r" ((unsigned long)__nap_idx),				\
+	  [s] "r" ((unsigned long)__nap_sz)				\
+	: "cc");							\
+									\
+	(typeof(&(__nap_arr)[0]))__nap_ptr;				\
+})
+
 #define __smp_mb()	dmb(ish)
 #define __smp_rmb()	dmb(ishld)
 #define __smp_wmb()	dmb(ishst)

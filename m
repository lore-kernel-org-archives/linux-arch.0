Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13998 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932148AbeALAzG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Jan 2018 19:55:06 -0500
Subject: [PATCH v2 05/19] x86: implement ifence_array_ptr() and
 array_ptr_mask()
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 11 Jan 2018 16:46:51 -0800
Message-ID: <151571801167.27429.316440257610732033.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151571798296.27429.7166552848688034184.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151571798296.27429.7166552848688034184.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@linux.intel.com
Message-ID: <20180112004651.RxUcZiPfvsmrWZ4lcowjm8oBihT2GOcbXT7WzoRjq0Y@z>

'ifence_array_ptr' is provided as an alternative to the default
'__array_ptr' implementation that uses a mask to sanitize user
controllable pointers. Later patches will allow it to be selected via
kernel command line. The '__array_ptr' implementation otherwise appears
safe for current generation cpus across multiple architectures.

'array_ptr_mask' is used by the default 'array_ptr' implementation to
cheaply calculate an array bounds mask.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/barrier.h |   42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index b04f572d6d97..4450d25d8cde 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -28,6 +28,48 @@
 #define ifence() alternative_2("", "mfence", X86_FEATURE_MFENCE_RDTSC, \
 				   "lfence", X86_FEATURE_LFENCE_RDTSC)
 
+/**
+ * ifence_array_ptr - Generate a pointer to an array element,
+ * ensuring the pointer is bounded under speculation.
+ *
+ * @arr: the base of the array
+ * @idx: the index of the element
+ * @sz: the number of elements in the array
+ *
+ * If @idx falls in the interval [0, @sz), returns the pointer to
+ * @arr[@idx], otherwise returns NULL.
+ */
+#define ifence_array_ptr(arr, idx, sz)					\
+({									\
+	typeof(*(arr)) *__arr = (arr), *__ret;				\
+	typeof(idx) __idx = (idx);					\
+	typeof(sz) __sz = (sz);						\
+									\
+	__ret = __idx < __sz ? __arr + __idx : NULL;			\
+	ifence();							\
+	__ret;								\
+})
+
+/**
+ * array_ptr_mask - generate a mask for array_ptr() that is ~0UL when
+ * the bounds check succeeds and 0 otherwise
+ */
+#define array_ptr_mask array_ptr_mask
+static inline unsigned long array_ptr_mask(unsigned long idx, unsigned long sz)
+{
+	unsigned long mask;
+
+	/*
+	 * mask = index - size, if that result is >= 0 then the index is
+	 * invalid and the mask is 0 else ~0
+	 */
+	asm ("cmpq %1,%2; sbbq %0,%0;"
+			:"=r" (mask)
+			:"r"(sz),"r" (idx)
+			:"cc");
+	return mask;
+}
+
 #ifdef CONFIG_X86_PPRO_FENCE
 #define dma_rmb()	rmb()
 #else

From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 01/18] asm-generic/barrier: add generic nospec helpers
Date: Fri, 05 Jan 2018 17:09:58 -0800
Message-ID: <151520099810.32271.11023910901471332353.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
memory accesses under a bounds check may be speculated even if the
bounds check fails, providing a primitive for building a side channel.

This patch adds helpers which can be used to inhibit the use of
out-of-bounds pointers under speculation.

A generic implementation is provided for compatibility, but does not
guarantee safety under speculation. Architectures are expected to
override these helpers as necessary.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Daniel Willams <dan.j.williams@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/asm-generic/barrier.h |   68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index fe297b599b0a..91c3071f49e5 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -54,6 +54,74 @@
 #define read_barrier_depends()		do { } while (0)
 #endif
 
+/*
+ * Inhibit subsequent speculative memory accesses.
+ *
+ * Architectures with a suitable memory barrier should provide an
+ * implementation. This is non-portable, and generic code should use
+ * nospec_ptr().
+ */
+#ifndef __nospec_barrier
+#define __nospec_barrier()		do { } while (0)
+#endif
+
+/**
+ * nospec_ptr() - Ensure a  pointer is bounded, even under speculation.
+ *
+ * @ptr: the pointer to test
+ * @lo: the lower valid bound for @ptr, inclusive
+ * @hi: the upper valid bound for @ptr, exclusive
+ *
+ * If @ptr falls in the interval [@lo, @i), returns @ptr, otherwise returns
+ * NULL.
+ *
+ * Architectures which do not provide __nospec_barrier() should override this
+ * to ensure that ptr falls in the [lo, hi) interval both under architectural
+ * execution and under speculation, preventing propagation of an out-of-bounds
+ * pointer to code which is speculatively executed.
+ */
+#ifndef nospec_ptr
+#define nospec_ptr(ptr, lo, hi)						\
+({									\
+	typeof (ptr) __ret;						\
+	typeof (ptr) __ptr = (ptr);					\
+	typeof (ptr) __lo = (lo);					\
+	typeof (ptr) __hi = (hi);					\
+									\
+	__ret = (__lo <= __ptr && __ptr < __hi) ? __ptr : NULL;		\
+									\
+	__nospec_barrier();						\
+									\
+	__ret;								\
+})
+#endif
+
+/**
+ * nospec_array_ptr - Generate a pointer to an array element, ensuring the
+ * pointer is bounded under speculation.
+ *
+ * @arr: the base of the array
+ * @idx: the index of the element
+ * @sz: the number of elements in the array
+ *
+ * If @idx falls in the interval [0, @sz), returns the pointer to @arr[@idx],
+ * otherwise returns NULL.
+ *
+ * This is a wrapper around nospec_ptr(), provided for convenience.
+ * Architectures should implement nospec_ptr() to ensure this is the case
+ * under speculation.
+ */
+#define nospec_array_ptr(arr, idx, sz)					\
+({									\
+	typeof(*(arr)) *__arr = (arr);					\
+	typeof(idx) __idx = (idx);					\
+	typeof(sz) __sz = (sz);						\
+									\
+	nospec_ptr(__arr + __idx, __arr, __arr + __sz);			\
+})
+
+#undef __nospec_barrier
+
 #ifndef __smp_mb
 #define __smp_mb()	mb()
 #endif

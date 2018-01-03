From: Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 1/4] asm-generic/barrier: add generic nospec helpers
Date: Wed,  3 Jan 2018 22:38:24 +0000
Message-ID: <20180103223827.39601-2-mark.rutland@arm.com>
References: <20180103223827.39601-1-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103223827.39601-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
memory accesses under a bounds check may be speculated even if the
bounds check fails, providing a primitive for building a side channel.

This patch adds helpers which can be used to inhibit the use of
out-of-bounds pointers and/or valeus read from these under speculation.

A generic implementation is provided for compatibility, but does not
guarantee safety under speculation. Architectures are expected to
override these helpers as necessary.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/barrier.h | 76 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index fe297b599b0a..5eba6ae0c34e 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -54,6 +54,82 @@
 #define read_barrier_depends()		do { } while (0)
 #endif
 
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
+ * Architectures should override this to ensure that ptr falls in the [lo, hi)
+ * interval both under architectural execution and under speculation,
+ * preventing propagation of an out-of-bounds pointer to code which is
+ * speculatively executed.
+ */
+#ifndef nospec_ptr
+#define nospec_ptr(ptr, lo, hi)						\
+({									\
+	typeof (ptr) __ptr = (ptr);					\
+	typeof (ptr) __lo = (lo);					\
+	typeof (ptr) __hi = (hi);					\
+									\
+	(__lo <= __ptr && __ptr < __hi) ? __ptr : NULL;			\
+})
+#endif
+
+/**
+ * nospec_load() - Load a pointer, respecting bounds under speculation
+ *
+ * @ptr: the pointer to load
+ * @lo: the lower valid bound for @ptr, inclusive
+ * @hi: the upper valid bound for @ptr, exclusive
+ *
+ * If @ptr falls in the interval [@lo, @hi), returns the value at @ptr,
+ * otherwise returns (typeof(*ptr))0.
+ *
+ * Architectures should override this to ensure that ptr falls in the [lo, hi)
+ * interval both under architectural execution and under speculation,
+ * preventing speculative out-of-bounds reads.
+ */
+#ifndef nospec_load
+#define nospec_load(ptr, lo, hi)					\
+({									\
+	typeof (ptr) __ptr = (ptr);					\
+	typeof (ptr) __lo = (lo);					\
+	typeof (ptr) __hi = (hi);					\
+									\
+	(__lo <= __ptr && __ptr <= __hi) ?				\
+		*__ptr : 						\
+		(typeof(*__ptr))(unsigned long)0;			\
+})
+#endif
+
+/**
+ * nospec_array_load - Load an array entry, respecting bounds under speculation
+ *
+ * @arr: the base of the array
+ * @idx: the index of the element to load
+ * @sz: the number of elements in the array
+ *
+ * If @idx falls in the interval [0, @sz), returns the value at @arr[@idx],
+ * otherwise returns (typeof(*ptr))0.
+ *
+ * This is a wrapper around nospec_load(), provided for convenience.
+ * Architectures should implement nospec_load() to ensure this is the case
+ * under speculation.
+ */
+#define nospec_array_load(arr, idx, sz)					\
+({									\
+	typeof(*(arr)) *__arr = arr;					\
+	typeof(idx) __idx = idx;					\
+	typeof(sz) __sz = __sz;						\
+									\
+	nospec_load(__arr + __idx, __arr, __arr + __sz);		\
+})
+
 #ifndef __smp_mb
 #define __smp_mb()	mb()
 #endif
-- 
2.11.0

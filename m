From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 04/15] Convert 32-bit ISO atomics into a template
Date: Wed, 18 May 2016 16:11:07 +0100
Message-ID: <146358426742.8596.18022841527512599797.stgit@warthog.procyon.org.uk>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

Convert the 32-bit ISO C++11 atomic implementation into a template that can
then be overloaded with #defines to produce 32-bit, long and 64-bit
atomics.

This is then overloaded to produce the 32-bit atomic_t implementation.

This should probably be merged with the previous patch if we want to use
the template approach.  The template approach has the advantage that it can
produce all of the different sets of atomics from the same code, but the
disadvantage that the template is much less readable.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/iso-atomic-template.h |  572 +++++++++++++++++++++++++++++
 include/asm-generic/iso-atomic.h          |  387 --------------------
 2 files changed, 579 insertions(+), 380 deletions(-)
 create mode 100644 include/asm-generic/iso-atomic-template.h

diff --git a/include/asm-generic/iso-atomic-template.h b/include/asm-generic/iso-atomic-template.h
new file mode 100644
index 000000000000..76da163ec559
--- /dev/null
+++ b/include/asm-generic/iso-atomic-template.h
@@ -0,0 +1,572 @@
+/* Use ISO C++11 intrinsics to implement atomic ops.
+ *
+ * This file is a template.  The #includer needs to #define the following
+ * items:
+ *
+ *	atomic_val		- counter type (eg. int, long, long long)
+ *	atomic_prefix(x)	- prefix (eg. atomic, atomic64, atomic_long)
+ *	__atomic_prefix(x)	- prefix with "__" prepended
+ *
+ * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+/**
+ * atomic_read - read atomic variable
+ * @v: pointer to atomic variable
+ *
+ * Atomically reads the value of @v.
+ */
+static __always_inline atomic_val atomic_prefix(_read)(const atomic_prefix(_t) *v)
+{
+	return __atomic_load_n(&v->counter, __ATOMIC_RELAXED);
+}
+
+static __always_inline atomic_val atomic_prefix(_read_acquire)(const atomic_prefix(_t) *v)
+{
+	return __atomic_load_n(&v->counter, __ATOMIC_ACQUIRE);
+}
+
+/**
+ * atomic_set - set atomic variable
+ * @v: pointer to atomic variable
+ * @i: required value
+ *
+ * Atomically sets the value of @v to @i.
+ */
+static __always_inline void atomic_prefix(_set)(atomic_prefix(_t) *v, atomic_val i)
+{
+	__atomic_store_n(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+static __always_inline void atomic_prefix(_set_release)(atomic_prefix(_t) *v, atomic_val i)
+{
+	__atomic_store_n(&v->counter, i, __ATOMIC_RELEASE);
+}
+
+/**
+ * atomic_add - add integer to atomic variable
+ * @i: integer value to add
+ * @v: pointer to atomic variable
+ *
+ * Atomically adds @i to @v.
+ */
+static __always_inline void atomic_prefix(_add)(atomic_val i, atomic_prefix(_t) *v)
+{
+	__atomic_add_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+static __always_inline void atomic_prefix(_inc)(atomic_prefix(_t) *v)
+{
+	__atomic_add_fetch(&v->counter, 1, __ATOMIC_RELAXED);
+}
+
+/**
+ * atomic_sub - subtract integer from atomic variable
+ * @i: integer value to subtract
+ * @v: pointer to atomic variable
+ *
+ * Atomically subtracts @i from @v.
+ */
+static __always_inline void atomic_prefix(_sub)(atomic_val i, atomic_prefix(_t) *v)
+{
+	__atomic_sub_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+static __always_inline void atomic_prefix(_dec)(atomic_prefix(_t) *v)
+{
+	__atomic_sub_fetch(&v->counter, 1, __ATOMIC_RELAXED);
+}
+
+/**
+ * atomic_add_return - add integer and return
+ * @i: integer value to add
+ * @v: pointer to atomic variable
+ *
+ * Atomically adds @i to @v and returns @i + @v.
+ */
+static __always_inline
+atomic_val atomic_prefix(_add_return)(atomic_val i, atomic_prefix(_t) *v)
+{
+	return __atomic_add_fetch(&v->counter, i, __ATOMIC_SEQ_CST);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_inc_return)(atomic_prefix(_t) *v)
+{
+	return __atomic_add_fetch(&v->counter, 1, __ATOMIC_SEQ_CST);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_add_return_relaxed)(atomic_val i, atomic_prefix(_t) *v)
+{
+	return __atomic_add_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_inc_return_relaxed)(atomic_prefix(_t) *v)
+{
+	return __atomic_add_fetch(&v->counter, 1, __ATOMIC_RELAXED);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_add_return_acquire)(atomic_val i, atomic_prefix(_t) *v)
+{
+	return __atomic_add_fetch(&v->counter, i, __ATOMIC_ACQUIRE);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_inc_return_acquire)(atomic_prefix(_t) *v)
+{
+	return __atomic_add_fetch(&v->counter, 1, __ATOMIC_ACQUIRE);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_add_return_release)(atomic_val i, atomic_prefix(_t) *v)
+{
+	return __atomic_add_fetch(&v->counter, i, __ATOMIC_RELEASE);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_inc_return_release)(atomic_prefix(_t) *v)
+{
+	return __atomic_add_fetch(&v->counter, 1, __ATOMIC_RELEASE);
+}
+
+static __always_inline
+bool atomic_prefix(_add_negative)(atomic_val i, atomic_prefix(_t) *v)
+{
+	return __atomic_add_fetch(&v->counter, i, __ATOMIC_SEQ_CST) < 0;
+}
+
+static __always_inline
+bool atomic_prefix(_inc_and_test)(atomic_prefix(_t) *v)
+{
+	return __atomic_add_fetch(&v->counter, 1, __ATOMIC_SEQ_CST) == 0;
+}
+
+/**
+ * atomic_sub_return - subtract integer and return
+ * @i: integer value to subtract
+ * @v: pointer to atomic variable
+ *
+ * Atomically subtracts @i from @v and returns @v - @i
+ */
+static __always_inline
+atomic_val atomic_prefix(_sub_return)(atomic_val i, atomic_prefix(_t) *v)
+{
+	return __atomic_sub_fetch(&v->counter, i, __ATOMIC_SEQ_CST);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_dec_return)(atomic_prefix(_t) *v)
+{
+	return __atomic_sub_fetch(&v->counter, 1, __ATOMIC_SEQ_CST);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_sub_return_relaxed)(atomic_val i, atomic_prefix(_t) *v)
+{
+	return __atomic_sub_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_dec_return_relaxed)(atomic_prefix(_t) *v)
+{
+	return __atomic_sub_fetch(&v->counter, 1, __ATOMIC_RELAXED);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_sub_return_acquire)(atomic_val i, atomic_prefix(_t) *v)
+{
+	return __atomic_sub_fetch(&v->counter, i, __ATOMIC_ACQUIRE);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_dec_return_acquire)(atomic_prefix(_t) *v)
+{
+	return __atomic_sub_fetch(&v->counter, 1, __ATOMIC_ACQUIRE);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_sub_return_release)(atomic_val i, atomic_prefix(_t) *v)
+{
+	return __atomic_sub_fetch(&v->counter, i, __ATOMIC_RELEASE);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_dec_return_release)(atomic_prefix(_t) *v)
+{
+	return __atomic_sub_fetch(&v->counter, 1, __ATOMIC_RELEASE);
+}
+
+static __always_inline
+bool atomic_prefix(_sub_and_test)(atomic_val i, atomic_prefix(_t) *v)
+{
+	return __atomic_sub_fetch(&v->counter, i, __ATOMIC_SEQ_CST) == 0;
+}
+
+static __always_inline
+bool atomic_prefix(_dec_and_test)(atomic_prefix(_t) *v)
+{
+	return __atomic_sub_fetch(&v->counter, 1, __ATOMIC_SEQ_CST) == 0;
+}
+
+/**
+ * atomic_try_cmpxchg - Compare value to memory and exchange if same
+ * @v: Pointer of type atomic_t
+ * @old: The value to be replaced
+ * @new: The value to replace with
+ *
+ * Atomically read the original value of *@v compare it against @old.  If *@v
+ * == @old, write the value of @new to *@v.  If the write takes place, true is
+ * returned otherwise false is returned.  The original value is discarded - if
+ * that is required, use atomic_cmpxchg_return() instead.
+ */
+static __always_inline
+bool atomic_prefix(_try_cmpxchg)(atomic_prefix(_t) *v, atomic_val old, atomic_val new)
+{
+	int cur = old;
+	return __atomic_compare_exchange_n(&v->counter, &cur, new, false,
+					   __ATOMIC_SEQ_CST,
+					   __ATOMIC_RELAXED);
+}
+
+static __always_inline
+bool atomic_prefix(_try_cmpxchg_relaxed)(atomic_prefix(_t) *v, atomic_val old, atomic_val new)
+{
+	int cur = old;
+	return __atomic_compare_exchange_n(&v->counter, &cur, new, false,
+					   __ATOMIC_RELAXED,
+					   __ATOMIC_RELAXED);
+}
+
+static __always_inline
+bool atomic_prefix(_try_cmpxchg_acquire)(atomic_prefix(_t) *v, atomic_val old, atomic_val new)
+{
+	int cur = old;
+	return __atomic_compare_exchange_n(&v->counter, &cur, new, false,
+					   __ATOMIC_ACQUIRE,
+					   __ATOMIC_RELAXED);
+}
+
+static __always_inline
+bool atomic_prefix(_try_cmpxchg_release)(atomic_prefix(_t) *v, atomic_val old, atomic_val new)
+{
+	int cur = old;
+	return __atomic_compare_exchange_n(&v->counter, &cur, new, false,
+					   __ATOMIC_RELEASE,
+					   __ATOMIC_RELAXED);
+}
+
+/**
+ * atomic_cmpxchg_return - Compare value to memory and exchange if same
+ * @v: Pointer of type atomic_t
+ * @old: The value to be replaced
+ * @new: The value to replace with
+ * @_orig: Where to place the original value of *@v
+ *
+ * Atomically read the original value of *@v and compare it against @old.  If
+ * *@v == @old, write the value of @new to *@v.  If the write takes place, true
+ * is returned otherwise false is returned.  The original value of *@v is saved
+ * to *@_orig.
+ */
+static __always_inline
+bool atomic_prefix(_cmpxchg_return)(atomic_prefix(_t) *v,
+				    atomic_val old, atomic_val new, atomic_val *_orig)
+{
+	*_orig = old;
+	return __atomic_compare_exchange_n(&v->counter, _orig, new, false,
+					   __ATOMIC_SEQ_CST,
+					   __ATOMIC_RELAXED);
+}
+
+static __always_inline
+bool atomic_prefix(_cmpxchg_return_relaxed)(atomic_prefix(_t) *v,
+					    atomic_val old, atomic_val new, atomic_val *_orig)
+{
+	*_orig = old;
+	return __atomic_compare_exchange_n(&v->counter, _orig, new, false,
+					   __ATOMIC_RELAXED,
+					   __ATOMIC_RELAXED);
+}
+
+static __always_inline
+bool atomic_prefix(_cmpxchg_return_acquire)(atomic_prefix(_t) *v,
+					    atomic_val old, atomic_val new, atomic_val *_orig)
+{
+	*_orig = old;
+	return __atomic_compare_exchange_n(&v->counter, _orig, new, false,
+					   __ATOMIC_ACQUIRE,
+					   __ATOMIC_RELAXED);
+}
+
+static __always_inline
+bool atomic_prefix(_cmpxchg_return_release)(atomic_prefix(_t) *v,
+					    atomic_val old, atomic_val new, atomic_val *_orig)
+{
+	*_orig = old;
+	return __atomic_compare_exchange_n(&v->counter, _orig, new, false,
+					   __ATOMIC_RELEASE,
+					   __ATOMIC_RELAXED);
+}
+
+/**
+ * atomic_cmpxchg - Compare value to memory and exchange if same
+ * @v: Pointer of type atomic_t
+ * @old: The value to be replaced
+ * @new: The value to replace with
+ *
+ * Atomically read the original value of *@v and compare it against @old.  If
+ * *@v == @old, write the value of @new to *@v.  The original value is
+ * returned.
+ *
+ * atomic_try_cmpxchg() and atomic_cmpxchg_return_release() are preferred to
+ * this function as they can make better use of the knowledge as to whether a
+ * write took place or not that is provided by some CPUs (e.g. x86's CMPXCHG
+ * instruction stores this in the Z flag).
+ */
+static __always_inline
+atomic_val atomic_prefix(_cmpxchg)(atomic_prefix(_t) *v, atomic_val old, atomic_val new)
+{
+	atomic_val cur = old;
+	if (__atomic_compare_exchange_n(&v->counter, &cur, new, false,
+					__ATOMIC_SEQ_CST,
+					__ATOMIC_RELAXED))
+		return old;
+	return cur;
+}
+
+static __always_inline
+atomic_val atomic_prefix(_cmpxchg_relaxed)(atomic_prefix(_t) *v, atomic_val old, atomic_val new)
+{
+	atomic_val cur = old;
+	if (__atomic_compare_exchange_n(&v->counter, &cur, new, false,
+					__ATOMIC_RELAXED,
+					__ATOMIC_RELAXED))
+		return old;
+	return cur;
+}
+
+static __always_inline
+atomic_val atomic_prefix(_cmpxchg_acquire)(atomic_prefix(_t) *v, atomic_val old, atomic_val new)
+{
+	atomic_val cur = old;
+	if (__atomic_compare_exchange_n(&v->counter, &cur, new, false,
+					__ATOMIC_ACQUIRE,
+					__ATOMIC_RELAXED))
+		return old;
+	return cur;
+}
+
+static __always_inline
+atomic_val atomic_prefix(_cmpxchg_release)(atomic_prefix(_t) *v, atomic_val old, atomic_val new)
+{
+	atomic_val cur = old;
+	if (__atomic_compare_exchange_n(&v->counter, &cur, new, false,
+					__ATOMIC_RELEASE,
+					__ATOMIC_RELAXED))
+		return old;
+	return cur;
+}
+
+static __always_inline
+atomic_val atomic_prefix(_xchg)(atomic_prefix(_t) *v, atomic_val new)
+{
+	return __atomic_exchange_n(&v->counter, new, __ATOMIC_SEQ_CST);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_xchg_relaxed)(atomic_prefix(_t) *v, atomic_val new)
+{
+	return __atomic_exchange_n(&v->counter, new, __ATOMIC_RELAXED);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_xchg_acquire)(atomic_prefix(_t) *v, atomic_val new)
+{
+	return __atomic_exchange_n(&v->counter, new, __ATOMIC_ACQUIRE);
+}
+
+static __always_inline
+atomic_val atomic_prefix(_xchg_release)(atomic_prefix(_t) *v, atomic_val new)
+{
+	return __atomic_exchange_n(&v->counter, new, __ATOMIC_RELEASE);
+}
+
+/*
+ * Bitwise atomic ops.
+ */
+static __always_inline void atomic_prefix(_and)(atomic_val i, atomic_prefix(_t) *v)
+{
+	__atomic_and_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+static __always_inline void atomic_prefix(_andnot)(atomic_val i, atomic_prefix(_t) *v)
+{
+	__atomic_and_fetch(&v->counter, ~i, __ATOMIC_RELAXED);
+}
+
+static __always_inline void atomic_prefix(_or)(atomic_val i, atomic_prefix(_t) *v)
+{
+	__atomic_or_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+static __always_inline void atomic_prefix(_xor)(atomic_val i, atomic_prefix(_t) *v)
+{
+	__atomic_xor_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+/**
+ * __atomic_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_prefix(_t)
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns the old value of @v.
+ */
+static __always_inline
+atomic_val __atomic_prefix(_add_unless)(atomic_prefix(_t) *v, atomic_val addend, atomic_val unless)
+{
+	atomic_val c = atomic_prefix(_read)(v);
+
+	while (likely(c != unless)) {
+		if (__atomic_compare_exchange_n(&v->counter,
+						&c, c + addend,
+						false,
+						__ATOMIC_SEQ_CST,
+						__ATOMIC_RELAXED))
+			break;
+	}
+	return c;
+}
+
+/**
+ * atomic_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_prefix(_t)
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns true if @v was not @u, and false otherwise.
+ */
+static __always_inline
+bool atomic_prefix(_add_unless)(atomic_prefix(_t) *v,
+				atomic_val addend, atomic_val unless)
+{
+	atomic_val c = __atomic_load_n(&v->counter, __ATOMIC_RELAXED);
+
+	while (likely(c != unless)) {
+		if (__atomic_compare_exchange_n(&v->counter,
+						&c, c + addend,
+						false,
+						__ATOMIC_SEQ_CST,
+						__ATOMIC_RELAXED))
+			return true;
+	}
+	return false;
+}
+
+static __always_inline
+bool atomic_prefix(_inc_not_zero)(atomic_prefix(_t) *v)
+{
+	atomic_val c = __atomic_load_n(&v->counter, __ATOMIC_RELAXED);
+
+	while (likely(c != 0)) {
+		if (__atomic_compare_exchange_n(&v->counter,
+						&c, c + 1,
+						false,
+						__ATOMIC_SEQ_CST,
+						__ATOMIC_RELAXED))
+			return true;
+	}
+	return false;
+}
+
+static __always_inline
+bool atomic_prefix(_inc_not_zero_hint)(atomic_prefix(_t) *v, atomic_val hint)
+{
+	atomic_val c = hint;
+
+	while (likely(c != 0)) {
+		if (__atomic_compare_exchange_n(&v->counter,
+						&c, c + 1,
+						false,
+						__ATOMIC_SEQ_CST,
+						__ATOMIC_RELAXED))
+			return true;
+	}
+	return false;
+}
+
+static __always_inline
+bool atomic_prefix(_inc_unless_negative)(atomic_prefix(_t) *v)
+{
+	atomic_val c = 0;
+
+	while (likely(c >= 0)) {
+		if (__atomic_compare_exchange_n(&v->counter,
+						&c, c + 1,
+						false,
+						__ATOMIC_SEQ_CST,
+						__ATOMIC_RELAXED))
+			return true;
+	}
+	return false;
+}
+
+static __always_inline
+bool atomic_prefix(_dec_unless_positive)(atomic_prefix(_t) *v)
+{
+	atomic_val c = 0;
+
+	while (likely(c <= 0)) {
+		if (__atomic_compare_exchange_n(&v->counter,
+						&c, c - 1,
+						false,
+						__ATOMIC_SEQ_CST,
+						__ATOMIC_RELAXED))
+			return true;
+	}
+	return false;
+}
+
+/*
+ * atomic_dec_if_positive - decrement by 1 if old value positive
+ * @v: pointer of type atomic_prefix(_t)
+ *
+ * The function returns the old value of *v minus 1, even if
+ * the atomic variable, v, was not decremented.
+ */
+static __always_inline
+bool atomic_prefix(_dec_if_positive)(atomic_prefix(_t) *v)
+{
+	atomic_val c = __atomic_load_n(&v->counter, __ATOMIC_RELAXED);
+
+	while (likely(c > 0)) {
+		if (__atomic_compare_exchange_n(&v->counter,
+						&c, c - 1,
+						false,
+						__ATOMIC_SEQ_CST,
+						__ATOMIC_RELAXED))
+			return true;
+	}
+	return false;
+}
+
+/**
+ * atomic_fetch_or - perform *v |= mask and return old value of *v
+ * @v: pointer to atomic_prefix(_t)
+ * @mask: mask to OR on the atomic_prefix(_t)
+ */
+static __always_inline
+atomic_val atomic_prefix(_fetch_or)(atomic_prefix(_t) *v, atomic_val mask)
+{
+	return __atomic_fetch_or(&v->counter, mask, __ATOMIC_SEQ_CST);
+}
diff --git a/include/asm-generic/iso-atomic.h b/include/asm-generic/iso-atomic.h
index dfb1f2b188f9..b10250f34d3a 100644
--- a/include/asm-generic/iso-atomic.h
+++ b/include/asm-generic/iso-atomic.h
@@ -14,388 +14,15 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <asm/cmpxchg.h>
-#include <asm/barrier.h>
 
 #define ATOMIC_INIT(i)	{ (i) }
 
-/**
- * atomic_read - read atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically reads the value of @v.
- */
-static __always_inline int __atomic_read(const atomic_t *v, int memorder)
-{
-	return __atomic_load_n(&v->counter, memorder);
-}
-#define atomic_read(v)		(__atomic_read((v), __ATOMIC_RELAXED))
-#define atomic_read_acquire(v)	(__atomic_read((v), __ATOMIC_ACQUIRE))
-
-/**
- * atomic_set - set atomic variable
- * @v: pointer of type atomic_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
-static __always_inline void __atomic_set(atomic_t *v, int i, int memorder)
-{
-	__atomic_store_n(&v->counter, i, memorder);
-}
-#define atomic_set(v, i)	 __atomic_set((v), (i), __ATOMIC_RELAXED)
-#define atomic_set_release(v, i) __atomic_set((v), (i), __ATOMIC_RELEASE)
-
-/**
- * atomic_add - add integer to atomic variable
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v.
- */
-static __always_inline void atomic_add(int i, atomic_t *v)
-{
-	__atomic_add_fetch(&v->counter, i, __ATOMIC_RELAXED);
-}
-
-#define atomic_inc(v) atomic_add(1, (v))
-
-/**
- * atomic_sub - subtract integer from atomic variable
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v.
- */
-static __always_inline void atomic_sub(int i, atomic_t *v)
-{
-	__atomic_sub_fetch(&v->counter, i, __ATOMIC_RELAXED);
-}
-
-#define atomic_dec(v) atomic_add(-1, (v))
-
-/**
- * atomic_add_return - add integer and return
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v and returns @i + @v.
- */
-static __always_inline int __atomic_add_return(int i, atomic_t *v, int memorder)
-{
-	return __atomic_add_fetch(&v->counter, i, memorder);
-}
-
-#define atomic_add_return(i, v)		(__atomic_add_return((i), (v), __ATOMIC_SEQ_CST))
-#define atomic_add_negative(i, v)	(atomic_add_return((i), (v)) < 0)
-#define atomic_inc_return(v)		(atomic_add_return(1, (v)))
-#define atomic_inc_and_test(v)		(atomic_add_return(1, (v)) == 0)
-
-#define atomic_add_return_relaxed(i, v)	(__atomic_add_return((i), (v), __ATOMIC_RELAXED))
-#define atomic_inc_return_relaxed(v)	(atomic_add_return_relaxed(1, (v)))
-
-#define atomic_add_return_acquire(i, v)	(__atomic_add_return((i), (v), __ATOMIC_ACQUIRE))
-#define atomic_inc_return_acquire(v)	(atomic_add_return_acquire(1, (v)))
-
-#define atomic_add_return_release(i, v)	(__atomic_add_return((i), (v), __ATOMIC_RELEASE))
-#define atomic_inc_return_release(v)	(atomic_add_return_release(1, (v)))
-
-/**
- * atomic_sub_return - subtract integer and return
- * @v: pointer of type atomic_t
- * @i: integer value to subtract
- *
- * Atomically subtracts @i from @v and returns @v - @i
- */
-static __always_inline int __atomic_sub_return(int i, atomic_t *v, int memorder)
-{
-	return __atomic_sub_fetch(&v->counter, i, memorder);
-}
-
-#define atomic_sub_return(i, v)		(__atomic_sub_return((i), (v), __ATOMIC_SEQ_CST))
-#define atomic_sub_and_test(i, v)	(atomic_sub_return((i), (v)) == 0)
-#define atomic_dec_return(v)		(atomic_sub_return(1, (v)))
-#define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
-
-#define atomic_sub_return_relaxed(i, v)	(__atomic_sub_return((i), (v), __ATOMIC_RELAXED))
-#define atomic_dec_return_relaxed(v)	(atomic_sub_return_relaxed(1, (v)))
-
-#define atomic_sub_return_acquire(i, v)	(__atomic_sub_return((i), (v), __ATOMIC_ACQUIRE))
-#define atomic_dec_return_acquire(v)	(atomic_sub_return_acquire(1, (v)))
-
-#define atomic_sub_return_release(i, v)	(__atomic_sub_return((i), (v), __ATOMIC_RELEASE))
-#define atomic_dec_return_release(v)	(atomic_sub_return_release(1, (v)))
-
-/**
- * atomic_try_cmpxchg - Compare value to memory and exchange if same
- * @v: Pointer of type atomic_t
- * @old: The value to be replaced
- * @new: The value to replace with
- *
- * Atomically read the original value of *@v compare it against @old.  If *@v
- * == @old, write the value of @new to *@v.  If the write takes place, true is
- * returned otherwise false is returned.  The original value is discarded - if
- * that is required, use atomic_cmpxchg_return() instead.
- */
-static __always_inline
-bool __atomic_try_cmpxchg(atomic_t *v, int old, int new, int memorder)
-{
-	int cur = old;
-	return __atomic_compare_exchange_n(&v->counter, &cur, new, false,
-					   memorder, __ATOMIC_RELAXED);
-}
-
-#define atomic_try_cmpxchg(v, o, n) \
-	(__atomic_try_cmpxchg((v), (o), (n), __ATOMIC_SEQ_CST))
-#define atomic_try_cmpxchg_relaxed(v, o, n) \
-	(__atomic_try_cmpxchg((v), (o), (n), __ATOMIC_RELAXED))
-#define atomic_try_cmpxchg_acquire(v, o, n) \
-	(__atomic_try_cmpxchg((v), (o), (n), __ATOMIC_ACQUIRE))
-#define atomic_try_cmpxchg_release(v, o, n) \
-	(__atomic_try_cmpxchg((v), (o), (n), __ATOMIC_RELEASE))
-
-/**
- * atomic_cmpxchg_return - Compare value to memory and exchange if same
- * @v: Pointer of type atomic_t
- * @old: The value to be replaced
- * @new: The value to replace with
- * @_orig: Where to place the original value of *@v
- *
- * Atomically read the original value of *@v and compare it against @old.  If
- * *@v == @old, write the value of @new to *@v.  If the write takes place, true
- * is returned otherwise false is returned.  The original value of *@v is saved
- * to *@_orig.
- */
-static __always_inline
-bool __atomic_cmpxchg_return(atomic_t *v, int old, int new, int *_orig, int memorder)
-{
-	*_orig = old;
-	return __atomic_compare_exchange_n(&v->counter, _orig, new, false,
-					   memorder, __ATOMIC_RELAXED);
-}
-
-#define atomic_cmpxchg_return(v, o, n, _o) \
-	(__atomic_cmpxchg_return((v), (o), (n), (_o), __ATOMIC_SEQ_CST))
-#define atomic_cmpxchg_return_relaxed(v, o, n, _o) \
-	(__atomic_cmpxchg_return((v), (o), (n), (_o), __ATOMIC_RELAXED))
-#define atomic_cmpxchg_return_acquire(v, o, n, _o) \
-	(__atomic_cmpxchg_return((v), (o), (n), (_o), __ATOMIC_ACQUIRE))
-#define atomic_cmpxchg_return_release(v, o, n, _o) \
-	(__atomic_cmpxchg_return((v), (o), (n), (_o), __ATOMIC_RELEASE))
-
-/**
- * atomic_cmpxchg - Compare value to memory and exchange if same
- * @v: Pointer of type atomic_t
- * @old: The value to be replaced
- * @new: The value to replace with
- *
- * Atomically read the original value of *@v and compare it against @old.  If
- * *@v == @old, write the value of @new to *@v.  The original value is
- * returned.
- *
- * atomic_try_cmpxchg() and atomic_cmpxchg_return_release() are preferred to
- * this function as they can make better use of the knowledge as to whether a
- * write took place or not that is provided by some CPUs (e.g. x86's CMPXCHG
- * instruction stores this in the Z flag).
- */
-static __always_inline int __atomic_cmpxchg(atomic_t *v, int old, int new,
-					    int memorder)
-{
-	int cur = old;
-	if (__atomic_compare_exchange_n(&v->counter, &cur, new, false,
-					memorder, __ATOMIC_RELAXED))
-		return old;
-	return cur;
-}
-
-#define atomic_cmpxchg(v, o, n)		(__atomic_cmpxchg((v), (o), (n), __ATOMIC_SEQ_CST))
-#define atomic_cmpxchg_relaxed(v, o, n)	(__atomic_cmpxchg((v), (o), (n), __ATOMIC_RELAXED))
-#define atomic_cmpxchg_acquire(v, o, n)	(__atomic_cmpxchg((v), (o), (n), __ATOMIC_ACQUIRE))
-#define atomic_cmpxchg_release(v, o, n)	(__atomic_cmpxchg((v), (o), (n), __ATOMIC_RELEASE))
-
-static __always_inline int __atomic_xchg(atomic_t *v, int new, int memorder)
-{
-	return __atomic_exchange_n(&v->counter, new, memorder);
-}
-
-#define atomic_xchg(v, new)		(__atomic_xchg((v), (new), __ATOMIC_SEQ_CST))
-#define atomic_xchg_relaxed(v, new)	(__atomic_xchg((v), (new), __ATOMIC_RELAXED))
-#define atomic_xchg_acquire(v, new)	(__atomic_xchg((v), (new), __ATOMIC_ACQUIRE))
-#define atomic_xchg_release(v, new)	(__atomic_xchg((v), (new), __ATOMIC_RELEASE))
-
-static __always_inline void atomic_and(int i, atomic_t *v)
-{
-	__atomic_and_fetch(&v->counter, i, __ATOMIC_RELAXED);
-}
-
-static __always_inline void atomic_andnot(int i, atomic_t *v)
-{
-	__atomic_and_fetch(&v->counter, ~i, __ATOMIC_RELAXED);
-}
-
-static __always_inline void atomic_or(int i, atomic_t *v)
-{
-	__atomic_or_fetch(&v->counter, i, __ATOMIC_RELAXED);
-}
-
-static __always_inline void atomic_xor(int i, atomic_t *v)
-{
-	__atomic_xor_fetch(&v->counter, i, __ATOMIC_RELAXED);
-}
-
-/**
- * __atomic_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns the old value of @v.
- */
-static __always_inline int __atomic_add_unless(atomic_t *v,
-					       int addend, int unless)
-{
-	int c = atomic_read(v);
-
-	while (likely(c != unless)) {
-		if (__atomic_compare_exchange_n(&v->counter,
-						&c, c + addend,
-						false,
-						__ATOMIC_SEQ_CST,
-						__ATOMIC_RELAXED))
-			break;
-	}
-	return c;
-}
-
-/**
- * atomic_add_unless - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns true if @v was not @u, and false otherwise.
- */
-static __always_inline bool atomic_add_unless(atomic_t *v,
-					      int addend, int unless)
-{
-	int c = atomic_read(v);
-
-	while (likely(c != unless)) {
-		if (__atomic_compare_exchange_n(&v->counter,
-						&c, c + addend,
-						false,
-						__ATOMIC_SEQ_CST,
-						__ATOMIC_RELAXED))
-			return true;
-	}
-	return false;
-}
-
-#define atomic_inc_not_zero(v)		atomic_add_unless((v), 1, 0)
-
-/**
- * atomic_add_unless_hint - add unless the number is already a given value
- * @v: pointer of type atomic_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- * @hint: probable value of the atomic before the increment
- *
- * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns the old value of @v.
- */
-static __always_inline int __atomic_add_unless_hint(atomic_t *v,
-						    int addend, int unless,
-						    int hint)
-{
-	int c = hint;
-
-	while (likely(c != unless)) {
-		if (__atomic_compare_exchange_n(&v->counter,
-						&c, c + addend,
-						false,
-						__ATOMIC_SEQ_CST,
-						__ATOMIC_RELAXED))
-			break;
-	}
-	return c;
-}
-
-#define atomic_inc_not_zero_hint(v, h)	(__atomic_add_unless_hint((v), 1, 0, (h)) != 0)
-
-static inline bool atomic_inc_unless_negative(atomic_t *v)
-{
-	int c = 0;
-
-	while (likely(c >= 0)) {
-		if (__atomic_compare_exchange_n(&v->counter,
-						&c, c + 1,
-						false,
-						__ATOMIC_SEQ_CST,
-						__ATOMIC_RELAXED))
-			return true;
-	}
-	return false;
-}
-
-static inline bool atomic_dec_unless_positive(atomic_t *v)
-{
-	int c = 0;
-
-	while (likely(c <= 0)) {
-		if (__atomic_compare_exchange_n(&v->counter,
-						&c, c - 1,
-						false,
-						__ATOMIC_SEQ_CST,
-						__ATOMIC_RELAXED))
-			return true;
-	}
-	return false;
-}
-
-/*
- * atomic_dec_if_positive - decrement by 1 if old value positive
- * @v: pointer of type atomic_t
- *
- * The function returns the old value of *v minus 1, even if
- * the atomic variable, v, was not decremented.
- */
-static inline bool atomic_dec_if_positive(atomic_t *v)
-{
-	int c = atomic_read(v);
-
-	while (likely(c > 0)) {
-		if (__atomic_compare_exchange_n(&v->counter,
-						&c, c - 1,
-						false,
-						__ATOMIC_SEQ_CST,
-						__ATOMIC_RELAXED))
-			return true;
-	}
-	return false;
-}
-
-/**
- * atomic_fetch_or - perform *v |= mask and return old value of *v
- * @v: pointer to atomic_t
- * @mask: mask to OR on the atomic_t
- */
-static inline int atomic_fetch_or(atomic_t *v, int mask)
-{
-	return __atomic_fetch_or(&v->counter, mask, __ATOMIC_SEQ_CST);
-}
-
-/**
- * atomic_inc_short - increment of a short integer
- * @v: pointer to type int
- *
- * Atomically adds 1 to @v
- * Returns the new value of @v
- */
-static __always_inline short int atomic_inc_short(short int *v)
-{
-	return __atomic_add_fetch(v, 1, __ATOMIC_SEQ_CST);
-}
+#define atomic_val int
+#define atomic_prefix(x) atomic##x
+#define __atomic_prefix(x) __atomic##x
+#include <asm-generic/iso-atomic-template.h>
+#undef atomic_val
+#undef atomic_prefix
+#undef __atomic_prefix
 
 #endif /* _ASM_GENERIC_ISO_ATOMIC_H */

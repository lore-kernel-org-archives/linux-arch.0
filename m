From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 07/15] Provide cmpxchg(), xchg(),
 xadd() and __add() based on ISO C++11 intrinsics
Date: Wed, 18 May 2016 16:11:30 +0100
Message-ID: <146358429016.8596.3381723959064491676.stgit@warthog.procyon.org.uk>
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

Provide implementations of cmpxchg(), xchg(), xadd() and __add() using ISO
C++11 intrinsics.  Also provide variants with less strong ordering.

The __atomic_compare_exchange_n() function returns a bool indicating
whether or not the exchange took place.  On x86, for example, the CMPXCHG
instruction sticks this value into the Z flag and using the bool return
allows the compiler to use this value directly.  I've added two new macros
for this:

 (1) bool cmpxchg_return(TYPE *ptr, TYPE old, TYPE new, TYPE *_orig)

     This is like cmpxchg() except that the current value is returned in
     *_orig and true is returned if the exchange happens, false otherwise.

 (2) bool try_cmpxchg(TYPE *ptr, TYPE old, TYPE new)

     Like cmpxchg_return() except that the current value is discarded.

I've marked cmpxchg() as deprecated as the compiler generates better code
if it is allowed to use the extra bit of information rather than comparing
old with the current value.

To illustrate the differences on x86_64, I compiled the following with -Os
and -fomit-frame-pointer:

	const char *kernel_cmpxchg(long *ptr, long old, long new)
	{
		long cur;
		cur = cmpxchg(ptr, old, new);
		return cur == old ? "foo" : "bar";
	}

	#define ISO__try_cmpxchg(ptr, old, new, mem)			\
	({								\
		__typeof__((ptr)) __ptr = (ptr);			\
		__typeof__(*__ptr) __orig;				\
		__atomic_compare_exchange_n(__ptr,			\
					    &__orig, (new),		\
					    false,			\
					    mem,			\
					    __ATOMIC_RELAXED);		\
	})
	#define ISO_try_cmpxchg(ptr, old, new) \
		ISO__try_cmpxchg((ptr), (old), (new), __ATOMIC_SEQ_CST)
	const char *iso_try_cmpxchg(long *ptr, long old, long new)
	{
		return ISO_try_cmpxchg(ptr, old, new) ? "foo" : "bar";
	}

which gives:

	kernel_cmpxchg:
		mov    %rsi,%rax
		lock cmpxchg %rdx,(%rdi)
		mov    $.LC1,%edx
		cmp    %rax,%rsi		<--- Redundant instruction
		mov    $.LC0,%eax
		cmovne %rdx,%rax
		retq

	iso_cmpxchg_return:
		mov    %rsi,%rax
		mov    %rsi,-0x8(%rsp)		<--- Unoptimisation
		lock cmpxchg %rdx,(%rdi)
		mov    $.LC1,%edx
		mov    $.LC0,%eax
		cmovne %rdx,%rax
		retq

As can be seen, barring an unoptimisation, the ISO try_cmpxchg() code can
dispense with the CMP instruction required for the kernel inline asm and
use the Z flag resulting from the CMPXCHG directly.

This unoptimisation is an issus in gcc's __atomic_compare_exchange[_n]() on
several arches, including x86, arm64 and powerpc64, whereby it tries to use
the stack to pass the old value rather than bunging this into a register.

This appears to be because __atomic_compare_exchange[_n]() returns a bool
indicating whether the exchange happened or not and passes back the current
value read from the memory variable through a pointer in the argument list.

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70825

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/iso-cmpxchg.h |  180 +++++++++++++++++++++++++++++++++++++
 include/linux/atomic.h            |    3 +
 2 files changed, 183 insertions(+)
 create mode 100644 include/asm-generic/iso-cmpxchg.h

diff --git a/include/asm-generic/iso-cmpxchg.h b/include/asm-generic/iso-cmpxchg.h
new file mode 100644
index 000000000000..c84e213c0b6b
--- /dev/null
+++ b/include/asm-generic/iso-cmpxchg.h
@@ -0,0 +1,180 @@
+/* Use ISO C++11 intrinsics to implement cmpxchg() and xchg().
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
+#ifndef _ASM_GENERIC_ISO_CMPXCHG_H
+#define _ASM_GENERIC_ISO_CMPXCHG_H
+
+/**
+ * cmpxchg_return - Check variable and replace if expected value.
+ * @ptr: Pointer to target variable
+ * @old: The value to check for
+ * @new: The value to replace with
+ * @_orig: A pointer to a variable in which to place the current value
+ *
+ * Atomically checks the contents of *@ptr, and if the same as @old, replaces
+ * it with @new.  Return true if the exchange happened, false if it didn't.
+ * The original value read from *@ptr is stored in *@_orig.
+ *
+ * gcc can generate better code if it gets to use the result of the intrinsic
+ * to decide what to do, so this and try_cmpxchg() are preferred to cmpxchg().
+ */
+#define iso_cmpxchg_return(ptr, old, new, _orig, mem)			\
+	({								\
+		__typeof__((_orig)) __orig = (_orig);			\
+		*__orig = (old);					\
+		__atomic_compare_exchange_n((ptr),			\
+					    __orig, (new),		\
+					    false,			\
+					    mem,			\
+					    __ATOMIC_RELAXED);		\
+	})
+
+#define cmpxchg_return(ptr, old, new, _orig) \
+	iso_cmpxchg_return((ptr), (old), (new), (_orig), __ATOMIC_SEQ_CST)
+
+#define cmpxchg_return_relaxed(ptr, old, new, _orig) \
+	iso_cmpxchg_return((ptr), (old), (new), (_orig), __ATOMIC_RELAXED)
+
+#define cmpxchg_return_acquire(ptr, old, new, _orig) \
+	iso_cmpxchg_return((ptr), (old), (new), (_orig), __ATOMIC_ACQUIRE)
+
+#define cmpxchg_return_release(ptr, old, new, _orig) \
+	iso_cmpxchg_return((ptr), (old), (new), (_orig), __ATOMIC_RELEASE)
+
+/**
+ * try_cmpxchg - Check variable and replace if expected value.
+ * @ptr: Pointer to variable
+ * @old: The value to check for
+ * @new: The value to replace with
+ *
+ * Atomically checks the contents of *@ptr and, if the same as @old, replaces
+ * it with @new.  Return true if the exchange happened, false if it didn't.
+ * The value read from *@ptr is discarded.
+ */
+#define iso_try_cmpxchg(ptr, old, new, mem)				\
+	({								\
+		__typeof__((ptr)) __ptr = (ptr);			\
+		__typeof__(*__ptr) __orig;				\
+		__atomic_compare_exchange_n(__ptr,			\
+					    &__orig, (new),		\
+					    false,			\
+					    mem,			\
+					    __ATOMIC_RELAXED);		\
+	})
+
+#define try_cmpxchg(ptr, old, new) \
+	iso_try_cmpxchg((ptr), (old), (new), __ATOMIC_SEQ_CST)
+
+#define try_cmpxchg_relaxed(ptr, old, new) \
+	iso_try_cmpxchg((ptr), (old), (new), __ATOMIC_RELAXED)
+
+#define try_cmpxchg_acquire(ptr, old, new) \
+	iso_try_cmpxchg((ptr), (old), (new), __ATOMIC_ACQUIRE)
+
+#define try_cmpxchg_release(ptr, old, new) \
+	iso_try_cmpxchg((ptr), (old), (new), __ATOMIC_RELEASE)
+
+/**
+ * cmpxchg - Check variable and replace if expected value.
+ * @ptr: Pointer to target variable
+ * @old: The value to check for
+ * @new: The value to replace with
+ *
+ * Atomically checks the contents of *@ptr and, if the same as @old, replaces
+ * it with @new.  The value read from *@ptr is returned.
+ *
+ * try_cmpxchg() and cmpxchg_return() are preferred to this function as they
+ * can make better use of the knowledge as to whether a write took place or not
+ * that is provided by some CPUs (e.g. x86's CMPXCHG instruction stores this in
+ * the Z flag).
+ */
+static inline __deprecated void cmpxchg__use_cmpxchg_return_instead(void) { }
+
+#define iso_cmpxchg(ptr, old, new, mem)					\
+	({								\
+		__typeof__((ptr)) __ptr = (ptr);			\
+		__typeof__(*__ptr) __old = (old);			\
+		__typeof__(*__ptr) __orig = __old;			\
+		cmpxchg__use_cmpxchg_return_instead();			\
+		__atomic_compare_exchange_n(__ptr,			\
+					    &__orig, (new),		\
+					    false,			\
+					    mem,			\
+					    __ATOMIC_RELAXED) ?		\
+			__old : __orig;					\
+	})
+
+#define cmpxchg(ptr, old, new)		iso_cmpxchg((ptr), (old), (new), __ATOMIC_SEQ_CST)
+#define cmpxchg_relaxed(ptr, old, new)	iso_cmpxchg((ptr), (old), (new), __ATOMIC_RELAXED)
+#define cmpxchg_acquire(ptr, old, new)	iso_cmpxchg((ptr), (old), (new), __ATOMIC_ACQUIRE)
+#define cmpxchg_release(ptr, old, new)	iso_cmpxchg((ptr), (old), (new), __ATOMIC_RELEASE)
+
+#define cmpxchg64(ptr, old, new)	 cmpxchg((ptr), (old), (new))
+#define cmpxchg64_relaxed(ptr, old, new) cmpxchg_relaxed((ptr), (old), (new))
+#define cmpxchg64_acquire(ptr, old, new) cmpxchg_acquire((ptr), (old), (new))
+#define cmpxchg64_release(ptr, old, new) cmpxchg_release((ptr), (old), (new))
+
+/**
+ * xchg - Exchange the contents of a variable for a new value
+ * @ptr: Pointer to target variable
+ * @new: The new value to place in @ptr
+ *
+ * Atomically read the contents of *@ptr and then replace those contents with
+ * @new.  The value initially read from *@ptr is returned.
+ */
+#define iso_xchg(ptr, new, mem)						\
+	({								\
+		__atomic_exchange_n((ptr), (new), mem);			\
+	})
+
+#define xchg(ptr, new)		iso_xchg((ptr), (new), __ATOMIC_SEQ_CST)
+#define xchg_relaxed(ptr, new)	iso_xchg((ptr), (new), __ATOMIC_RELAXED)
+#define xchg_acquire(ptr, new)	iso_xchg((ptr), (new), __ATOMIC_ACQUIRE)
+#define xchg_release(ptr, new)	iso_xchg((ptr), (new), __ATOMIC_RELEASE)
+
+/**
+ * xadd - Exchange the contents of a variable for a those contents plus a value
+ * @ptr: Pointer to target variable
+ * @addend: The value to add to *@ptr
+ *
+ * Atomically read the contents of *@ptr and then replace those contents with
+ * that value plus @addend.  The value initially read from *@ptr is returned.
+ */
+#define iso_xadd(ptr, addend, mem)					\
+	({								\
+		__atomic_fetch_add((ptr), (addend), mem);		\
+	})
+
+#define xadd(ptr, new)		iso_xadd((ptr), (new), __ATOMIC_SEQ_CST)
+#define xadd_relaxed(ptr, new)	iso_xadd((ptr), (new), __ATOMIC_RELAXED)
+#define xadd_acquire(ptr, new)	iso_xadd((ptr), (new), __ATOMIC_ACQUIRE)
+#define xadd_release(ptr, new)	iso_xadd((ptr), (new), __ATOMIC_RELEASE)
+
+/**
+ * add_smp - Atomically add a value to a variable
+ * @ptr: Pointer to target variable
+ * @addend: The value to add to *@ptr
+ *
+ * Atomically add the @addend to the contents of *@ptr.
+ *
+ * Note that the zeroness and sign of the result can be returned free of charge
+ * on some arches by comparing against zero.
+ */
+#define iso_add(ptr, addend, mem)					\
+	({								\
+		__atomic_fetch_add((ptr), (addend), mem);		\
+	})
+
+#define __add(ptr, new)		iso_add((ptr), (new), __ATOMIC_SEQ_CST)
+#define add_release(ptr, new)	iso_add((ptr), (new), __ATOMIC_RELEASE)
+#define add_smp(ptr, new)	iso_add((ptr), (new), __ATOMIC_SEQ_CST)
+
+#endif /* _ASM_GENERIC_ISO_CMPXCHG_H */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 18709106065a..711ad161a9a2 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -372,6 +372,8 @@
 
 #endif /* !_ASM_GENERIC_ISO_ATOMIC64_H */
 
+#ifndef _ASM_GENERIC_ISO_CMPXCHG_H
+
 /* cmpxchg_relaxed */
 #ifndef cmpxchg_relaxed
 #define  cmpxchg_relaxed		cmpxchg
@@ -441,6 +443,7 @@
 #endif
 #endif /* xchg_relaxed */
 
+#endif /* !_ASM_GENERIC_ISO_CMPXCHG_H */
 
 #ifndef _ASM_GENERIC_ISO_ATOMIC_H
 

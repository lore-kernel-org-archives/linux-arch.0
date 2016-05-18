From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Wed, 18 May 2016 16:10:59 +0100
Message-ID: <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
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

Provide an implementation of the atomic_t functions implemented with
ISO-C++11 atomics.  This has some advantages over using inline assembly:

 (1) The compiler has a much better idea of what is going on and can
     optimise appropriately, whereas with inline assembly, the content is
     an indivisible black box as far as the compiler is concerned.

     For example, with powerpc64, the compiler can put the barrier in a
     potentially more favourable position.  Take the inline-asm variant of
     test_and_set_bit() - this has to (a) generate a mask and an address
     and (b) interpolate a memory barrier before doing the atomic ops.

     Here's a disassembly of the current inline-asm variant and then the
     ISO variant:

	.current_test_and_set_bit:
		clrlwi  r10,r3,26	}
		rldicl  r3,r3,58,6	} Fiddling with regs to make
		rldicr  r3,r3,3,60	} mask and address
		li      r9,1		}
		sld     r9,r9,r10	}
		add     r4,r4,r3	}
		hwsync			<--- Release barrier
	retry:	ldarx   r3,0,r4			}
		or      r10,r3,r9		} Atomic region
		stdcx.  r10,0,r4		}
		bne-    retry			}
		hwsync			<--- Acquire barrier
		and     r9,r9,r3
		addic   r3,r9,-1
		subfe   r3,r3,r9
		blr

	.iso_test_and_set_bit:
		hwsync			<--- Release barrier
		clrlwi  r10,r3,26	}
		sradi   r3,r3,6		} Fiddling with regs to make
		li      r9,1		} mask and address
		rldicr  r3,r3,3,60	}
		sld     r9,r9,r10	}
		add     r4,r4,r3	}
	retry:	ldarx   r3,0,r4			}
		or      r10,r3,r9		} Atomic region
		stdcx.  r10,0,r4		}
		bne     retry			}
		isync			<--- Acquire barrier
		and     r9,r9,r3
		addic   r3,r9,-1
		subfe   r3,r3,r9
		blr

     Moving the barrier up in the ISO case would seem to give the CPU a
     better chance of doing the barrier simultaneously with the register
     fiddling.

     Things to note here:

     (a) A BNE rather than a BNE- is emitted after the STDCX instruction.
     	 I've logged this as:

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71162

     (b) An ISYNC instruction is emitted as the Acquire barrier with
     	 __ATOMIC_SEQ_CST, but I'm not sure this is strong enough.

     (c) An LWSYNC instruction is emitted as the Release barrier with
     	 __ATOMIC_ACQ_REL or __ATOMIC_RELEASE.  Is this strong enough that
     	 we could use these memorders instead?


 (2) The compiler can pick the appropriate instruction to use, depending on
     the size of the memory location, the operation being applied, the
     value of the operand being applied (if applicable), whether the return
     value is used and whether any condition flags resulting from the
     atomic op are used.

     For instance, on x86_64, atomic_add() can use any of ADDL, SUBL, INCL,
     DECL, XADDL or CMPXCHGL.  atomic_add_return() can use ADDL, SUBL, INCL
     or DECL if we only about the representation of the return value
     encoded in the flags (zero, carry, sign).  If we actually want the
     return value, atomic_add_return() will use XADDL.

     So with __atomic_fetch_add(), if the return value isn't being used and
     if the operand is 1, INCL will be used; if >1, ADDL will be used; if
     -1, DECL will be used; and if <-1, SUBL will be used.

     Things to note here:

     (a) If unpatched, gcc will emit an XADDL instruction rather than a
     	 DECL instruction if it is told to subtract 1.

		https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70821

     (b) The x86 arch keeps a list of LOCK prefixes and NOP's them out when
     	 only one CPU is online, but gcc doesn't do this yet.

		https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70973


 (3) The compiler can make use of extra information provided by the atomic
     instructions involved that can't otherwise be passed out of inline
     assembly - such as the condition flag values.

     Take atomic_dec_and_test(), for example.  I can call it as follows:

	const char *xxx_atomic_dec_and_test(atomic_t *counter)
	{
		if (atomic_dec_and_test(counter))
			return "foo";
		return "bar";
	}

     For original, non-asm-goto code, I see:

	nogoto_atomic_dec_and_test:
		lock decl (%rdi)
		sete   %al
		mov    $.LC1,%edx
		test   %al,%al
		mov    $.LC0,%eax
		cmove  %rdx,%rax
		retq

     This has a SETE instruction inside the inline assembly to save the
     condition flag value and a TEST outside to move it the state back to
     the condition flag.

     For the newer asm-goto code, I see:

	goto_atomic_dec_and_test:
		lock decl (%rdi)
		je     b <goto_atomic_dec_and_test+0xb>
		mov    $.LC1,%eax
		retq
		mov    $.LC0,%eax
		retq

     This has a conditional jump in it inside the inline assembly and
     leaves the inline assembly through one of two different paths.

     Using ISO intrinsics, I see:

	iso_atomic_dec_and_test:
		lock decl (%rdi)
		mov    $.LC1,%edx
		mov    $.LC0,%eax
		cmove  %rdx,%rax
		retq

     Here the compiler can use the condition code in what it deems the best
     way possible - in this case through the use of a CMOVE instruction,
     hopefully thereby making more efficient code.

     At some point gcc might acquire the ability to pass values out of
     inline assembly as condition flags.


 (4) The __atomic_*() intrinsic functions act like a C++ template function
     in that they don't have specific types for the arguments, rather the
     types are determined on a case-by-case basis, presumably from the type
     of the memory variable.

     This means that the compiler will automatically switch, say, for
     __atomic_fetch_add() on x86 between INCB, INCW, INCL, INCQ, ADDB,
     ADDW, ADDL, ADDQ, XADDB, XADDW, XADDL, XADDQ, CMPXCHG8 and CMPXCHG16.


However, using the ISO C++ intrinsics has drawbacks too: most importantly,
the memory model ordering is weaker than that implied by the kernel's
memory-barriers.txt as the C++11 standard limits the effect of an atomic
intrinsic with a release barrier followed by one with an acquire barrier to
only being applicable to each other *if* the associated memory location is
the same in both cases.

This could mean that, if spinlocks were implemented with C++11 atomics, then:

	spin_lock(a);
	spin_unlock(a);
	// <---- X
	spin_lock(b);
	spin_unlock(b);

would not get an implicit full memory barrier at point X in C++11, but does
in the kernel through the interaction of the unlock and lock either side of
it.

Now, the practical side of this is very much arch-dependent.  On x86, for
example, this probably doesn't matter because the LOCK'd instructions imply
full memory barriers, so it should be possible to switch x86, for example,
over to using this.

However, on something like arm64 with LSE instructions, this is a more
ticklish prospect since the LSE instructions take specifiers as to whether
they imply acquire, release, neither or both barriers *and* an address,
thereby permitting the CPU to conform to the C++11 model.

Another issue with acquire/release barriers is that not all arches
implement them.  arm64 does, as does ia64; but some other arches - arm32
for example - implement load/store barriers instead which aren't the same
thing.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/iso-atomic.h |  401 ++++++++++++++++++++++++++++++++++++++
 include/linux/atomic.h           |   14 +
 2 files changed, 413 insertions(+), 2 deletions(-)
 create mode 100644 include/asm-generic/iso-atomic.h

diff --git a/include/asm-generic/iso-atomic.h b/include/asm-generic/iso-atomic.h
new file mode 100644
index 000000000000..dfb1f2b188f9
--- /dev/null
+++ b/include/asm-generic/iso-atomic.h
@@ -0,0 +1,401 @@
+/* Use ISO C++11 intrinsics to implement 32-bit atomic ops.
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
+#ifndef _ASM_GENERIC_ISO_ATOMIC_H
+#define _ASM_GENERIC_ISO_ATOMIC_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <asm/cmpxchg.h>
+#include <asm/barrier.h>
+
+#define ATOMIC_INIT(i)	{ (i) }
+
+/**
+ * atomic_read - read atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * Atomically reads the value of @v.
+ */
+static __always_inline int __atomic_read(const atomic_t *v, int memorder)
+{
+	return __atomic_load_n(&v->counter, memorder);
+}
+#define atomic_read(v)		(__atomic_read((v), __ATOMIC_RELAXED))
+#define atomic_read_acquire(v)	(__atomic_read((v), __ATOMIC_ACQUIRE))
+
+/**
+ * atomic_set - set atomic variable
+ * @v: pointer of type atomic_t
+ * @i: required value
+ *
+ * Atomically sets the value of @v to @i.
+ */
+static __always_inline void __atomic_set(atomic_t *v, int i, int memorder)
+{
+	__atomic_store_n(&v->counter, i, memorder);
+}
+#define atomic_set(v, i)	 __atomic_set((v), (i), __ATOMIC_RELAXED)
+#define atomic_set_release(v, i) __atomic_set((v), (i), __ATOMIC_RELEASE)
+
+/**
+ * atomic_add - add integer to atomic variable
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v.
+ */
+static __always_inline void atomic_add(int i, atomic_t *v)
+{
+	__atomic_add_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+#define atomic_inc(v) atomic_add(1, (v))
+
+/**
+ * atomic_sub - subtract integer from atomic variable
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtracts @i from @v.
+ */
+static __always_inline void atomic_sub(int i, atomic_t *v)
+{
+	__atomic_sub_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+#define atomic_dec(v) atomic_add(-1, (v))
+
+/**
+ * atomic_add_return - add integer and return
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns @i + @v.
+ */
+static __always_inline int __atomic_add_return(int i, atomic_t *v, int memorder)
+{
+	return __atomic_add_fetch(&v->counter, i, memorder);
+}
+
+#define atomic_add_return(i, v)		(__atomic_add_return((i), (v), __ATOMIC_SEQ_CST))
+#define atomic_add_negative(i, v)	(atomic_add_return((i), (v)) < 0)
+#define atomic_inc_return(v)		(atomic_add_return(1, (v)))
+#define atomic_inc_and_test(v)		(atomic_add_return(1, (v)) == 0)
+
+#define atomic_add_return_relaxed(i, v)	(__atomic_add_return((i), (v), __ATOMIC_RELAXED))
+#define atomic_inc_return_relaxed(v)	(atomic_add_return_relaxed(1, (v)))
+
+#define atomic_add_return_acquire(i, v)	(__atomic_add_return((i), (v), __ATOMIC_ACQUIRE))
+#define atomic_inc_return_acquire(v)	(atomic_add_return_acquire(1, (v)))
+
+#define atomic_add_return_release(i, v)	(__atomic_add_return((i), (v), __ATOMIC_RELEASE))
+#define atomic_inc_return_release(v)	(atomic_add_return_release(1, (v)))
+
+/**
+ * atomic_sub_return - subtract integer and return
+ * @v: pointer of type atomic_t
+ * @i: integer value to subtract
+ *
+ * Atomically subtracts @i from @v and returns @v - @i
+ */
+static __always_inline int __atomic_sub_return(int i, atomic_t *v, int memorder)
+{
+	return __atomic_sub_fetch(&v->counter, i, memorder);
+}
+
+#define atomic_sub_return(i, v)		(__atomic_sub_return((i), (v), __ATOMIC_SEQ_CST))
+#define atomic_sub_and_test(i, v)	(atomic_sub_return((i), (v)) == 0)
+#define atomic_dec_return(v)		(atomic_sub_return(1, (v)))
+#define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
+
+#define atomic_sub_return_relaxed(i, v)	(__atomic_sub_return((i), (v), __ATOMIC_RELAXED))
+#define atomic_dec_return_relaxed(v)	(atomic_sub_return_relaxed(1, (v)))
+
+#define atomic_sub_return_acquire(i, v)	(__atomic_sub_return((i), (v), __ATOMIC_ACQUIRE))
+#define atomic_dec_return_acquire(v)	(atomic_sub_return_acquire(1, (v)))
+
+#define atomic_sub_return_release(i, v)	(__atomic_sub_return((i), (v), __ATOMIC_RELEASE))
+#define atomic_dec_return_release(v)	(atomic_sub_return_release(1, (v)))
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
+bool __atomic_try_cmpxchg(atomic_t *v, int old, int new, int memorder)
+{
+	int cur = old;
+	return __atomic_compare_exchange_n(&v->counter, &cur, new, false,
+					   memorder, __ATOMIC_RELAXED);
+}
+
+#define atomic_try_cmpxchg(v, o, n) \
+	(__atomic_try_cmpxchg((v), (o), (n), __ATOMIC_SEQ_CST))
+#define atomic_try_cmpxchg_relaxed(v, o, n) \
+	(__atomic_try_cmpxchg((v), (o), (n), __ATOMIC_RELAXED))
+#define atomic_try_cmpxchg_acquire(v, o, n) \
+	(__atomic_try_cmpxchg((v), (o), (n), __ATOMIC_ACQUIRE))
+#define atomic_try_cmpxchg_release(v, o, n) \
+	(__atomic_try_cmpxchg((v), (o), (n), __ATOMIC_RELEASE))
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
+bool __atomic_cmpxchg_return(atomic_t *v, int old, int new, int *_orig, int memorder)
+{
+	*_orig = old;
+	return __atomic_compare_exchange_n(&v->counter, _orig, new, false,
+					   memorder, __ATOMIC_RELAXED);
+}
+
+#define atomic_cmpxchg_return(v, o, n, _o) \
+	(__atomic_cmpxchg_return((v), (o), (n), (_o), __ATOMIC_SEQ_CST))
+#define atomic_cmpxchg_return_relaxed(v, o, n, _o) \
+	(__atomic_cmpxchg_return((v), (o), (n), (_o), __ATOMIC_RELAXED))
+#define atomic_cmpxchg_return_acquire(v, o, n, _o) \
+	(__atomic_cmpxchg_return((v), (o), (n), (_o), __ATOMIC_ACQUIRE))
+#define atomic_cmpxchg_return_release(v, o, n, _o) \
+	(__atomic_cmpxchg_return((v), (o), (n), (_o), __ATOMIC_RELEASE))
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
+static __always_inline int __atomic_cmpxchg(atomic_t *v, int old, int new,
+					    int memorder)
+{
+	int cur = old;
+	if (__atomic_compare_exchange_n(&v->counter, &cur, new, false,
+					memorder, __ATOMIC_RELAXED))
+		return old;
+	return cur;
+}
+
+#define atomic_cmpxchg(v, o, n)		(__atomic_cmpxchg((v), (o), (n), __ATOMIC_SEQ_CST))
+#define atomic_cmpxchg_relaxed(v, o, n)	(__atomic_cmpxchg((v), (o), (n), __ATOMIC_RELAXED))
+#define atomic_cmpxchg_acquire(v, o, n)	(__atomic_cmpxchg((v), (o), (n), __ATOMIC_ACQUIRE))
+#define atomic_cmpxchg_release(v, o, n)	(__atomic_cmpxchg((v), (o), (n), __ATOMIC_RELEASE))
+
+static __always_inline int __atomic_xchg(atomic_t *v, int new, int memorder)
+{
+	return __atomic_exchange_n(&v->counter, new, memorder);
+}
+
+#define atomic_xchg(v, new)		(__atomic_xchg((v), (new), __ATOMIC_SEQ_CST))
+#define atomic_xchg_relaxed(v, new)	(__atomic_xchg((v), (new), __ATOMIC_RELAXED))
+#define atomic_xchg_acquire(v, new)	(__atomic_xchg((v), (new), __ATOMIC_ACQUIRE))
+#define atomic_xchg_release(v, new)	(__atomic_xchg((v), (new), __ATOMIC_RELEASE))
+
+static __always_inline void atomic_and(int i, atomic_t *v)
+{
+	__atomic_and_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+static __always_inline void atomic_andnot(int i, atomic_t *v)
+{
+	__atomic_and_fetch(&v->counter, ~i, __ATOMIC_RELAXED);
+}
+
+static __always_inline void atomic_or(int i, atomic_t *v)
+{
+	__atomic_or_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+static __always_inline void atomic_xor(int i, atomic_t *v)
+{
+	__atomic_xor_fetch(&v->counter, i, __ATOMIC_RELAXED);
+}
+
+/**
+ * __atomic_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns the old value of @v.
+ */
+static __always_inline int __atomic_add_unless(atomic_t *v,
+					       int addend, int unless)
+{
+	int c = atomic_read(v);
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
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns true if @v was not @u, and false otherwise.
+ */
+static __always_inline bool atomic_add_unless(atomic_t *v,
+					      int addend, int unless)
+{
+	int c = atomic_read(v);
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
+#define atomic_inc_not_zero(v)		atomic_add_unless((v), 1, 0)
+
+/**
+ * atomic_add_unless_hint - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ * @hint: probable value of the atomic before the increment
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns the old value of @v.
+ */
+static __always_inline int __atomic_add_unless_hint(atomic_t *v,
+						    int addend, int unless,
+						    int hint)
+{
+	int c = hint;
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
+#define atomic_inc_not_zero_hint(v, h)	(__atomic_add_unless_hint((v), 1, 0, (h)) != 0)
+
+static inline bool atomic_inc_unless_negative(atomic_t *v)
+{
+	int c = 0;
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
+static inline bool atomic_dec_unless_positive(atomic_t *v)
+{
+	int c = 0;
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
+ * @v: pointer of type atomic_t
+ *
+ * The function returns the old value of *v minus 1, even if
+ * the atomic variable, v, was not decremented.
+ */
+static inline bool atomic_dec_if_positive(atomic_t *v)
+{
+	int c = atomic_read(v);
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
+ * @v: pointer to atomic_t
+ * @mask: mask to OR on the atomic_t
+ */
+static inline int atomic_fetch_or(atomic_t *v, int mask)
+{
+	return __atomic_fetch_or(&v->counter, mask, __ATOMIC_SEQ_CST);
+}
+
+/**
+ * atomic_inc_short - increment of a short integer
+ * @v: pointer to type int
+ *
+ * Atomically adds 1 to @v
+ * Returns the new value of @v
+ */
+static __always_inline short int atomic_inc_short(short int *v)
+{
+	return __atomic_add_fetch(v, 1, __ATOMIC_SEQ_CST);
+}
+
+#endif /* _ASM_GENERIC_ISO_ATOMIC_H */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 506c3531832e..64d2b7492ad6 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -4,6 +4,8 @@
 #include <asm/atomic.h>
 #include <asm/barrier.h>
 
+#ifndef _ASM_GENERIC_ISO_ATOMIC_H
+
 /*
  * Relaxed variants of xchg, cmpxchg and some atomic operations.
  *
@@ -211,6 +213,9 @@
 #endif
 #endif /* atomic_cmpxchg_relaxed */
 
+#endif /* _ASM_GENERIC_ISO_ATOMIC_H */
+
+
 #ifndef atomic64_read_acquire
 #define  atomic64_read_acquire(v)	smp_load_acquire(&(v)->counter)
 #endif
@@ -433,6 +438,9 @@
 #endif
 #endif /* xchg_relaxed */
 
+
+#ifndef _ASM_GENERIC_ISO_ATOMIC_H
+
 /**
  * atomic_add_unless - add unless the number is already a given value
  * @v: pointer of type atomic_t
@@ -440,9 +448,9 @@
  * @u: ...unless v is equal to u.
  *
  * Atomically adds @a to @v, so long as @v was not already @u.
- * Returns non-zero if @v was not @u, and zero otherwise.
+ * Returns true if @v was not @u, and false otherwise.
  */
-static inline int atomic_add_unless(atomic_t *v, int a, int u)
+static inline bool atomic_add_unless(atomic_t *v, int a, int u)
 {
 	return __atomic_add_unless(v, a, u) != u;
 }
@@ -579,6 +587,8 @@ static inline int atomic_fetch_or(atomic_t *p, int mask)
 }
 #endif
 
+#endif /* _ASM_GENERIC_ISO_ATOMIC_H */
+
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif

From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Tue,  4 Jul 2017 12:50:55 -0700
Message-ID: <20170704195102.3974-3-palmer__13327.7998575524$1499198047$gmane$org@dabbelt.com>
References: <20170704195102.3974-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33099 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbdGDTv0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2017 15:51:26 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so31769200pfh.0
        for <linux-arch@vger.kernel.org>; Tue, 04 Jul 2017 12:51:26 -0700 (PDT)
In-Reply-To: <20170704195102.3974-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>

This contains all the code that directly interfaces with the RISC-V
memory model.  While this code corforms to the current RISC-V ISA
specifications (user 2.2 and priv 1.10), the memory model is somewhat
underspecified in those documents.  There is a working group that hopes
to produce a formal memory model by the end of the year, but my
understanding is that the basic definitions we're relying on here won't
change significantly.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/atomic.h         | 337 ++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/barrier.h        | 143 ++++++++++++++
 arch/riscv/include/asm/bitops.h         | 228 +++++++++++++++++++++
 arch/riscv/include/asm/cacheflush.h     |  39 ++++
 arch/riscv/include/asm/cmpxchg.h        | 138 +++++++++++++
 arch/riscv/include/asm/io.h             | 180 +++++++++++++++++
 arch/riscv/include/asm/spinlock.h       | 167 ++++++++++++++++
 arch/riscv/include/asm/spinlock_types.h |  33 ++++
 arch/riscv/include/asm/tlb.h            |  24 +++
 arch/riscv/include/asm/tlbflush.h       |  64 ++++++
 10 files changed, 1353 insertions(+)
 create mode 100644 arch/riscv/include/asm/atomic.h
 create mode 100644 arch/riscv/include/asm/barrier.h
 create mode 100644 arch/riscv/include/asm/bitops.h
 create mode 100644 arch/riscv/include/asm/cacheflush.h
 create mode 100644 arch/riscv/include/asm/cmpxchg.h
 create mode 100644 arch/riscv/include/asm/io.h
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 arch/riscv/include/asm/spinlock_types.h
 create mode 100644 arch/riscv/include/asm/tlb.h
 create mode 100644 arch/riscv/include/asm/tlbflush.h

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
new file mode 100644
index 000000000000..e5a12cfa405a
--- /dev/null
+++ b/arch/riscv/include/asm/atomic.h
@@ -0,0 +1,337 @@
+/*
+ * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#ifndef _ASM_RISCV_ATOMIC_H
+#define _ASM_RISCV_ATOMIC_H
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+# include <asm-generic/atomic64.h>
+#else
+# if (__riscv_xlen < 64)
+#  error "64-bit atomics require XLEN to be at least 64"
+# endif
+#endif
+
+#ifdef CONFIG_ISA_A
+
+#include <asm/cmpxchg.h>
+#include <asm/barrier.h>
+
+#define ATOMIC_INIT(i)	{ (i) }
+static __always_inline int atomic_read(const atomic_t *v)
+{
+	return READ_ONCE(v->counter);
+}
+static __always_inline void atomic_set(atomic_t *v, int i)
+{
+	WRITE_ONCE(v->counter, i);
+}
+
+#ifndef CONFIG_GENERIC_ATOMIC64
+#define ATOMIC64_INIT(i) { (i) }
+static __always_inline int atomic64_read(const atomic64_t *v)
+{
+	return READ_ONCE(v->counter);
+}
+static __always_inline void atomic64_set(atomic64_t *v, int i)
+{
+	WRITE_ONCE(v->counter, i);
+}
+#endif
+
+/*
+ * First, the atomic ops that have no ordering constraints and therefor don't
+ * have the AQ or RL bits set.  These don't return anything, so there's only
+ * one version to worry about.
+ */
+#define ATOMIC_OP(op, asm_op, c_op, I, asm_type, c_type, prefix)				\
+static __always_inline void atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)		\
+{												\
+	__asm__ __volatile__ (									\
+		"amo" #asm_op "." #asm_type " zero, %1, %0"					\
+		: "+A" (v->counter)								\
+		: "r" (I));									\
+}
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#define ATOMIC_OPS(op, asm_op, c_op, I)			\
+        ATOMIC_OP (op, asm_op, c_op, I, w,  int,   )
+#else
+#define ATOMIC_OPS(op, asm_op, c_op, I)			\
+        ATOMIC_OP (op, asm_op, c_op, I, w,  int,   )	\
+        ATOMIC_OP (op, asm_op, c_op, I, d, long, 64)
+#endif
+
+ATOMIC_OPS(add, add, +,  i)
+ATOMIC_OPS(sub, add, +, -i)
+/*
+ * FIXME: I could only find documentation that atomic_{add,sub,inc,dec} are
+ * barrier-free.  I'm assuming that and/or/xor have the same constraints as the
+ * others.
+ */
+ATOMIC_OPS(and, and, &,  i)
+ATOMIC_OPS( or,  or, |,  i)
+ATOMIC_OPS(xor, xor, ^,  i)
+
+#undef ATOMIC_OP
+#undef ATOMIC_OPS
+
+/*
+ * Atomic ops that have ordered, relaxed, acquire, and relese variants.
+ * There's two flavors of these: the arithmatic ops have both fetch and return
+ * versions, while the logical ops only have fetch versions.
+ */
+#define ATOMIC_FETCH_OP(op, asm_op, c_op, I, asm_or, c_or, asm_type, c_type, prefix)			\
+static __always_inline c_type atomic##prefix##_fetch_##op##c_or(c_type i, atomic##prefix##_t *v)	\
+{													\
+	register c_type ret;										\
+	__asm__ __volatile__ (										\
+		"amo" #asm_op "." #asm_type #asm_or " %2, %1, %0"					\
+		: "+A" (v->counter), "=r" (ret)								\
+		: "r" (I));										\
+	return ret;											\
+}
+
+#define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_or, c_or, asm_type, c_type, prefix)			\
+static __always_inline c_type atomic##prefix##_##op##_return##c_or(int i, atomic##prefix##_t *v)	\
+{													\
+        return atomic##prefix##_fetch_##op##c_or(i, v) c_op I;						\
+}
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#define ATOMIC_OPS(op, asm_op, c_op, I, asm_or, c_or)				\
+        ATOMIC_FETCH_OP (op, asm_op, c_op, I, asm_or, c_or, w,  int,   )	\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_or, c_or, w,  int,   )
+#else
+#define ATOMIC_OPS(op, asm_op, c_op, I, asm_or, c_or)				\
+        ATOMIC_FETCH_OP (op, asm_op, c_op, I, asm_or, c_or, w,  int,   )	\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_or, c_or, w,  int,   )	\
+        ATOMIC_FETCH_OP (op, asm_op, c_op, I, asm_or, c_or, d, long, 64)	\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_or, c_or, d, long, 64)
+#endif
+
+ATOMIC_OPS(add, add, +,  i,      , _relaxed)
+ATOMIC_OPS(add, add, +,  i, .aq  , _acquire)
+ATOMIC_OPS(add, add, +,  i, .rl  , _release)
+ATOMIC_OPS(add, add, +,  i, .aqrl,         )
+
+ATOMIC_OPS(sub, add, +, -i,      , _relaxed)
+ATOMIC_OPS(sub, add, +, -i, .aq  , _acquire)
+ATOMIC_OPS(sub, add, +, -i, .rl  , _release)
+ATOMIC_OPS(sub, add, +, -i, .aqrl,         )
+
+#undef ATOMIC_OPS
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#define ATOMIC_OPS(op, asm_op, c_op, I, asm_or, c_or)				\
+        ATOMIC_FETCH_OP(op, asm_op, c_op, I, asm_or, c_or, w,  int,   )
+#else
+#define ATOMIC_OPS(op, asm_op, c_op, I, asm_or, c_or)				\
+        ATOMIC_FETCH_OP(op, asm_op, c_op, I, asm_or, c_or, w,  int,   )		\
+        ATOMIC_FETCH_OP(op, asm_op, c_op, I, asm_or, c_or, d, long, 64)
+#endif
+
+ATOMIC_OPS(and, and, &,  i,      , _relaxed)
+ATOMIC_OPS(and, and, &,  i, .aq  , _acquire)
+ATOMIC_OPS(and, and, &,  i, .rl  , _release)
+ATOMIC_OPS(and, and, &,  i, .aqrl,         )
+
+ATOMIC_OPS( or,  or, |,  i,      , _relaxed)
+ATOMIC_OPS( or,  or, |,  i, .aq  , _acquire)
+ATOMIC_OPS( or,  or, |,  i, .rl  , _release)
+ATOMIC_OPS( or,  or, |,  i, .aqrl,         )
+
+ATOMIC_OPS(xor, xor, ^,  i,      , _relaxed)
+ATOMIC_OPS(xor, xor, ^,  i, .aq  , _acquire)
+ATOMIC_OPS(xor, xor, ^,  i, .rl  , _release)
+ATOMIC_OPS(xor, xor, ^,  i, .aqrl,         )
+
+#undef ATOMIC_OPS
+
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+
+/*
+ * The extra atomic operations that are constructed from one of the core
+ * AMO-based operations above (aside from sub, which is easier to fit above).
+ * These are required to perform a barrier, but they're OK this way because
+ * atomic_*_return is also required to perform a barrier.
+ */
+#define ATOMIC_OP(op, func_op, comp_op, I, c_type, prefix)			\
+static __always_inline bool atomic##prefix##_##op(c_type i, atomic##prefix##_t *v) \
+{										\
+	return atomic##prefix##_##func_op##_return(i, v) comp_op I;		\
+}
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#define ATOMIC_OPS(op, func_op, comp_op, I)			\
+        ATOMIC_OP (op, func_op, comp_op, I,  int,   )
+#else
+#define ATOMIC_OPS(op, func_op, comp_op, I)			\
+        ATOMIC_OP (op, func_op, comp_op, I,  int,   )		\
+        ATOMIC_OP (op, func_op, comp_op, I, long, 64)
+#endif
+
+ATOMIC_OPS(add_and_test, add, ==, 0)
+ATOMIC_OPS(sub_and_test, sub, ==, 0)
+ATOMIC_OPS(add_negative, add,  <, 0)
+
+#undef ATOMIC_OP
+#undef ATOMIC_OPS
+
+#define ATOMIC_OP(op, func_op, c_op, I, prefix)					\
+static __always_inline void atomic##prefix##_##op(atomic##prefix##_t *v)	\
+{										\
+	atomic##prefix##_##func_op(I, v);					\
+}
+
+#define ATOMIC_FETCH_OP(op, func_op, c_op, I, prefix)				\
+static __always_inline int atomic##prefix##_fetch_##op(atomic##prefix##_t *v)	\
+{										\
+	return atomic##prefix##_fetch_##func_op(I, v);				\
+}
+
+#define ATOMIC_OP_RETURN(op, asm_op, c_op, I, prefix)				\
+static __always_inline int atomic##prefix##_##op##_return(atomic##prefix##_t *v) \
+{										\
+        return atomic##prefix##_fetch_##op(v) c_op I;				\
+}
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#define ATOMIC_OPS(op, asm_op, c_op, I)						\
+        ATOMIC_OP       (op, asm_op, c_op, I,   )				\
+        ATOMIC_FETCH_OP (op, asm_op, c_op, I,   )				\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I,   )
+#else
+#define ATOMIC_OPS(op, asm_op, c_op, I)						\
+        ATOMIC_OP       (op, asm_op, c_op, I,   )				\
+        ATOMIC_FETCH_OP (op, asm_op, c_op, I,   )				\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I,   )				\
+        ATOMIC_OP       (op, asm_op, c_op, I, 64)				\
+        ATOMIC_FETCH_OP (op, asm_op, c_op, I, 64)				\
+        ATOMIC_OP_RETURN(op, asm_op, c_op, I, 64)
+#endif
+
+ATOMIC_OPS(inc, add, +,  1)
+ATOMIC_OPS(dec, add, +, -1)
+
+#undef ATOMIC_OPS
+#undef ATOMIC_OP
+#undef ATOMIC_FETCH_OP
+#undef ATOMIC_OP_RETURN
+
+#define ATOMIC_OP(op, func_op, comp_op, I, prefix)				\
+static __always_inline bool atomic##prefix##_##op(atomic##prefix##_t *v)	\
+{										\
+	return atomic##prefix##_##func_op##_return(v) comp_op I;		\
+}
+
+ATOMIC_OP(inc_and_test, inc, ==, 0,   )
+ATOMIC_OP(dec_and_test, dec, ==, 0,   )
+#ifndef CONFIG_GENERIC_ATOMIC64
+ATOMIC_OP(inc_and_test, inc, ==, 0, 64)
+ATOMIC_OP(dec_and_test, dec, ==, 0, 64)
+#endif
+
+#undef ATOMIC_OP
+
+/* This is required to provide a barrier on success. */
+static __always_inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+       register int prev, rc;
+
+	__asm__ __volatile__ (
+		"0:\n\t"
+		"lr.w.aqrl %0, %2\n\t"
+		"beq       %0, %4, 1f\n\t"
+		"add       %1, %0, %3\n\t"
+		"sc.w.aqrl %1, %1, %2\n\t"
+		"bnez      %1, 0b\n\t"
+		"1:"
+		: "=&r" (prev), "=&r" (rc), "+A" (v->counter)
+		: "r" (a), "r" (u));
+	return prev;
+}
+
+#ifndef CONFIG_GENERIC_ATOMIC64
+static __always_inline long atomic64_add_unless(atomic64_t *v, long a, long u)
+{
+       register long prev, rc;
+
+	__asm__ __volatile__ (
+		"0:\n\t"
+		"lr.d.aqrl %0, %2\n\t"
+		"beq       %0, %4, 1f\n\t"
+		"add       %1, %0, %3\n\t"
+		"sc.d.aqrl %1, %1, %2\n\t"
+		"bnez      %1, 0b\n\t"
+		"1:"
+		: "=&r" (prev), "=&r" (rc), "+A" (v->counter)
+		: "r" (a), "r" (u));
+	return prev;
+}
+#endif
+
+/*
+ * The extra atomic operations that are constructed from one of the core
+ * LR/SC-based operations above.
+ */
+static __always_inline int atomic_inc_not_zero(atomic_t *v)
+{
+        return __atomic_add_unless(v, 1, 0);
+}
+
+#ifndef CONFIG_GENERIC_ATOMIC64
+static __always_inline int atomic64_inc_not_zero(atomic64_t *v)
+{
+        return atomic64_add_unless(v, 1, 0);
+}
+#endif
+
+/*
+ * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
+ * {cmp,}xchg and the operations that return, so they need a barrier.  We just
+ * use the other implementations directly.
+ */
+#define ATOMIC_OP(c_t, prefix, c_or, size, asm_or)						\
+static __always_inline c_t atomic##prefix##_cmpxchg##c_or(atomic##prefix##_t *v, c_t o, c_t n) 	\
+{												\
+	return __cmpxchg(&(v->counter), o, n, size, asm_or, asm_or);				\
+}												\
+static __always_inline c_t atomic##prefix##_xchg##c_or(atomic##prefix##_t *v, c_t n) 		\
+{												\
+	return __xchg(n, &(v->counter), size, asm_or);						\
+}
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#define ATOMIC_OPS(c_or, asm_or)			\
+	ATOMIC_OP( int,   , c_or, 4, asm_or)
+#else
+#define ATOMIC_OPS(c_or, asm_or)			\
+	ATOMIC_OP( int,   , c_or, 4, asm_or)		\
+	ATOMIC_OP(long, 64, c_or, 8, asm_or)
+#endif
+
+ATOMIC_OPS(        , .aqrl)
+ATOMIC_OPS(_acquire,   .aq)
+ATOMIC_OPS(_release,   .rl)
+ATOMIC_OPS(_relaxed,      )
+
+#undef ATOMIC_OPS
+#undef ATOMIC_OP
+
+#else /* !CONFIG_ISA_A */
+
+#include <asm-generic/atomic.h>
+
+#endif /* CONFIG_ISA_A */
+
+#endif /* _ASM_RISCV_ATOMIC_H */
diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
new file mode 100644
index 000000000000..cbe7bc5c506e
--- /dev/null
+++ b/arch/riscv/include/asm/barrier.h
@@ -0,0 +1,143 @@
+/*
+ * Based on arch/arm/include/asm/barrier.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2013 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _ASM_RISCV_BARRIER_H
+#define _ASM_RISCV_BARRIER_H
+
+#ifndef __ASSEMBLY__
+
+#define nop()		__asm__ __volatile__ ("nop")
+
+#define RISCV_FENCE(p, s) \
+	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")
+
+/* These barries need to enforce ordering on both devices or memory. */
+#define mb()		RISCV_FENCE(iorw,iorw)
+#define rmb()		RISCV_FENCE(ir,ir)
+#define wmb()		RISCV_FENCE(ow,ow)
+
+/* These barries do not need to enforce ordering on devices, just memory. */
+#define smp_mb()	RISCV_FENCE(rw,rw)
+#define smp_rmb()	RISCV_FENCE(r,r)
+#define smp_wmb()	RISCV_FENCE(w,w)
+
+/*
+ * Our atomic operations set the AQ and RL bits and therefor we don't need to
+ * fence around atomics.
+ */
+#define __smb_mb__before_atomic()	barrier()
+#define __smb_mb__after_atomic()	barrier()
+
+/*
+ * These barries are meant to prevent memory operations inside a spinlock from
+ * moving outside of that spinlock.  Since we set the AQ and RL bits when
+ * entering or leaving spinlocks, no additional fence needs to be performed.
+ */
+#define smb_mb__before_spinlock()	barrier()
+#define smb_mb__after_spinlock()	barrier()
+
+/* FIXME: I don't think RISC-V is allowed to perform a speculative load. */
+#define smp_acquire__after_ctrl_dep()	barrier()
+
+/*
+ * The RISC-V ISA doesn't support byte or half-word AMOs, so we fall back to a
+ * regular store and a fence here.  Otherwise we emit an AMO with an AQ or RL
+ * bit set and allow the microarchitecture to avoid the other half of the AMO.
+ */
+#define __smp_store_release(p, v)					\
+do {									\
+	union { typeof(*p) __val; char __c[1]; } __u =			\
+		{ .__val = (__force typeof(*p)) (v) };			\
+	compiletime_assert_atomic_type(*p);				\
+	switch (sizeof(*p)) {						\
+	case 1:								\
+	case 2:								\
+		smb_mb();						\
+		WRITE_ONCE(*p, __u.__val);				\
+		break;							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+			"amoswap.w.rl zero, %1, %0"			\
+			: "+A" (*p), "r" (__u.__val)			\
+			: 						\
+			: "memory");					\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+			"amoswap.d.rl zero, %1, %0"			\
+			: "+A" (*p), "r" (__u.__val)			\
+			: 						\
+			: "memory");					\
+		break;							\
+	}								\
+} while (0)
+
+#define __smp_load_acquire(p)						\
+do {									\
+	union { typeof(*p) __val; char __c[1]; } __u =			\
+		{ .__val = (__force typeof(*p)) (v) };			\
+	compiletime_assert_atomic_type(*p);				\
+	switch (sizeof(*p)) {						\
+	case 1:								\
+	case 2:								\
+		__u.__val = READ_ONCE(*p);				\
+		smb_mb();						\
+		break;							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+			"amoor.w.aq %1, zero, %0"			\
+			: "+A" (*p)					\
+			: "=r" (__u.__val)				\
+			: "memory");					\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+			"amoor.d.aq %1, zero, %0"			\
+			: "+A" (*p)					\
+			: "=r" (__u.__val)				\
+			: "memory");					\
+		break;							\
+	}								\
+	__u.__val;							\
+} while (0)
+
+/*
+ * The default implementation of this uses READ_ONCE and
+ * smp_acquire__after_ctrl_dep, but since we can directly do an ACQUIRE load we
+ * can avoid the extra barrier.
+ */
+#define smp_cond_load_acquire(ptr, cond_expr) ({			\
+	typeof(ptr) __PTR = (ptr);					\
+	typeof(*ptr) VAL;						\
+	for (;;) {							\
+		VAL = __smp_load_acquire(__PTR);			\
+		if (cond_expr)						\
+			break;						\
+		cpu_relax();						\
+	}								\
+	smp_acquire__after_ctrl_dep();					\
+	VAL;								\
+})
+
+#include <asm-generic/barrier.h>
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_BARRIER_H */
diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
new file mode 100644
index 000000000000..27e47858c6b1
--- /dev/null
+++ b/arch/riscv/include/asm/bitops.h
@@ -0,0 +1,228 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_BITOPS_H
+#define _ASM_RISCV_BITOPS_H
+
+#ifndef _LINUX_BITOPS_H
+#error "Only <linux/bitops.h> can be included directly"
+#endif /* _LINUX_BITOPS_H */
+
+#ifdef __KERNEL__
+
+#include <linux/compiler.h>
+#include <linux/irqflags.h>
+#include <asm/barrier.h>
+#include <asm/bitsperlong.h>
+
+#ifdef CONFIG_ISA_A
+
+#ifndef smp_mb__before_clear_bit
+#define smp_mb__before_clear_bit()  smp_mb()
+#define smp_mb__after_clear_bit()   smp_mb()
+#endif /* smp_mb__before_clear_bit */
+
+#include <asm-generic/bitops/__ffs.h>
+#include <asm-generic/bitops/ffz.h>
+#include <asm-generic/bitops/fls.h>
+#include <asm-generic/bitops/__fls.h>
+#include <asm-generic/bitops/fls64.h>
+#include <asm-generic/bitops/find.h>
+#include <asm-generic/bitops/sched.h>
+#include <asm-generic/bitops/ffs.h>
+
+#include <asm-generic/bitops/hweight.h>
+
+#if (BITS_PER_LONG == 64)
+#define __AMO(op)	"amo" #op ".d"
+#elif (BITS_PER_LONG == 32)
+#define __AMO(op)	"amo" #op ".w"
+#else
+#error "Unexpected BITS_PER_LONG"
+#endif
+
+#define __test_and_op_bit(op, mod, nr, addr)			\
+({								\
+	unsigned long __res, __mask;				\
+	__mask = BIT_MASK(nr);					\
+	__asm__ __volatile__ (					\
+		__AMO(op) " %0, %2, %1"				\
+		: "=r" (__res), "+A" (addr[BIT_WORD(nr)])	\
+		: "r" (mod(__mask)));				\
+	((__res & __mask) != 0);				\
+})
+
+#define __op_bit(op, mod, nr, addr)				\
+	__asm__ __volatile__ (					\
+		__AMO(op) " zero, %1, %0"			\
+		: "+A" (addr[BIT_WORD(nr)])			\
+		: "r" (mod(BIT_MASK(nr))))
+
+/* Bitmask modifiers */
+#define __NOP(x)	(x)
+#define __NOT(x)	(~(x))
+
+/**
+ * test_and_set_bit - Set a bit and return its old value
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It may be reordered on other architectures than x86.
+ * It also implies a memory barrier.
+ */
+static inline int test_and_set_bit(int nr, volatile unsigned long *addr)
+{
+	return __test_and_op_bit(or, __NOP, nr, addr);
+}
+
+/**
+ * test_and_clear_bit - Clear a bit and return its old value
+ * @nr: Bit to clear
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It can be reordered on other architectures other than x86.
+ * It also implies a memory barrier.
+ */
+static inline int test_and_clear_bit(int nr, volatile unsigned long *addr)
+{
+	return __test_and_op_bit(and, __NOT, nr, addr);
+}
+
+/**
+ * test_and_change_bit - Change a bit and return its old value
+ * @nr: Bit to change
+ * @addr: Address to count from
+ *
+ * This operation is atomic and cannot be reordered.
+ * It also implies a memory barrier.
+ */
+static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
+{
+	return __test_and_op_bit(xor, __NOP, nr, addr);
+}
+
+/**
+ * set_bit - Atomically set a bit in memory
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * This function is atomic and may not be reordered.  See __set_bit()
+ * if you do not require the atomic guarantees.
+ *
+ * Note: there are no guarantees that this function will not be reordered
+ * on non x86 architectures, so if you are writing portable code,
+ * make sure not to rely on its reordering guarantees.
+ *
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
+static inline void set_bit(int nr, volatile unsigned long *addr)
+{
+	__op_bit(or, __NOP, nr, addr);
+}
+
+/**
+ * clear_bit - Clears a bit in memory
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * clear_bit() is atomic and may not be reordered.  However, it does
+ * not contain a memory barrier, so if it is used for locking purposes,
+ * you should call smp_mb__before_clear_bit() and/or smp_mb__after_clear_bit()
+ * in order to ensure changes are visible on other processors.
+ */
+static inline void clear_bit(int nr, volatile unsigned long *addr)
+{
+	__op_bit(and, __NOT, nr, addr);
+}
+
+/**
+ * change_bit - Toggle a bit in memory
+ * @nr: Bit to change
+ * @addr: Address to start counting from
+ *
+ * change_bit() is atomic and may not be reordered. It may be
+ * reordered on other architectures than x86.
+ * Note that @nr may be almost arbitrarily large; this function is not
+ * restricted to acting on a single-word quantity.
+ */
+static inline void change_bit(int nr, volatile unsigned long *addr)
+{
+	__op_bit(xor, __NOP, nr, addr);
+}
+
+/**
+ * test_and_set_bit_lock - Set a bit and return its old value, for lock
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This operation is atomic and provides acquire barrier semantics.
+ * It can be used to implement bit locks.
+ */
+static inline int test_and_set_bit_lock(
+	unsigned long nr, volatile unsigned long *addr)
+{
+	return test_and_set_bit(nr, addr);
+}
+
+/**
+ * clear_bit_unlock - Clear a bit in memory, for unlock
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * This operation is atomic and provides release barrier semantics.
+ */
+static inline void clear_bit_unlock(
+	unsigned long nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
+
+/**
+ * __clear_bit_unlock - Clear a bit in memory, for unlock
+ * @nr: the bit to set
+ * @addr: the address to start counting from
+ *
+ * This operation is like clear_bit_unlock, however it is not atomic.
+ * It does provide release barrier semantics so it can be used to unlock
+ * a bit lock, however it would only be used if no other CPU can modify
+ * any bits in the memory until the lock is released (a good example is
+ * if the bit lock itself protects access to the other bits in the word).
+ */
+static inline void __clear_bit_unlock(
+	unsigned long nr, volatile unsigned long *addr)
+{
+	clear_bit(nr, addr);
+}
+
+#undef __test_and_op_bit
+#undef __op_bit
+#undef __NOP
+#undef __NOT
+#undef __AMO
+
+#include <asm-generic/bitops/non-atomic.h>
+#include <asm-generic/bitops/le.h>
+#include <asm-generic/bitops/ext2-atomic.h>
+
+#else /* !CONFIG_ISA_A */
+
+#include <asm-generic/bitops.h>
+
+#endif /* CONFIG_ISA_A */
+
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_RISCV_BITOPS_H */
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
new file mode 100644
index 000000000000..0595585013b0
--- /dev/null
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_CACHEFLUSH_H
+#define _ASM_RISCV_CACHEFLUSH_H
+
+#include <asm-generic/cacheflush.h>
+
+#undef flush_icache_range
+#undef flush_icache_user_range
+
+static inline void local_flush_icache_all(void)
+{
+	asm volatile ("fence.i" ::: "memory");
+}
+
+#ifndef CONFIG_SMP
+
+#define flush_icache_range(start, end) local_flush_icache_all()
+#define flush_icache_user_range(vma, pg, addr, len) local_flush_icache_all()
+
+#else /* CONFIG_SMP */
+
+#define flush_icache_range(start, end) sbi_remote_fence_i(0)
+#define flush_icache_user_range(vma, pg, addr, len) sbi_remote_fence_i(0)
+
+#endif /* CONFIG_SMP */
+
+#endif /* _ASM_RISCV_CACHEFLUSH_H */
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
new file mode 100644
index 000000000000..81025c056412
--- /dev/null
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2014 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_CMPXCHG_H
+#define _ASM_RISCV_CMPXCHG_H
+
+#include <linux/bug.h>
+
+#ifdef CONFIG_ISA_A
+
+#include <asm/barrier.h>
+
+#define __xchg(new, ptr, size, asm_or)				\
+({								\
+	__typeof__(ptr) __ptr = (ptr);				\
+	__typeof__(new) __new = (new);				\
+	__typeof__(*(ptr)) __ret;				\
+	switch (size) {						\
+	case 4:							\
+		__asm__ __volatile__ (				\
+			"amoswap.w" #asm_or " %0, %2, %1"	\
+			: "=r" (__ret), "+A" (*__ptr)		\
+			: "r" (__new));				\
+		break;						\
+	case 8:							\
+		__asm__ __volatile__ (				\
+			"amoswap.d" #asm_or " %0, %2, %1"	\
+			: "=r" (__ret), "+A" (*__ptr)		\
+			: "r" (__new));				\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
+	}							\
+	__ret;							\
+})
+
+#define xchg(ptr, x)    (__xchg((x), (ptr), sizeof(*(ptr)), .aqrl))
+
+#define xchg32(ptr, x)				\
+({						\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);	\
+	xchg((ptr), (x));			\
+})
+
+#define xchg64(ptr, x)				\
+({						\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
+	xchg((ptr), (x));			\
+})
+
+/*
+ * Atomic compare and exchange.  Compare OLD with MEM, if identical,
+ * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * indicated by comparing RETURN with OLD.
+ */
+#define __cmpxchg(ptr, old, new, size, lrb, scb)			\
+({									\
+	__typeof__(ptr) __ptr = (ptr);					\
+	__typeof__(old) __old = (old);					\
+	__typeof__(new) __new = (new);					\
+	__typeof__(*(ptr)) __ret;					\
+	register unsigned int __rc;					\
+	switch (size) {							\
+	case 4:								\
+		__asm__ __volatile__ (					\
+		"0:"							\
+			"lr.w" #scb " %0, %2\n"				\
+			"bne         %0, %z3, 1f\n"			\
+			"sc.w" #lrb " %1, %z4, %2\n"			\
+			"bnez        %1, 0b\n"				\
+		"1:"							\
+			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new));			\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__ (					\
+		"0:"							\
+			"lr.d" #scb " %0, %2\n"				\
+			"bne         %0, %z3, 1f\n"			\
+			"sc.d" #lrb " %1, %z4, %2\n"			\
+			"bnez        %1, 0b\n"				\
+		"1:"							\
+			: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)	\
+			: "rJ" (__old), "rJ" (__new));			\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
+	__ret;								\
+})
+
+#define cmpxchg(ptr, o, n) \
+	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr)), .aqrl, .aqrl))
+
+#define cmpxchg_local(ptr, o, n) \
+	(__cmpxchg((ptr), (o), (n), sizeof(*(ptr)), , ))
+
+#define cmpxchg32(ptr, o, n)			\
+({						\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);	\
+	cmpxchg((ptr), (o), (n));		\
+})
+
+#define cmpxchg32_local(ptr, o, n)		\
+({						\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);	\
+	cmpxchg_local((ptr), (o), (n));		\
+})
+
+#define cmpxchg64(ptr, o, n)			\
+({						\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
+	cmpxchg((ptr), (o), (n));		\
+})
+
+#define cmpxchg64_local(ptr, o, n)		\
+({						\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);	\
+	cmpxchg_local((ptr), (o), (n));		\
+})
+
+#else /* !CONFIG_ISA_A */
+
+#include <asm-generic/cmpxchg.h>
+
+#endif /* CONFIG_ISA_A */
+
+#endif /* _ASM_RISCV_CMPXCHG_H */
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
new file mode 100644
index 000000000000..c47177cb6660
--- /dev/null
+++ b/arch/riscv/include/asm/io.h
@@ -0,0 +1,180 @@
+/*
+ * {read,write}{b,w,l,q} based on arch/arm64/include/asm/io.h
+ *   which was based on arch/arm/include/io.h
+ *
+ * Copyright (C) 1996-2000 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2014 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_IO_H
+#define _ASM_RISCV_IO_H
+
+#ifdef CONFIG_MMU
+
+extern void __iomem *ioremap(phys_addr_t offset, unsigned long size);
+
+/*
+ * The RISC-V ISA doesn't yet specify how to query of modify PMAs, so we can't
+ * change the properties of memory regions.  This should be fixed by the
+ * upcoming platform spec.
+ */
+#define ioremap_nocache(addr, size) ioremap((addr), (size))
+#define ioremap_wc(addr, size) ioremap((addr), (size))
+#define ioremap_wt(addr, size) ioremap((addr), (size))
+
+extern void iounmap(void __iomem *addr);
+
+#endif /* CONFIG_MMU */
+
+/* Generic IO read/write.  These perform native-endian accesses. */
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
+{
+	asm volatile("sb %0, 0(%1)" : : "r" (val), "r" (addr));
+}
+
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 val, volatile void __iomem *addr)
+{
+	asm volatile("sh %0, 0(%1)" : : "r" (val), "r" (addr));
+}
+
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 val, volatile void __iomem *addr)
+{
+	asm volatile("sw %0, 0(%1)" : : "r" (val), "r" (addr));
+}
+
+#ifdef __riscv64
+#define __raw_writeq __raw_writeq
+static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
+{
+	asm volatile("sd %0, 0(%1)" : : "r" (val), "r" (addr));
+}
+#endif
+
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	u8 val;
+
+	asm volatile("lb %0, 0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	u16 val;
+
+	asm volatile("lh %0, 0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#define __raw_readl __raw_readl
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	u32 val;
+
+	asm volatile("lw %0, 0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#ifdef __riscv64
+#define __raw_readq __raw_readq
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	u64 val;
+
+	asm volatile("ld %0, 0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+#endif
+
+/*
+ * FIXME: I'm flip-flopping on whether or not we should keep this or enforce
+ * the ordering with I/O on spinlocks.  The worry is that drivers won't get
+ * this correct, but I also don't want to introduce a fence into the lock code
+ * that otherwise only uses AMOs and LR/SC.   For now I'm leaving this here:
+ * "w,o" is sufficient to ensure that all writes to the device has completed
+ * before the write to the spinlock is allowed to commit.  I surmised this from
+ * reading "ACQUIRES VS I/O ACCESSES" in memory-barries.txt.
+ */
+#define mmiowb()	__asm__ __volatile__ ("fence o,w" : : : "memory");
+
+/*
+ * Unordered I/O memory access primitives.  These are even more relaxed than
+ * the relaxed versions, as they don't even order accesses between successive
+ * operations to the I/O regions.
+ */
+#define readb_cpu(c)		({ u8  __r = __raw_readb(c); __r; })
+#define readw_cpu(c)		({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
+#define readl_cpu(c)		({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
+#define readq_cpu(c)		({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
+
+#define writeb_cpu(v,c)		((void)__raw_writeb((v),(c)))
+#define writew_cpu(v,c)		((void)__raw_writew((__force u16)cpu_to_le16(v),(c)))
+#define writel_cpu(v,c)		((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
+#define writeq_cpu(v,c)		((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
+
+/*
+ * Relaxed I/O memory access primitives. These follow the Device memory
+ * ordering rules but do not guarantee any ordering relative to Normal memory
+ * accesses.  The memory barries here are necessary as RISC-V doesn't define
+ * any ordering constraints on accesses to the device I/O space.  These are
+ * defined to order the indicated access (either a read or write) with all
+ * other I/O memory accesses.
+ */
+/*
+ * FIXME: The platform spec will define the default Linux-capable platform to
+ * have some extra IO ordering constraints that will make these fences
+ * unnecessary.
+ */
+#define __iorrmb()	__asm__ __volatile__ ("fence i,io" : : : "memory");
+#define __iorwmb()	__asm__ __volatile__ ("fence io,o" : : : "memory");
+
+#define readb_relaxed(c)	({ u8  __v = readb_cpu(c); __iorrmb(); __v; })
+#define readw_relaxed(c)	({ u16 __v = readw_cpu(c); __iorrmb(); __v; })
+#define readl_relaxed(c)	({ u32 __v = readl_cpu(c); __iorrmb(); __v; })
+#define readq_relaxed(c)	({ u64 __v = readq_cpu(c); __iorrmb(); __v; })
+
+#define writeb_relaxed(v,c)	({ __iorwmb(); writeb_cpu((v),(c)); })
+#define writew_relaxed(v,c)	({ __iorwmb(); writew_cpu((v),(c)); })
+#define writel_relaxed(v,c)	({ __iorwmb(); writel_cpu((v),(c)); })
+#define writeq_relaxed(v,c)	({ __iorwmb(); writeq_cpu((v),(c)); })
+
+/*
+ * I/O memory access primitives. Reads are ordered relative to any
+ * following Normal memory access. Writes are ordered relative to any prior
+ * Normal memory access.  The memory barriers here are necessary as RISC-V
+ * doesn't define any ordering between the memory space and the I/O space.
+ * They may be stronger than necessary ("i,r" and "w,o" might be sufficient),
+ * but I feel kind of queasy making these weaker in any manner than the relaxed
+ * versions above.
+ */
+#define __iormb()	__asm__ __volatile__ ("fence i,ior" : : : "memory");
+#define __iowmb()	__asm__ __volatile__ ("fence iow,o" : : : "memory");
+
+#define readb(c)		({ u8  __v = readb_cpu(c); __iormb(); __v; })
+#define readw(c)		({ u16 __v = readw_cpu(c); __iormb(); __v; })
+#define readl(c)		({ u32 __v = readl_cpu(c); __iormb(); __v; })
+#define readq(c)		({ u64 __v = readq_cpu(c); __iormb(); __v; })
+
+#define writeb(v,c)		({ __iowmb(); writeb_cpu((v),(c)); })
+#define writew(v,c)		({ __iowmb(); writew_cpu((v),(c)); })
+#define writel(v,c)		({ __iowmb(); writel_cpu((v),(c)); })
+#define writeq(v,c)		({ __iowmb(); writeq_cpu((v),(c)); })
+
+#include <asm-generic/io.h>
+
+#endif /* _ASM_RISCV_IO_H */
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
new file mode 100644
index 000000000000..54ed73bfa972
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock.h
@@ -0,0 +1,167 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_SPINLOCK_H
+#define _ASM_RISCV_SPINLOCK_H
+
+#include <linux/kernel.h>
+#include <asm/current.h>
+
+/*
+ * Simple spin lock operations.  These provide no fairness guarantees.
+ */
+
+/* FIXME: Replace this with a ticket lock, like MIPS. */
+
+#define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
+#define arch_spin_is_locked(x)	((x)->lock != 0)
+#define arch_spin_unlock_wait(x) \
+		do { cpu_relax(); } while ((x)->lock)
+
+static inline void arch_spin_unlock(arch_spinlock_t *lock)
+{
+	__asm__ __volatile__ (
+		"amoswap.w.rl x0, x0, %0"
+		: "=A" (lock->lock)
+		:: "memory");
+}
+
+static inline int arch_spin_trylock(arch_spinlock_t *lock)
+{
+	int tmp = 1, busy;
+
+	__asm__ __volatile__ (
+		"amoswap.w.aq %0, %2, %1"
+		: "=r" (busy), "+A" (lock->lock)
+		: "r" (tmp)
+		: "memory");
+
+	return !busy;
+}
+
+static inline void arch_spin_lock(arch_spinlock_t *lock)
+{
+	while (1) {
+		if (arch_spin_is_locked(lock))
+			continue;
+
+		if (arch_spin_trylock(lock))
+			break;
+	}
+}
+
+static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
+{
+	smp_rmb();
+	do {
+		cpu_relax();
+	} while (arch_spin_is_locked(lock));
+	smp_acquire__after_ctrl_dep();
+}
+
+/***********************************************************/
+
+static inline int arch_read_can_lock(arch_rwlock_t *lock)
+{
+	return lock->lock >= 0;
+}
+
+static inline int arch_write_can_lock(arch_rwlock_t *lock)
+{
+	return lock->lock == 0;
+}
+
+static inline void arch_read_lock(arch_rwlock_t *lock)
+{
+	int tmp;
+
+	__asm__ __volatile__(
+		"1:	lr.w	%1, %0\n"
+		"	bltz	%1, 1b\n"
+		"	addi	%1, %1, 1\n"
+		"	sc.w.aq	%1, %1, %0\n"
+		"	bnez	%1, 1b\n"
+		: "+A" (lock->lock), "=&r" (tmp)
+		:: "memory");
+}
+
+static inline void arch_write_lock(arch_rwlock_t *lock)
+{
+	int tmp;
+
+	__asm__ __volatile__(
+		"1:	lr.w	%1, %0\n"
+		"	bnez	%1, 1b\n"
+		"	li	%1, -1\n"
+		"	sc.w.aq	%1, %1, %0\n"
+		"	bnez	%1, 1b\n"
+		: "+A" (lock->lock), "=&r" (tmp)
+		:: "memory");
+}
+
+static inline int arch_read_trylock(arch_rwlock_t *lock)
+{
+	int busy;
+
+	__asm__ __volatile__(
+		"1:	lr.w	%1, %0\n"
+		"	bltz	%1, 1f\n"
+		"	addi	%1, %1, 1\n"
+		"	sc.w.aq	%1, %1, %0\n"
+		"	bnez	%1, 1b\n"
+		"1:\n"
+		: "+A" (lock->lock), "=&r" (busy)
+		:: "memory");
+
+	return !busy;
+}
+
+static inline int arch_write_trylock(arch_rwlock_t *lock)
+{
+	int busy;
+
+	__asm__ __volatile__(
+		"1:	lr.w	%1, %0\n"
+		"	bnez	%1, 1f\n"
+		"	li	%1, -1\n"
+		"	sc.w.aq	%1, %1, %0\n"
+		"	bnez	%1, 1b\n"
+		"1:\n"
+		: "+A" (lock->lock), "=&r" (busy)
+		:: "memory");
+
+	return !busy;
+}
+
+static inline void arch_read_unlock(arch_rwlock_t *lock)
+{
+	__asm__ __volatile__(
+		"amoadd.w.rl x0, %1, %0"
+		: "+A" (lock->lock)
+		: "r" (-1)
+		: "memory");
+}
+
+static inline void arch_write_unlock(arch_rwlock_t *lock)
+{
+	__asm__ __volatile__ (
+		"amoswap.w.rl x0, x0, %0"
+		: "=A" (lock->lock)
+		:: "memory");
+}
+
+#define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
+#define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
+
+#endif /* _ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..83ac4ac9e2ac
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2015 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_SPINLOCK_TYPES_H
+#define _ASM_RISCV_SPINLOCK_TYPES_H
+
+#ifndef __LINUX_SPINLOCK_TYPES_H
+# error "please don't include this file directly"
+#endif
+
+typedef struct {
+	volatile unsigned int lock;
+} arch_spinlock_t;
+
+#define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+
+typedef struct {
+	volatile unsigned int lock;
+} arch_rwlock_t;
+
+#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
+
+#endif
diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
new file mode 100644
index 000000000000..c229509288ea
--- /dev/null
+++ b/arch/riscv/include/asm/tlb.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_TLB_H
+#define _ASM_RISCV_TLB_H
+
+#include <asm-generic/tlb.h>
+
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	flush_tlb_mm(tlb->mm);
+}
+
+#endif /* _ASM_RISCV_TLB_H */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
new file mode 100644
index 000000000000..5ee4ae370b5e
--- /dev/null
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2009 Chen Liqin <liqin.chen@sunplusct.com>
+ * Copyright (C) 2012 Regents of the University of California
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#ifndef _ASM_RISCV_TLBFLUSH_H
+#define _ASM_RISCV_TLBFLUSH_H
+
+#ifdef CONFIG_MMU
+
+/* Flush entire local TLB */
+static inline void local_flush_tlb_all(void)
+{
+	__asm__ __volatile__ ("sfence.vma" : : : "memory");
+}
+
+/* Flush one page from local TLB */
+static inline void local_flush_tlb_page(unsigned long addr)
+{
+	__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
+}
+
+#ifndef CONFIG_SMP
+
+#define flush_tlb_all() local_flush_tlb_all()
+#define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
+#define flush_tlb_range(vma, start, end) local_flush_tlb_all()
+
+#else /* CONFIG_SMP */
+
+#include <asm/sbi.h>
+
+#define flush_tlb_all() sbi_remote_sfence_vma(0, 0, -1)
+#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
+#define flush_tlb_range(vma, start, end) \
+	sbi_remote_sfence_vma(0, start, (end) - (start))
+
+#endif /* CONFIG_SMP */
+
+/* Flush the TLB entries of the specified mm context */
+static inline void flush_tlb_mm(struct mm_struct *mm)
+{
+	flush_tlb_all();
+}
+
+/* Flush a range of kernel pages */
+static inline void flush_tlb_kernel_range(unsigned long start,
+	unsigned long end)
+{
+	flush_tlb_all();
+}
+
+#endif /* CONFIG_MMU */
+
+#endif /* _ASM_RISCV_TLBFLUSH_H */
-- 
2.13.0

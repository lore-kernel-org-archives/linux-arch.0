Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34360 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab2IGQ1y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:54 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 12/31] arm64: Atomic operations
Date: Fri,  7 Sep 2012 17:26:47 +0100
Message-ID: <1347035226-18649-13-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120907162647.LUVIkGIYQEJopqM2xF707huumqz8ZlVykOtZ_H0DayM@z>

This patch introduces the atomic, mutex and futex operations. Many
atomic operations use the load-acquire and store-release operations
which imply barriers, avoiding the need for explicit DMB.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm64/include/asm/atomic.h |  305 +++++++++++++++++++++++++++++++++++=
++++
 arch/arm64/include/asm/futex.h  |  136 +++++++++++++++++
 2 files changed, 441 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/atomic.h
 create mode 100644 arch/arm64/include/asm/futex.h

diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomi=
c.h
new file mode 100644
index 0000000..407717b
--- /dev/null
+++ b/arch/arm64/include/asm/atomic.h
@@ -0,0 +1,305 @@
+/*
+ * Based on arch/arm/include/asm/atomic.h
+ *
+ * Copyright (C) 1996 Russell King.
+ * Copyright (C) 2002 Deep Blue Solutions Ltd.
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef __ASM_ATOMIC_H
+#define __ASM_ATOMIC_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#include <asm/barrier.h>
+#include <asm/cmpxchg.h>
+
+#define ATOMIC_INIT(i)=09{ (i) }
+
+#ifdef __KERNEL__
+
+/*
+ * On ARM, ordinary assignment (str instruction) doesn't clear the local
+ * strex/ldrex monitor on some implementations. The reason we can use it f=
or
+ * atomic_set() is the clrex or dummy strex done on every exception return=
.
+ */
+#define atomic_read(v)=09(*(volatile int *)&(v)->counter)
+#define atomic_set(v,i)=09(((v)->counter) =3D (i))
+
+/*
+ * AArch64 UP and SMP safe atomic ops.  We use load exclusive and
+ * store exclusive to ensure that these are atomic.  We may loop
+ * to ensure that the update happens.
+ */
+static inline void atomic_add(int i, atomic_t *v)
+{
+=09unsigned long tmp;
+=09int result;
+
+=09asm volatile("// atomic_add\n"
+"1:=09ldxr=09%w0, [%3]\n"
+"=09add=09%w0, %w0, %w4\n"
+"=09stxr=09%w1, %w0, [%3]\n"
+"=09cbnz=09%w1, 1b"
+=09: "=3D&r" (result), "=3D&r" (tmp), "+o" (v->counter)
+=09: "r" (&v->counter), "Ir" (i)
+=09: "cc");
+}
+
+static inline int atomic_add_return(int i, atomic_t *v)
+{
+=09unsigned long tmp;
+=09int result;
+
+=09asm volatile("// atomic_add_return\n"
+"1:=09ldaxr=09%w0, [%3]\n"
+"=09add=09%w0, %w0, %w4\n"
+"=09stlxr=09%w1, %w0, [%3]\n"
+"=09cbnz=09%w1, 1b"
+=09: "=3D&r" (result), "=3D&r" (tmp), "+o" (v->counter)
+=09: "r" (&v->counter), "Ir" (i)
+=09: "cc");
+
+=09return result;
+}
+
+static inline void atomic_sub(int i, atomic_t *v)
+{
+=09unsigned long tmp;
+=09int result;
+
+=09asm volatile("// atomic_sub\n"
+"1:=09ldxr=09%w0, [%3]\n"
+"=09sub=09%w0, %w0, %w4\n"
+"=09stxr=09%w1, %w0, [%3]\n"
+"=09cbnz=09%w1, 1b"
+=09: "=3D&r" (result), "=3D&r" (tmp), "+o" (v->counter)
+=09: "r" (&v->counter), "Ir" (i)
+=09: "cc");
+}
+
+static inline int atomic_sub_return(int i, atomic_t *v)
+{
+=09unsigned long tmp;
+=09int result;
+
+=09asm volatile("// atomic_sub_return\n"
+"1:=09ldaxr=09%w0, [%3]\n"
+"=09sub=09%w0, %w0, %w4\n"
+"=09stlxr=09%w1, %w0, [%3]\n"
+"=09cbnz=09%w1, 1b"
+=09: "=3D&r" (result), "=3D&r" (tmp), "+o" (v->counter)
+=09: "r" (&v->counter), "Ir" (i)
+=09: "cc");
+
+=09return result;
+}
+
+static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
+{
+=09unsigned long tmp;
+=09int oldval;
+
+=09asm volatile("// atomic_cmpxchg\n"
+"1:=09ldaxr=09%w1, [%3]\n"
+"=09cmp=09%w1, %w4\n"
+"=09b.ne=092f\n"
+"=09stlxr=09%w0, %w5, [%3]\n"
+"=09cbnz=09%w0, 1b\n"
+"2:"
+=09: "=3D&r" (tmp), "=3D&r" (oldval), "+o" (ptr->counter)
+=09: "r" (&ptr->counter), "Ir" (old), "r" (new)
+=09: "cc");
+
+=09return oldval;
+}
+
+static inline void atomic_clear_mask(unsigned long mask, unsigned long *ad=
dr)
+{
+=09unsigned long tmp, tmp2;
+
+=09asm volatile("// atomic_clear_mask\n"
+"1:=09ldxr=09%0, [%3]\n"
+"=09bic=09%0, %0, %4\n"
+"=09stxr=09%w1, %0, [%3]\n"
+"=09cbnz=09%w1, 1b"
+=09: "=3D&r" (tmp), "=3D&r" (tmp2), "+o" (*addr)
+=09: "r" (addr), "Ir" (mask)
+=09: "cc");
+}
+
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+
+static inline int __atomic_add_unless(atomic_t *v, int a, int u)
+{
+=09int c, old;
+
+=09c =3D atomic_read(v);
+=09while (c !=3D u && (old =3D atomic_cmpxchg((v), c, c + a)) !=3D c)
+=09=09c =3D old;
+=09return c;
+}
+
+#define atomic_inc(v)=09=09atomic_add(1, v)
+#define atomic_dec(v)=09=09atomic_sub(1, v)
+
+#define atomic_inc_and_test(v)=09(atomic_add_return(1, v) =3D=3D 0)
+#define atomic_dec_and_test(v)=09(atomic_sub_return(1, v) =3D=3D 0)
+#define atomic_inc_return(v)    (atomic_add_return(1, v))
+#define atomic_dec_return(v)    (atomic_sub_return(1, v))
+#define atomic_sub_and_test(i, v) (atomic_sub_return(i, v) =3D=3D 0)
+
+#define atomic_add_negative(i,v) (atomic_add_return(i, v) < 0)
+
+#define smp_mb__before_atomic_dec()=09smp_mb()
+#define smp_mb__after_atomic_dec()=09smp_mb()
+#define smp_mb__before_atomic_inc()=09smp_mb()
+#define smp_mb__after_atomic_inc()=09smp_mb()
+
+/*
+ * 64-bit atomic operations.
+ */
+#define ATOMIC64_INIT(i) { (i) }
+
+#define atomic64_read(v)=09(*(volatile long long *)&(v)->counter)
+#define atomic64_set(v,i)=09(((v)->counter) =3D (i))
+
+static inline void atomic64_add(u64 i, atomic64_t *v)
+{
+=09long result;
+=09unsigned long tmp;
+
+=09asm volatile("// atomic64_add\n"
+"1:=09ldxr=09%0, [%3]\n"
+"=09add=09%0, %0, %4\n"
+"=09stxr=09%w1, %0, [%3]\n"
+"=09cbnz=09%w1, 1b"
+=09: "=3D&r" (result), "=3D&r" (tmp), "+o" (v->counter)
+=09: "r" (&v->counter), "Ir" (i)
+=09: "cc");
+}
+
+static inline long atomic64_add_return(long i, atomic64_t *v)
+{
+=09long result;
+=09unsigned long tmp;
+
+=09asm volatile("// atomic64_add_return\n"
+"1:=09ldaxr=09%0, [%3]\n"
+"=09add=09%0, %0, %4\n"
+"=09stlxr=09%w1, %0, [%3]\n"
+"=09cbnz=09%w1, 1b"
+=09: "=3D&r" (result), "=3D&r" (tmp), "+o" (v->counter)
+=09: "r" (&v->counter), "Ir" (i)
+=09: "cc");
+
+=09return result;
+}
+
+static inline void atomic64_sub(u64 i, atomic64_t *v)
+{
+=09long result;
+=09unsigned long tmp;
+
+=09asm volatile("// atomic64_sub\n"
+"1:=09ldxr=09%0, [%3]\n"
+"=09sub=09%0, %0, %4\n"
+"=09stxr=09%w1, %0, [%3]\n"
+"=09cbnz=09%w1, 1b"
+=09: "=3D&r" (result), "=3D&r" (tmp), "+o" (v->counter)
+=09: "r" (&v->counter), "Ir" (i)
+=09: "cc");
+}
+
+static inline long atomic64_sub_return(long i, atomic64_t *v)
+{
+=09long result;
+=09unsigned long tmp;
+
+=09asm volatile("// atomic64_sub_return\n"
+"1:=09ldaxr=09%0, [%3]\n"
+"=09sub=09%0, %0, %4\n"
+"=09stlxr=09%w1, %0, [%3]\n"
+"=09cbnz=09%w1, 1b"
+=09: "=3D&r" (result), "=3D&r" (tmp), "+o" (v->counter)
+=09: "r" (&v->counter), "Ir" (i)
+=09: "cc");
+
+=09return result;
+}
+
+static inline long atomic64_cmpxchg(atomic64_t *ptr, long old, long new)
+{
+=09long oldval;
+=09unsigned long res;
+
+=09asm volatile("// atomic64_cmpxchg\n"
+"1:=09ldaxr=09%1, [%3]\n"
+"=09cmp=09%1, %4\n"
+"=09b.ne=092f\n"
+"=09stlxr=09%w0, %5, [%3]\n"
+"=09cbnz=09%w0, 1b\n"
+"2:"
+=09: "=3D&r" (res), "=3D&r" (oldval), "+o" (ptr->counter)
+=09: "r" (&ptr->counter), "Ir" (old), "r" (new)
+=09: "cc");
+
+=09return oldval;
+}
+
+#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+
+static inline long atomic64_dec_if_positive(atomic64_t *v)
+{
+=09long result;
+=09unsigned long tmp;
+
+=09asm volatile("// atomic64_dec_if_positive\n"
+"1:=09ldaxr=09%0, [%3]\n"
+"=09subs=09%0, %0, #1\n"
+"=09b.mi=092f\n"
+"=09stlxr=09%w1, %0, [%3]\n"
+"=09cbnz=09%w1, 1b\n"
+"2:"
+=09: "=3D&r" (result), "=3D&r" (tmp), "+o" (v->counter)
+=09: "r" (&v->counter)
+=09: "cc");
+
+=09return result;
+}
+
+static inline int atomic64_add_unless(atomic64_t *v, long a, long u)
+{
+=09long c, old;
+
+=09c =3D atomic64_read(v);
+=09while (c !=3D u && (old =3D atomic64_cmpxchg((v), c, c + a)) !=3D c)
+=09=09c =3D old;
+
+=09return c !=3D u;
+}
+
+#define atomic64_add_negative(a, v)=09(atomic64_add_return((a), (v)) < 0)
+#define atomic64_inc(v)=09=09=09atomic64_add(1LL, (v))
+#define atomic64_inc_return(v)=09=09atomic64_add_return(1LL, (v))
+#define atomic64_inc_and_test(v)=09(atomic64_inc_return(v) =3D=3D 0)
+#define atomic64_sub_and_test(a, v)=09(atomic64_sub_return((a), (v)) =3D=
=3D 0)
+#define atomic64_dec(v)=09=09=09atomic64_sub(1LL, (v))
+#define atomic64_dec_return(v)=09=09atomic64_sub_return(1LL, (v))
+#define atomic64_dec_and_test(v)=09(atomic64_dec_return((v)) =3D=3D 0)
+#define atomic64_inc_not_zero(v)=09atomic64_add_unless((v), 1LL, 0LL)
+
+#endif
+#endif
diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.=
h
new file mode 100644
index 0000000..3468ae8
--- /dev/null
+++ b/arch/arm64/include/asm/futex.h
@@ -0,0 +1,136 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef __ASM_FUTEX_H
+#define __ASM_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <asm/errno.h>
+
+#define __futex_atomic_op(insn, ret, oldval, uaddr, tmp, oparg)=09=09\
+=09asm volatile(=09=09=09=09=09=09=09\
+"1:=09ldaxr=09%w1, %2\n"=09=09=09=09=09=09\
+=09insn "\n"=09=09=09=09=09=09=09\
+"2:=09stlxr=09%w3, %w0, %2\n"=09=09=09=09=09=09\
+"=09cbnz=09%w3, 1b\n"=09=09=09=09=09=09\
+"3:\n"=09=09=09=09=09=09=09=09=09\
+"=09.pushsection .fixup,\"ax\"\n"=09=09=09=09=09\
+"4:=09mov=09%w0, %w5\n"=09=09=09=09=09=09\
+"=09b=093b\n"=09=09=09=09=09=09=09\
+"=09.popsection\n"=09=09=09=09=09=09=09\
+"=09.pushsection __ex_table,\"a\"\n"=09=09=09=09\
+"=09.align=093\n"=09=09=09=09=09=09=09\
+"=09.quad=091b, 4b, 2b, 4b\n"=09=09=09=09=09\
+"=09.popsection\n"=09=09=09=09=09=09=09\
+=09: "=3D&r" (ret), "=3D&r" (oldval), "+Q" (*uaddr), "=3D&r" (tmp)=09\
+=09: "r" (oparg), "Ir" (-EFAULT)=09=09=09=09=09\
+=09: "cc")
+
+static inline int
+futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
+{
+=09int op =3D (encoded_op >> 28) & 7;
+=09int cmp =3D (encoded_op >> 24) & 15;
+=09int oparg =3D (encoded_op << 8) >> 20;
+=09int cmparg =3D (encoded_op << 20) >> 20;
+=09int oldval =3D 0, ret, tmp;
+
+=09if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
+=09=09oparg =3D 1 << oparg;
+
+=09if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+=09=09return -EFAULT;
+
+=09pagefault_disable();=09/* implies preempt_disable() */
+
+=09switch (op) {
+=09case FUTEX_OP_SET:
+=09=09__futex_atomic_op("mov=09%w0, %w4",
+=09=09=09=09  ret, oldval, uaddr, tmp, oparg);
+=09=09break;
+=09case FUTEX_OP_ADD:
+=09=09__futex_atomic_op("add=09%w0, %w1, %w4",
+=09=09=09=09  ret, oldval, uaddr, tmp, oparg);
+=09=09break;
+=09case FUTEX_OP_OR:
+=09=09__futex_atomic_op("orr=09%w0, %w1, %w4",
+=09=09=09=09  ret, oldval, uaddr, tmp, oparg);
+=09=09break;
+=09case FUTEX_OP_ANDN:
+=09=09__futex_atomic_op("and=09%w0, %w1, %w4",
+=09=09=09=09  ret, oldval, uaddr, tmp, ~oparg);
+=09=09break;
+=09case FUTEX_OP_XOR:
+=09=09__futex_atomic_op("eor=09%w0, %w1, %w4",
+=09=09=09=09  ret, oldval, uaddr, tmp, oparg);
+=09=09break;
+=09default:
+=09=09ret =3D -ENOSYS;
+=09}
+
+=09pagefault_enable();=09/* subsumes preempt_enable() */
+
+=09if (!ret) {
+=09=09switch (cmp) {
+=09=09case FUTEX_OP_CMP_EQ: ret =3D (oldval =3D=3D cmparg); break;
+=09=09case FUTEX_OP_CMP_NE: ret =3D (oldval !=3D cmparg); break;
+=09=09case FUTEX_OP_CMP_LT: ret =3D (oldval < cmparg); break;
+=09=09case FUTEX_OP_CMP_GE: ret =3D (oldval >=3D cmparg); break;
+=09=09case FUTEX_OP_CMP_LE: ret =3D (oldval <=3D cmparg); break;
+=09=09case FUTEX_OP_CMP_GT: ret =3D (oldval > cmparg); break;
+=09=09default: ret =3D -ENOSYS;
+=09=09}
+=09}
+=09return ret;
+}
+
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+=09=09=09      u32 oldval, u32 newval)
+{
+=09int ret =3D 0;
+=09u32 val, tmp;
+
+=09if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
+=09=09return -EFAULT;
+
+=09asm volatile("// futex_atomic_cmpxchg_inatomic\n"
+"1:=09ldaxr=09%w1, %2\n"
+"=09sub=09%w3, %w1, %w4\n"
+"=09cbnz=09%w3, 3f\n"
+"2:=09stlxr=09%w3, %w5, %2\n"
+"=09cbnz=09%w3, 1b\n"
+"3:\n"
+"=09.pushsection .fixup,\"ax\"\n"
+"4:=09mov=09%w0, %w6\n"
+"=09b=093b\n"
+"=09.popsection\n"
+"=09.pushsection __ex_table,\"a\"\n"
+"=09.align=093\n"
+"=09.quad=091b, 4b, 2b, 4b\n"
+"=09.popsection\n"
+=09: "+r" (ret), "=3D&r" (val), "+Q" (*uaddr), "=3D&r" (tmp)
+=09: "r" (oldval), "r" (newval), "Ir" (-EFAULT)
+=09: "cc", "memory");
+
+=09*uval =3D val;
+=09return ret;
+}
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_FUTEX_H */


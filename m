Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:45877 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751281AbWIOLam (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 07:30:42 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id k8FBUfdq090540
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 11:30:41 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8FBZKHP2744568
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 13:35:20 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8FBUeBp017071
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 13:30:40 +0200
Date: Fri, 15 Sep 2006 13:30:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/2] Directed yield: cpu_relax variants for spinlocks and rw-locks.
Message-ID: <20060915113039.GE23134@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch 1/2] Directed yield: cpu_relax variants for spinlocks and rw-locks.

In order to implement a spinlock that yields the cpu in favour of
the current lock holder cpu_relax variants for spinlocks and
read/write locks are needed. The new _raw_spin_relax, _raw_read_relax
and _raw_write_relax primitives have an additional argument: the
pointer to the lock structure.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-alpha/spinlock.h         |    4 ++++
 include/asm-arm/spinlock.h           |    4 ++++
 include/asm-cris/arch-v32/spinlock.h |    4 ++++
 include/asm-i386/spinlock.h          |    4 ++++
 include/asm-ia64/spinlock.h          |    4 ++++
 include/asm-m32r/spinlock.h          |    4 ++++
 include/asm-mips/spinlock.h          |    4 ++++
 include/asm-parisc/spinlock.h        |    4 ++++
 include/asm-powerpc/spinlock.h       |    4 ++++
 include/asm-ppc/spinlock.h           |    4 ++++
 include/asm-s390/spinlock.h          |    4 ++++
 include/asm-sh/spinlock.h            |    4 ++++
 include/asm-sparc/spinlock.h         |    4 ++++
 include/asm-sparc64/spinlock.h       |    4 ++++
 include/asm-x86_64/spinlock.h        |    4 ++++
 kernel/spinlock.c                    |    4 ++--
 16 files changed, 62 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/include/asm-alpha/spinlock.h linux-2.6-patched/include/asm-alpha/spinlock.h
--- linux-2.6/include/asm-alpha/spinlock.h	2006-09-15 12:17:46.000000000 +0200
+++ linux-2.6-patched/include/asm-alpha/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -166,4 +166,8 @@ static inline void __raw_write_unlock(ra
 	lock->lock = 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* _ALPHA_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-arm/spinlock.h linux-2.6-patched/include/asm-arm/spinlock.h
--- linux-2.6/include/asm-arm/spinlock.h	2006-09-15 12:17:46.000000000 +0200
+++ linux-2.6-patched/include/asm-arm/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -218,4 +218,8 @@ static inline int __raw_read_trylock(raw
 /* read_can_lock - would read_trylock() succeed? */
 #define __raw_read_can_lock(x)		((x)->lock < 0x80000000)
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-cris/arch-v32/spinlock.h linux-2.6-patched/include/asm-cris/arch-v32/spinlock.h
--- linux-2.6/include/asm-cris/arch-v32/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-cris/arch-v32/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -160,4 +160,8 @@ static __inline__ int is_write_locked(rw
 	return rw->counter < 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_ARCH_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-i386/spinlock.h linux-2.6-patched/include/asm-i386/spinlock.h
--- linux-2.6/include/asm-i386/spinlock.h	2006-09-15 12:17:47.000000000 +0200
+++ linux-2.6-patched/include/asm-i386/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -199,4 +199,8 @@ static inline void __raw_write_unlock(ra
 				 : "+m" (rw->lock) : : "memory");
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-ia64/spinlock.h linux-2.6-patched/include/asm-ia64/spinlock.h
--- linux-2.6/include/asm-ia64/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-ia64/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -213,4 +213,8 @@ static inline int __raw_read_trylock(raw
 	return (u32)ia64_cmpxchg4_acq((__u32 *)(x), new.word, old.word) == old.word;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /*  _ASM_IA64_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-m32r/spinlock.h linux-2.6-patched/include/asm-m32r/spinlock.h
--- linux-2.6/include/asm-m32r/spinlock.h	2006-09-15 12:17:47.000000000 +0200
+++ linux-2.6-patched/include/asm-m32r/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -309,4 +309,8 @@ static inline int __raw_write_trylock(ra
 	return 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif	/* _ASM_M32R_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-mips/spinlock.h linux-2.6-patched/include/asm-mips/spinlock.h
--- linux-2.6/include/asm-mips/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-mips/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -283,4 +283,8 @@ static inline int __raw_write_trylock(ra
 	return ret;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* _ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-parisc/spinlock.h linux-2.6-patched/include/asm-parisc/spinlock.h
--- linux-2.6/include/asm-parisc/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-parisc/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -152,4 +152,8 @@ static __inline__ int __raw_write_can_lo
 	return !rw->counter;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-powerpc/spinlock.h linux-2.6-patched/include/asm-powerpc/spinlock.h
--- linux-2.6/include/asm-powerpc/spinlock.h	2006-09-15 12:17:47.000000000 +0200
+++ linux-2.6-patched/include/asm-powerpc/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -285,5 +285,9 @@ static __inline__ void __raw_write_unloc
 	rw->lock = 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-ppc/spinlock.h linux-2.6-patched/include/asm-ppc/spinlock.h
--- linux-2.6/include/asm-ppc/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-ppc/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -161,4 +161,8 @@ static __inline__ void __raw_write_unloc
 	rw->lock = 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-s390/spinlock.h linux-2.6-patched/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -135,4 +135,8 @@ static inline int __raw_write_trylock(ra
 	return _raw_write_trylock_retry(rw);
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-sh/spinlock.h linux-2.6-patched/include/asm-sh/spinlock.h
--- linux-2.6/include/asm-sh/spinlock.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6-patched/include/asm-sh/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -100,4 +100,8 @@ static inline int __raw_write_trylock(ra
 	return 0;
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SH_SPINLOCK_H */
diff -urpN linux-2.6/include/asm-sparc/spinlock.h linux-2.6-patched/include/asm-sparc/spinlock.h
--- linux-2.6/include/asm-sparc/spinlock.h	2006-09-15 12:17:48.000000000 +0200
+++ linux-2.6-patched/include/asm-sparc/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -154,6 +154,10 @@ static inline int __raw_write_trylock(ra
 #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 #define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #define __raw_read_can_lock(rw) (!((rw)->lock & 0xff))
 #define __raw_write_can_lock(rw) (!(rw)->lock)
 
diff -urpN linux-2.6/include/asm-sparc64/spinlock.h linux-2.6-patched/include/asm-sparc64/spinlock.h
--- linux-2.6/include/asm-sparc64/spinlock.h	2006-09-15 12:17:48.000000000 +0200
+++ linux-2.6-patched/include/asm-sparc64/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -241,6 +241,10 @@ static int inline __write_trylock(raw_rw
 #define __raw_read_can_lock(rw)		(!((rw)->lock & 0x80000000UL))
 #define __raw_write_can_lock(rw)	(!(rw)->lock)
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC64_SPINLOCK_H) */
diff -urpN linux-2.6/include/asm-x86_64/spinlock.h linux-2.6-patched/include/asm-x86_64/spinlock.h
--- linux-2.6/include/asm-x86_64/spinlock.h	2006-09-15 12:17:48.000000000 +0200
+++ linux-2.6-patched/include/asm-x86_64/spinlock.h	2006-09-15 12:18:45.000000000 +0200
@@ -131,4 +131,8 @@ static inline void __raw_write_unlock(ra
 				: "=m" (rw->lock) : : "memory");
 }
 
+#define _raw_spin_relax(lock)	cpu_relax()
+#define _raw_read_relax(lock)	cpu_relax()
+#define _raw_write_relax(lock)	cpu_relax()
+
 #endif /* __ASM_SPINLOCK_H */
diff -urpN linux-2.6/kernel/spinlock.c linux-2.6-patched/kernel/spinlock.c
--- linux-2.6/kernel/spinlock.c	2006-09-15 12:17:52.000000000 +0200
+++ linux-2.6-patched/kernel/spinlock.c	2006-09-15 12:18:45.000000000 +0200
@@ -221,7 +221,7 @@ void __lockfunc _##op##_lock(locktype##_
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
 		while (!op##_can_lock(lock) && (lock)->break_lock)	\
-			cpu_relax();					\
+			_raw_##op##_relax(&lock->raw_lock);		\
 	}								\
 	(lock)->break_lock = 0;						\
 }									\
@@ -243,7 +243,7 @@ unsigned long __lockfunc _##op##_lock_ir
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
 		while (!op##_can_lock(lock) && (lock)->break_lock)	\
-			cpu_relax();					\
+			_raw_##op##_relax(&lock->raw_lock);		\
 	}								\
 	(lock)->break_lock = 0;						\
 	return flags;							\

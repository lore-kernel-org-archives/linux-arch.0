From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
Date: Wed, 26 Apr 2017 15:39:47 +0300
Message-ID: <20170426123947.ogap6xgg7xc5wsd4@yury-N73SV>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
 <20170413181212.y3ezah76qoztxhnn@hirez.programming.kicks-ass.net>
 <20170420182318.4ddtfiobxz6hgbo4@yury-N73SV>
 <20170420190530.GA6873@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0082.outbound.protection.outlook.com ([104.47.34.82]:7088
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1950835AbdDZMkC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Apr 2017 08:40:02 -0400
Content-Disposition: inline
In-Reply-To: <20170420190530.GA6873@worktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jan Glauber <jglauber@cavium.com>

On Thu, Apr 20, 2017 at 09:05:30PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 20, 2017 at 09:23:18PM +0300, Yury Norov wrote:
> > Is there some test to reproduce the locking failure for the case.
> 
> Possibly sysvsem stress before commit:
> 
>   27d7be1801a4 ("ipc/sem.c: avoid using spin_unlock_wait()")
> 
> Although a similar scheme is also used in nf_conntrack, see commit:
> 
>   b316ff783d17 ("locking/spinlock, netfilter: Fix nf_conntrack_lock() barriers")
> 
> > I
> > ask because I run loctorture for many hours on my qemu (emulating
> > cortex-a57), and I see no failures in the test reports. And Jan did it
> > on ThunderX, and Adam on QDF2400 without any problems. So even if I
> > rework those functions, how could I check them for correctness?
> 
> Running them doesn't prove them correct. Memory ordering bugs have been
> in the kernel for many years without 'ever' triggering. This is stuff
> you have to think about.
> 
> > Anyway, regarding the queued_spin_unlock_wait(), is my understanding
> > correct that you assume adding smp_mb() before entering the for(;;)
> > cycle, and using ldaxr/strxr instead of atomic_read()?
> 
> You'll have to ask Will, I always forget the arm64 details.

So, below is what I have. For queued_spin_unlock_wait() the generated
code is looking like this:
ffff0000080983a0 <queued_spin_unlock_wait>:
ffff0000080983a0:       d5033bbf        dmb     ish
ffff0000080983a4:       b9400007        ldr     w7, [x0]
ffff0000080983a8:       350000c7        cbnz    w7, ffff0000080983c0 <queued_spin_unlock_wait+0x20>
ffff0000080983ac:       1400000e        b       ffff0000080983e4 <queued_spin_unlock_wait+0x44>
ffff0000080983b0:       d503203f        yield
ffff0000080983b4:       d5033bbf        dmb     ish
ffff0000080983b8:       b9400007        ldr     w7, [x0]
ffff0000080983bc:       34000147        cbz     w7, ffff0000080983e4 <queued_spin_unlock_wait+0x44>
ffff0000080983c0:       f2401cff        tst     x7, #0xff
ffff0000080983c4:       54ffff60        b.eq    ffff0000080983b0 <queued_spin_unlock_wait+0x10>
ffff0000080983c8:       14000003        b       ffff0000080983d4 <queued_spin_unlock_wait+0x34>
ffff0000080983cc:       d503201f        nop
ffff0000080983d0:       d503203f        yield
ffff0000080983d4:       d5033bbf        dmb     ish
ffff0000080983d8:       b9400007        ldr     w7, [x0]
ffff0000080983dc:       f2401cff        tst     x7, #0xff
ffff0000080983e0:       54ffff81        b.ne    ffff0000080983d0 <queued_spin_unlock_wait+0x30>
ffff0000080983e4:       d50339bf        dmb     ishld
ffff0000080983e8:       d65f03c0        ret
ffff0000080983ec:       d503201f        nop

If I understand the documentation correctly, it's enough to check the lock
properly. If not - please give me the clue. Will?

Yury

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 22dbde97eefa..2d80161ee367 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -25,6 +25,8 @@ config ARM64
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_USE_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_RWLOCKS
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
diff --git a/arch/arm64/include/asm/qrwlock.h b/arch/arm64/include/asm/qrwlock.h
new file mode 100644
index 000000000000..626f6ebfb52d
--- /dev/null
+++ b/arch/arm64/include/asm/qrwlock.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_ARM64_QRWLOCK_H
+#define _ASM_ARM64_QRWLOCK_H
+
+#include <asm-generic/qrwlock_types.h>
+#include <asm-generic/qrwlock.h>
+
+#endif /* _ASM_ARM64_QRWLOCK_H */
diff --git a/arch/arm64/include/asm/qspinlock.h b/arch/arm64/include/asm/qspinlock.h
new file mode 100644
index 000000000000..09ef4f13f549
--- /dev/null
+++ b/arch/arm64/include/asm/qspinlock.h
@@ -0,0 +1,42 @@
+#ifndef _ASM_ARM64_QSPINLOCK_H
+#define _ASM_ARM64_QSPINLOCK_H
+
+#include <asm-generic/qspinlock_types.h>
+#include <asm/atomic.h>
+
+extern void queued_spin_unlock_wait(struct qspinlock *lock);
+#define queued_spin_unlock_wait queued_spin_unlock_wait
+
+#define	queued_spin_unlock queued_spin_unlock
+/**
+ * queued_spin_unlock - release a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ *
+ * A smp_store_release() on the least-significant byte.
+ */
+static __always_inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	smp_store_release((u8 *)lock, 0);
+}
+
+#define queued_spin_is_locked queued_spin_is_locked
+/**
+ * queued_spin_is_locked - is the spinlock locked?
+ * @lock: Pointer to queued spinlock structure
+ * Return: 1 if it is locked, 0 otherwise
+ */
+static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
+{
+	/*
+	 * See queued_spin_unlock_wait().
+	 *
+	 * Any !0 state indicates it is locked, even if _Q_LOCKED_VAL
+	 * isn't immediately observable.
+	 */
+	smp_mb();
+	return atomic_read(&lock->val);
+}
+
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_ARM64_QSPINLOCK_H */
diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index cae331d553f8..37713397e0c5 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -20,6 +20,10 @@
 #include <asm/spinlock_types.h>
 #include <asm/processor.h>
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#else
+
 /*
  * Spinlock implementation.
  *
@@ -187,6 +191,12 @@ static inline int arch_spin_is_contended(arch_spinlock_t *lock)
 }
 #define arch_spin_is_contended	arch_spin_is_contended
 
+#endif /* CONFIG_QUEUED_SPINLOCKS */
+
+#ifdef CONFIG_QUEUED_RWLOCKS
+#include <asm/qrwlock.h>
+#else
+
 /*
  * Write lock implementation.
  *
@@ -351,6 +361,8 @@ static inline int arch_read_trylock(arch_rwlock_t *rw)
 /* read_can_lock - would read_trylock() succeed? */
 #define arch_read_can_lock(x)		((x)->lock < 0x80000000)
 
+#endif /* CONFIG_QUEUED_RWLOCKS */
+
 #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
 #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
 
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm/spinlock_types.h
index 55be59a35e3f..0f0f1561ab6a 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -16,9 +16,9 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
 
-#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
-# error "please don't include this file directly"
-#endif
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock_types.h>
+#else
 
 #include <linux/types.h>
 
@@ -36,10 +36,18 @@ typedef struct {
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 , 0 }
 
+#endif /* CONFIG_QUEUED_SPINLOCKS */
+
+#ifdef CONFIG_QUEUED_RWLOCKS
+#include <asm-generic/qrwlock_types.h>
+#else
+
 typedef struct {
 	volatile unsigned int lock;
 } arch_rwlock_t;
 
 #define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
 
+#endif /* CONFIG_QUEUED_RWLOCKS */
+
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 9d56467dc223..f48f6256e893 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -56,6 +56,7 @@ arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
+arm64-obj-$(CONFIG_QUEUED_SPINLOCKS)	+= qspinlock.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
 obj-$(CONFIG_ARM64_ILP32)		+= vdso-ilp32/
diff --git a/arch/arm64/kernel/qspinlock.c b/arch/arm64/kernel/qspinlock.c
new file mode 100644
index 000000000000..924f19953adb
--- /dev/null
+++ b/arch/arm64/kernel/qspinlock.c
@@ -0,0 +1,34 @@
+#include <asm/qspinlock.h>
+#include <asm/processor.h>
+
+void queued_spin_unlock_wait(struct qspinlock *lock)
+{
+	u32 val;
+
+	for (;;) {
+		smp_mb();
+		val = atomic_read(&lock->val);
+
+		if (!val) /* not locked, we're done */
+			goto done;
+
+		if (val & _Q_LOCKED_MASK) /* locked, go wait for unlock */
+			break;
+
+		/* not locked, but pending, wait until we observe the lock */
+		cpu_relax();
+	}
+
+	for (;;) {
+		smp_mb();
+		val = atomic_read(&lock->val);
+		if (!(val & _Q_LOCKED_MASK)) /* any unlock is good */
+			break;
+
+		cpu_relax();
+	}
+
+done:
+	smp_acquire__after_ctrl_dep();
+}
+EXPORT_SYMBOL(queued_spin_unlock_wait);
-- 
2.11.0

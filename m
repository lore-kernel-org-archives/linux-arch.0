From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 6/8] powerpc/pseries: implement paravirt qspinlocks for SPLPAR
Date: Thu,  2 Jul 2020 17:48:37 +1000
Message-ID: <20200702074839.1057733-7-npiggin@gmail.com>
References: <20200702074839.1057733-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgGBHtZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 03:49:25 -0400
In-Reply-To: <20200702074839.1057733-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/paravirt.h           | 23 ++++++++
 arch/powerpc/include/asm/qspinlock.h          | 55 +++++++++++++++++++
 arch/powerpc/include/asm/qspinlock_paravirt.h |  5 ++
 arch/powerpc/platforms/pseries/Kconfig        |  5 ++
 arch/powerpc/platforms/pseries/setup.c        |  6 +-
 include/asm-generic/qspinlock.h               |  2 +
 6 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h

diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
index 7a8546660a63..5fae9dfa6fe9 100644
--- a/arch/powerpc/include/asm/paravirt.h
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -29,6 +29,16 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
 {
 	plpar_hcall_norets(H_CONFER, get_hard_smp_processor_id(cpu), yield_count);
 }
+
+static inline void prod_cpu(int cpu)
+{
+	plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
+}
+
+static inline void yield_to_any(void)
+{
+	plpar_hcall_norets(H_CONFER, -1, 0);
+}
 #else
 static inline bool is_shared_processor(void)
 {
@@ -45,6 +55,19 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
 {
 	___bad_yield_to_preempted(); /* This would be a bug */
 }
+
+extern void ___bad_yield_to_any(void);
+static inline void yield_to_any(void)
+{
+	___bad_yield_to_any(); /* This would be a bug */
+}
+
+extern void ___bad_prod_cpu(void);
+static inline void prod_cpu(int cpu)
+{
+	___bad_prod_cpu(); /* This would be a bug */
+}
+
 #endif
 
 #define vcpu_is_preempted vcpu_is_preempted
diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index f84da77b6bb7..997a9a32df77 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -3,9 +3,36 @@
 #define _ASM_POWERPC_QSPINLOCK_H
 
 #include <asm-generic/qspinlock_types.h>
+#include <asm/paravirt.h>
 
 #define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+static __always_inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	if (!is_shared_processor())
+		native_queued_spin_lock_slowpath(lock, val);
+	else
+		__pv_queued_spin_lock_slowpath(lock, val);
+}
+#else
+extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+#endif
+
+static __always_inline void queued_spin_lock(struct qspinlock *lock)
+{
+	u32 val = 0;
+
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
+		return;
+
+	queued_spin_lock_slowpath(lock, val);
+}
+#define queued_spin_lock queued_spin_lock
+
 #define smp_mb__after_spinlock()   smp_mb()
 
 static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
@@ -15,6 +42,34 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 }
 #define queued_spin_is_locked queued_spin_is_locked
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define SPIN_THRESHOLD (1<<15) /* not tuned */
+
+static __always_inline void pv_wait(u8 *ptr, u8 val)
+{
+	if (*ptr != val)
+		return;
+	yield_to_any();
+	/*
+	 * We could pass in a CPU here if waiting in the queue and yield to
+	 * the previous CPU in the queue.
+	 */
+}
+
+static __always_inline void pv_kick(int cpu)
+{
+	prod_cpu(cpu);
+}
+
+extern void __pv_init_lock_hash(void);
+
+static inline void pv_spinlocks_init(void)
+{
+	__pv_init_lock_hash();
+}
+
+#endif
+
 #include <asm-generic/qspinlock.h>
 
 #endif /* _ASM_POWERPC_QSPINLOCK_H */
diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerpc/include/asm/qspinlock_paravirt.h
new file mode 100644
index 000000000000..6dbdb8a4f84f
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_QSPINLOCK_PARAVIRT_H
+#define __ASM_QSPINLOCK_PARAVIRT_H
+
+#endif /* __ASM_QSPINLOCK_PARAVIRT_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 24c18362e5ea..756e727b383f 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -25,9 +25,14 @@ config PPC_PSERIES
 	select SWIOTLB
 	default y
 
+config PARAVIRT_SPINLOCKS
+	bool
+	default n
+
 config PPC_SPLPAR
 	depends on PPC_PSERIES
 	bool "Support for shared-processor logical partitions"
+	select PARAVIRT_SPINLOCKS if PPC_QUEUED_SPINLOCKS
 	help
 	  Enabling this option will make the kernel run more efficiently
 	  on logically-partitioned pSeries systems which use shared
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 2db8469e475f..747a203d9453 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -771,8 +771,12 @@ static void __init pSeries_setup_arch(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		vpa_init(boot_cpuid);
 
-		if (lppaca_shared_proc(get_lppaca()))
+		if (lppaca_shared_proc(get_lppaca())) {
 			static_branch_enable(&shared_processor);
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+			pv_spinlocks_init();
+#endif
+		}
 
 		ppc_md.power_save = pseries_lpar_idle;
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index fb0a814d4395..38ca14e79a86 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -69,6 +69,7 @@ static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 
+#ifndef queued_spin_lock
 /**
  * queued_spin_lock - acquire a queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -82,6 +83,7 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 
 	queued_spin_lock_slowpath(lock, val);
 }
+#endif
 
 #ifndef queued_spin_unlock
 /**
-- 
2.23.0

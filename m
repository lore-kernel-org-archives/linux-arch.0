Return-Path: <SRS0=hCR/=AV=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
Date: Fri, 10 Jul 2020 11:56:46 +1000
Message-ID: <20200710015646.2020871-8-npiggin@gmail.com>
In-Reply-To: <20200710015646.2020871-1-npiggin@gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200710015646.UjC8ivg62tft8meTS1DZxRy_jvVegu0mrklVBFP4Hgw@z>

On big systems, the mm refcount can become highly contented when doing
a lot of context switching with threaded applications (particularly
switching between the idle thread and an application thread).

Abandoning lazy tlb slows switching down quite a bit in the important
user->idle->user cases, so so instead implement a non-refcounted scheme
that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
any remaining lazy ones.

On a 16-socket 192-core POWER8 system, a context switching benchmark
with as many software threads as CPUs (so each switch will go in and
out of idle), upstream can achieve a rate of about 1 million context
switches per second. After this patch it goes up to 118 million.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig             | 16 ++++++++++++++++
 arch/powerpc/Kconfig     |  1 +
 include/linux/sched/mm.h |  6 +++---
 kernel/fork.c            | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2daf8fe6146a..edf69437a971 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -418,6 +418,22 @@ config MMU_LAZY_TLB
 	help
 	  Enable "lazy TLB" mmu context switching for kernel threads.
=20
+config MMU_LAZY_TLB_REFCOUNT
+	def_bool y
+	depends on MMU_LAZY_TLB
+	depends on !MMU_LAZY_TLB_SHOOTDOWN
+
+config MMU_LAZY_TLB_SHOOTDOWN
+	bool
+	depends on MMU_LAZY_TLB
+	help
+	  Instead of refcounting the "lazy tlb" mm struct, which can cause
+	  contention with multi-threaded apps on large multiprocessor systems,
+	  this option causes __mmdrop to IPI all CPUs in the mm_cpumask and
+	  switch to init_mm if they were using the to-be-freed mm as the lazy
+	  tlb. Architectures which do not track all possible lazy tlb CPUs in
+	  mm_cpumask can not use this (without modification).
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
=20
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 920c4e3ca4ef..24ac85c868db 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -225,6 +225,7 @@ config PPC
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_PAGE_SIZE
+	select MMU_LAZY_TLB_SHOOTDOWN
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2c2b20e2ccc7..1067af8039bd 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -53,19 +53,19 @@ void mmdrop(struct mm_struct *mm);
 /* Helpers for lazy TLB mm refcounting */
 static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
 {
-	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
 		mmgrab(mm);
 }
=20
 static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
 {
-	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
 		mmdrop(mm);
 }
=20
 static inline void mmdrop_lazy_tlb_smp_mb(struct mm_struct *mm)
 {
-	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
 		mmdrop(mm); /* This depends on mmdrop providing a full smp_mb() */
 	else
 		smp_mb();
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..da0fba9e6079 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -685,6 +685,40 @@ static void check_mm(struct mm_struct *mm)
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, GFP_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
=20
+static void do_shoot_lazy_tlb(void *arg)
+{
+	struct mm_struct *mm =3D arg;
+
+	if (current->active_mm =3D=3D mm) {
+		BUG_ON(current->mm);
+		switch_mm(mm, &init_mm, current);
+		current->active_mm =3D &init_mm;
+	}
+}
+
+static void do_check_lazy_tlb(void *arg)
+{
+	struct mm_struct *mm =3D arg;
+
+	BUG_ON(current->active_mm =3D=3D mm);
+}
+
+static void shoot_lazy_tlbs(struct mm_struct *mm)
+{
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
+		smp_call_function_many(mm_cpumask(mm), do_shoot_lazy_tlb, (void *)mm, =
1);
+		do_shoot_lazy_tlb(mm);
+	}
+}
+
+static void check_lazy_tlbs(struct mm_struct *mm)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+		smp_call_function(do_check_lazy_tlb, (void *)mm, 1);
+		do_check_lazy_tlb(mm);
+	}
+}
+
 /*
  * Called when the last reference to the mm
  * is dropped: either by a lazy thread or by
@@ -695,6 +729,11 @@ void __mmdrop(struct mm_struct *mm)
 	BUG_ON(mm =3D=3D &init_mm);
 	WARN_ON_ONCE(mm =3D=3D current->mm);
 	WARN_ON_ONCE(mm =3D=3D current->active_mm);
+
+	/* Ensure no CPUs are using this as their lazy tlb mm */
+	shoot_lazy_tlbs(mm);
+	check_lazy_tlbs(mm);
+
 	mm_free_pgd(mm);
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
--=20
2.23.0

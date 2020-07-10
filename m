Return-Path: <SRS0=hCR/=AV=kvack.org=owner-linux-mm@kernel.org>
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 2/7] arch: use asm-generic mmu context for no-op implementations
Date: Fri, 10 Jul 2020 11:56:41 +1000
Message-ID: <20200710015646.2020871-3-npiggin@gmail.com>
In-Reply-To: <20200710015646.2020871-1-npiggin@gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: linux-arch@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200710015641.fF1fQ6zlfTk-ADGh4YCiI3jqQz5k7qE8suE7ZATZtBw@z>

This patch bunches all architectures together. If the general idea is
accepted I will split them individually. Some architectures can go
further e.g., with consolidating switch_mm and activate_mm but I
only did the more obvious ones.
---
 arch/alpha/include/asm/mmu_context.h         | 12 ++---
 arch/arc/include/asm/mmu_context.h           | 16 +++----
 arch/arm/include/asm/mmu_context.h           | 26 ++---------
 arch/arm64/include/asm/mmu_context.h         |  7 ++-
 arch/csky/include/asm/mmu_context.h          |  8 ++--
 arch/hexagon/include/asm/mmu_context.h       | 33 +++-----------
 arch/ia64/include/asm/mmu_context.h          | 17 ++-----
 arch/m68k/include/asm/mmu_context.h          | 47 ++++----------------
 arch/microblaze/include/asm/mmu_context_mm.h |  8 ++--
 arch/microblaze/include/asm/processor.h      |  3 --
 arch/mips/include/asm/mmu_context.h          | 11 ++---
 arch/nds32/include/asm/mmu_context.h         | 10 +----
 arch/nios2/include/asm/mmu_context.h         | 21 ++-------
 arch/nios2/mm/mmu_context.c                  |  1 +
 arch/openrisc/include/asm/mmu_context.h      |  8 ++--
 arch/openrisc/mm/tlb.c                       |  2 +
 arch/parisc/include/asm/mmu_context.h        | 12 ++---
 arch/powerpc/include/asm/mmu_context.h       | 22 +++------
 arch/riscv/include/asm/mmu_context.h         | 22 +--------
 arch/s390/include/asm/mmu_context.h          |  9 ++--
 arch/sh/include/asm/mmu_context.h            |  5 +--
 arch/sh/include/asm/mmu_context_32.h         |  9 ----
 arch/sparc/include/asm/mmu_context_32.h      | 10 ++---
 arch/sparc/include/asm/mmu_context_64.h      | 10 ++---
 arch/um/include/asm/mmu_context.h            | 12 +++--
 arch/unicore32/include/asm/mmu_context.h     | 24 ++--------
 arch/x86/include/asm/mmu_context.h           |  6 +++
 arch/xtensa/include/asm/mmu_context.h        | 11 ++---
 arch/xtensa/include/asm/nommu_context.h      | 26 +----------
 29 files changed, 106 insertions(+), 302 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/as=
m/mmu_context.h
index 6d7d9bc1b4b8..4eea7c616992 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -214,8 +214,6 @@ ev4_activate_mm(struct mm_struct *prev_mm, struct mm_=
struct *next_mm)
 	tbiap();
 }
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 #ifdef CONFIG_ALPHA_GENERIC
 # define switch_mm(a,b,c)	alpha_mv.mv_switch_mm((a),(b),(c))
 # define activate_mm(x,y)	alpha_mv.mv_activate_mm((x),(y))
@@ -229,6 +227,7 @@ ev4_activate_mm(struct mm_struct *prev_mm, struct mm_=
struct *next_mm)
 # endif
 #endif
=20
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -242,12 +241,7 @@ init_new_context(struct task_struct *tsk, struct mm_=
struct *mm)
 	return 0;
 }
=20
-extern inline void
-destroy_context(struct mm_struct *mm)
-{
-	/* Nothing to do.  */
-}
-
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -255,6 +249,8 @@ enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
 	  =3D ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 }
=20
+#include <asm-generic/mmu_context.h>
+
 #ifdef __MMU_EXTERN_INLINE
 #undef __EXTERN_INLINE
 #undef __MMU_EXTERN_INLINE
diff --git a/arch/arc/include/asm/mmu_context.h b/arch/arc/include/asm/mm=
u_context.h
index 3a5e6a5b9ed6..586d31902a99 100644
--- a/arch/arc/include/asm/mmu_context.h
+++ b/arch/arc/include/asm/mmu_context.h
@@ -102,6 +102,7 @@ static inline void get_new_mmu_context(struct mm_stru=
ct *mm)
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -113,6 +114,7 @@ init_new_context(struct task_struct *tsk, struct mm_s=
truct *mm)
 	return 0;
 }
=20
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	unsigned long flags;
@@ -153,13 +155,12 @@ static inline void switch_mm(struct mm_struct *prev=
, struct mm_struct *next,
 }
=20
 /*
- * Called at the time of execve() to get a new ASID
- * Note the subtlety here: get_new_mmu_context() behaves differently her=
e
- * vs. in switch_mm(). Here it always returns a new ASID, because mm has
- * an unallocated "initial" value, while in latter, it moves to a new AS=
ID,
- * only if it was unallocated
+ * activate_mm defaults to switch_mm and is called at the time of execve=
() to
+ * get a new ASID Note the subtlety here: get_new_mmu_context() behaves
+ * differently here vs. in switch_mm(). Here it always returns a new ASI=
D,
+ * because mm has an unallocated "initial" value, while in latter, it mo=
ves to
+ * a new ASID, only if it was unallocated
  */
-#define activate_mm(prev, next)		switch_mm(prev, next, NULL)
=20
 /* it seemed that deactivate_mm( ) is a reasonable place to do book-keep=
ing
  * for retiring-mm. However destroy_context( ) still needs to do that be=
cause
@@ -168,8 +169,7 @@ static inline void switch_mm(struct mm_struct *prev, =
struct mm_struct *next,
  * there is a good chance that task gets sched-out/in, making it's ASID =
valid
  * again (this teased me for a whole day).
  */
-#define deactivate_mm(tsk, mm)   do { } while (0)
=20
-#define enter_lazy_tlb(mm, tsk)
+#include <asm-generic/mmu_context.h>
=20
 #endif /* __ASM_ARC_MMU_CONTEXT_H */
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mm=
u_context.h
index f99ed524fe41..84e58956fcab 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -26,6 +26,8 @@ void __check_vmalloc_seq(struct mm_struct *mm);
 #ifdef CONFIG_CPU_HAS_ASID
=20
 void check_and_switch_context(struct mm_struct *mm, struct task_struct *=
tsk);
+
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -92,32 +94,10 @@ static inline void finish_arch_post_lock_switch(void)
=20
 #endif	/* CONFIG_MMU */
=20
-static inline int
-init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	return 0;
-}
-
-
 #endif	/* CONFIG_CPU_HAS_ASID */
=20
-#define destroy_context(mm)		do { } while(0)
 #define activate_mm(prev,next)		switch_mm(prev, next, NULL)
=20
-/*
- * This is called when "tsk" is about to enter lazy TLB mode.
- *
- * mm:  describes the currently active mm context
- * tsk: task which is entering lazy tlb
- * cpu: cpu number which is entering lazy tlb
- *
- * tsk->mm will be NULL
- */
-static inline void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * This is the actual mm switch as far as the scheduler
  * is concerned.  No registers are touched.  We avoid
@@ -149,6 +129,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *n=
ext,
 #endif
 }
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
+#include <asm-generic/mmu_context.h>
=20
 #endif
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/as=
m/mmu_context.h
index b0bd9b55594c..0f5e351f586a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -174,7 +174,6 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
  * Setting a reserved TTBR0 or EPD0 would work, but it all gets ugly whe=
n you
  * take CPU migration into account.
  */
-#define destroy_context(mm)		do { } while(0)
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
=20
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); =
0; })
@@ -202,6 +201,7 @@ static inline void update_saved_ttbr0(struct task_str=
uct *tsk,
 }
 #endif
=20
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -244,12 +244,11 @@ switch_mm(struct mm_struct *prev, struct mm_struct =
*next,
 	update_saved_ttbr0(tsk, next);
 }
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-#define activate_mm(prev,next)	switch_mm(prev, next, current)
-
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
=20
+#include <asm-generic/mmu_context.h>
+
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* !__ASM_MMU_CONTEXT_H */
diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/=
mmu_context.h
index abdf1f1cb6ec..b227d29393a8 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -24,11 +24,6 @@
 #define cpu_asid(mm)		(atomic64_read(&mm->context.asid) & ASID_MASK)
=20
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.asid, 0)=
; 0; })
-#define activate_mm(prev,next)		switch_mm(prev, next, current)
-
-#define destroy_context(mm)		do {} while (0)
-#define enter_lazy_tlb(mm, tsk)		do {} while (0)
-#define deactivate_mm(tsk, mm)		do {} while (0)
=20
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
=20
@@ -46,4 +41,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *nex=
t,
=20
 	flush_icache_deferred(next);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif /* __ASM_CSKY_MMU_CONTEXT_H */
diff --git a/arch/hexagon/include/asm/mmu_context.h b/arch/hexagon/includ=
e/asm/mmu_context.h
index cdc4adc0300a..81947764c47d 100644
--- a/arch/hexagon/include/asm/mmu_context.h
+++ b/arch/hexagon/include/asm/mmu_context.h
@@ -15,39 +15,13 @@
 #include <asm/pgalloc.h>
 #include <asm/mem-layout.h>
=20
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 /*
  * VM port hides all TLB management, so "lazy TLB" isn't very
  * meaningful.  Even for ports to architectures with visble TLBs,
  * this is almost invariably a null function.
+ *
+ * mm->context is set up by pgd_alloc, so no init_new_context required.
  */
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-	struct task_struct *tsk)
-{
-}
-
-/*
- * Architecture-specific actions, if any, for memory map deactivation.
- */
-static inline void deactivate_mm(struct task_struct *tsk,
-	struct mm_struct *mm)
-{
-}
-
-/**
- * init_new_context - initialize context related info for new mm_struct =
instance
- * @tsk: pointer to a task struct
- * @mm: pointer to a new mm struct
- */
-static inline int init_new_context(struct task_struct *tsk,
-					struct mm_struct *mm)
-{
-	/* mm->context is set up by pgd_alloc */
-	return 0;
-}
=20
 /*
  *  Switch active mm context
@@ -74,6 +48,7 @@ static inline void switch_mm(struct mm_struct *prev, st=
ruct mm_struct *next,
 /*
  *  Activate new memory map for task
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct =
*next)
 {
 	unsigned long flags;
@@ -86,4 +61,6 @@ static inline void activate_mm(struct mm_struct *prev, =
struct mm_struct *next)
 /*  Generic hooks for arch_dup_mmap and arch_exit_mmap  */
 #include <asm-generic/mm_hooks.h>
=20
+#include <asm-generic/mmu_context.h>
+
 #endif
diff --git a/arch/ia64/include/asm/mmu_context.h b/arch/ia64/include/asm/=
mmu_context.h
index 2da0e2eb036b..87a0d5bc11ef 100644
--- a/arch/ia64/include/asm/mmu_context.h
+++ b/arch/ia64/include/asm/mmu_context.h
@@ -49,11 +49,6 @@ DECLARE_PER_CPU(u8, ia64_need_tlb_flush);
 extern void mmu_context_init (void);
 extern void wrap_mmu_context (struct mm_struct *mm);
=20
-static inline void
-enter_lazy_tlb (struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * When the context counter wraps around all TLBs need to be flushed bec=
ause
  * an old context number might have been reused. This is signalled by th=
e
@@ -116,6 +111,7 @@ get_mmu_context (struct mm_struct *mm)
  * Initialize context number to some sane value.  MM is guaranteed to be=
 a
  * brand-new address-space, so no TLB flushing is needed, ever.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context (struct task_struct *p, struct mm_struct *mm)
 {
@@ -123,12 +119,6 @@ init_new_context (struct task_struct *p, struct mm_s=
truct *mm)
 	return 0;
 }
=20
-static inline void
-destroy_context (struct mm_struct *mm)
-{
-	/* Nothing to do.  */
-}
-
 static inline void
 reload_context (nv_mm_context_t context)
 {
@@ -178,11 +168,10 @@ activate_context (struct mm_struct *mm)
 	} while (unlikely(context !=3D mm->context));
 }
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 /*
  * Switch from address space PREV to address space NEXT.
  */
+#define activate_mm activate_mm
 static inline void
 activate_mm (struct mm_struct *prev, struct mm_struct *next)
 {
@@ -196,5 +185,7 @@ activate_mm (struct mm_struct *prev, struct mm_struct=
 *next)
=20
 #define switch_mm(prev_mm,next_mm,next_task)	activate_mm(prev_mm, next_m=
m)
=20
+#include <asm-generic/mmu_context.h>
+
 # endif /* ! __ASSEMBLY__ */
 #endif /* _ASM_IA64_MMU_CONTEXT_H */
diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/=
mmu_context.h
index cac9f289d1f6..56ae27322178 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -5,10 +5,6 @@
 #include <asm-generic/mm_hooks.h>
 #include <linux/mm_types.h>
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
-
 #ifdef CONFIG_MMU
=20
 #if defined(CONFIG_COLDFIRE)
@@ -58,6 +54,7 @@ static inline void get_mmu_context(struct mm_struct *mm=
)
 /*
  * We're finished using the context for an address space.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context !=3D NO_CONTEXT) {
@@ -79,19 +76,6 @@ static inline void switch_mm(struct mm_struct *prev, s=
truct mm_struct *next,
 	set_context(tsk->mm->context, next->pgd);
 }
=20
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-static inline void activate_mm(struct mm_struct *active_mm,
-	struct mm_struct *mm)
-{
-	get_mmu_context(mm);
-	set_context(mm->context, mm->pgd);
-}
-
-#define deactivate_mm(tsk, mm) do { } while (0)
-
 #define prepare_arch_switch(next) load_ksp_mmu(next)
=20
 static inline void load_ksp_mmu(struct task_struct *task)
@@ -176,6 +160,7 @@ extern unsigned long get_free_context(struct mm_struc=
t *mm);
 extern void clear_context(unsigned long context);
=20
 /* set the context for a new task to unmapped */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -210,8 +195,7 @@ static inline void switch_mm(struct mm_struct *prev, =
struct mm_struct *next,
 	activate_context(tsk->mm);
 }
=20
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
@@ -224,6 +208,7 @@ static inline void activate_mm(struct mm_struct *prev=
_mm,
 #include <asm/page.h>
 #include <asm/pgalloc.h>
=20
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -231,8 +216,6 @@ static inline int init_new_context(struct task_struct=
 *tsk,
 	return 0;
 }
=20
-#define destroy_context(mm)		do { } while(0)
-
 static inline void switch_mm_0230(struct mm_struct *mm)
 {
 	unsigned long crp[2] =3D {
@@ -300,8 +283,7 @@ static inline void switch_mm(struct mm_struct *prev, =
struct mm_struct *next, str
 	}
 }
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
@@ -315,24 +297,11 @@ static inline void activate_mm(struct mm_struct *pr=
ev_mm,
=20
 #endif
=20
-#else /* !CONFIG_MMU */
+#include <asm-generic/mmu_context.h>
=20
-static inline int init_new_context(struct task_struct *tsk, struct mm_st=
ruct *mm)
-{
-	return 0;
-}
-
-
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *n=
ext, struct task_struct *tsk)
-{
-}
-
-#define destroy_context(mm)	do { } while (0)
-#define deactivate_mm(tsk,mm)	do { } while (0)
+#else /* !CONFIG_MMU */
=20
-static inline void activate_mm(struct mm_struct *prev_mm, struct mm_stru=
ct *next_mm)
-{
-}
+#include <asm-generic/nommu_context.h>
=20
 #endif /* CONFIG_MMU */
 #endif /* __M68K_MMU_CONTEXT_H */
diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microbla=
ze/include/asm/mmu_context_mm.h
index a1c7dd48454c..c2c77f708455 100644
--- a/arch/microblaze/include/asm/mmu_context_mm.h
+++ b/arch/microblaze/include/asm/mmu_context_mm.h
@@ -33,10 +33,6 @@
    to represent all kernel pages as shared among all contexts.
  */
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
-
 # define NO_CONTEXT	256
 # define LAST_CONTEXT	255
 # define FIRST_CONTEXT	1
@@ -105,6 +101,7 @@ static inline void get_mmu_context(struct mm_struct *=
mm)
 /*
  * We're finished using the context for an address space.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context !=3D NO_CONTEXT) {
@@ -126,6 +123,7 @@ static inline void switch_mm(struct mm_struct *prev, =
struct mm_struct *next,
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *active_mm,
 			struct mm_struct *mm)
 {
@@ -136,5 +134,7 @@ static inline void activate_mm(struct mm_struct *acti=
ve_mm,
=20
 extern void mmu_context_init(void);
=20
+#include <asm-generic/mmu_context.h>
+
 # endif /* __KERNEL__ */
 #endif /* _ASM_MICROBLAZE_MMU_CONTEXT_H */
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/in=
clude/asm/processor.h
index 1ff5a82b76b6..616211871a6e 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -122,9 +122,6 @@ unsigned long get_wchan(struct task_struct *p);
 #  define KSTK_EIP(task)	(task_pc(task))
 #  define KSTK_ESP(task)	(task_sp(task))
=20
-/* FIXME */
-#  define deactivate_mm(tsk, mm)	do { } while (0)
-
 #  define STACK_TOP	TASK_SIZE
 #  define STACK_TOP_MAX	STACK_TOP
=20
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/=
mmu_context.h
index cddead91acd4..ed9f2d748f63 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -124,10 +124,6 @@ static inline void set_cpu_context(unsigned int cpu,
 #define cpu_asid(cpu, mm) \
 	(cpu_context((cpu), (mm)) & cpu_asid_mask(&cpu_data[cpu]))
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
-
 extern void get_new_mmu_context(struct mm_struct *mm);
 extern void check_mmu_context(struct mm_struct *mm);
 extern void check_switch_mmu_context(struct mm_struct *mm);
@@ -136,6 +132,7 @@ extern void check_switch_mmu_context(struct mm_struct=
 *mm);
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -180,14 +177,12 @@ static inline void switch_mm(struct mm_struct *prev=
, struct mm_struct *next,
  * Destroy context related info for an mm_struct that is about
  * to be put to rest.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	dsemul_mm_cleanup(mm);
 }
=20
-#define activate_mm(prev, next)	switch_mm(prev, next, current)
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
 static inline void
 drop_mmu_context(struct mm_struct *mm)
 {
@@ -237,4 +232,6 @@ drop_mmu_context(struct mm_struct *mm)
 	local_irq_restore(flags);
 }
=20
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_MMU_CONTEXT_H */
diff --git a/arch/nds32/include/asm/mmu_context.h b/arch/nds32/include/as=
m/mmu_context.h
index b8fd3d189fdc..c651bc8cacdc 100644
--- a/arch/nds32/include/asm/mmu_context.h
+++ b/arch/nds32/include/asm/mmu_context.h
@@ -9,6 +9,7 @@
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
=20
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -16,8 +17,6 @@ init_new_context(struct task_struct *tsk, struct mm_str=
uct *mm)
 	return 0;
 }
=20
-#define destroy_context(mm)	do { } while(0)
-
 #define CID_BITS	9
 extern spinlock_t cid_lock;
 extern unsigned int cpu_last_cid;
@@ -47,10 +46,6 @@ static inline void check_context(struct mm_struct *mm)
 		__new_context(mm);
 }
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
-
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *n=
ext,
 			     struct task_struct *tsk)
 {
@@ -62,7 +57,6 @@ static inline void switch_mm(struct mm_struct *prev, st=
ruct mm_struct *next,
 	}
 }
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-#define activate_mm(prev,next)	switch_mm(prev, next, NULL)
+#include <asm-generic/mmu_context.h>
=20
 #endif
diff --git a/arch/nios2/include/asm/mmu_context.h b/arch/nios2/include/as=
m/mmu_context.h
index 78ab3dacf579..4f99ed09b5a7 100644
--- a/arch/nios2/include/asm/mmu_context.h
+++ b/arch/nios2/include/asm/mmu_context.h
@@ -26,16 +26,13 @@ extern unsigned long get_pid_from_context(mm_context_=
t *ctx);
  */
 extern pgd_t *pgd_current;
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
-
 /*
  * Initialize the context related info for a new mm_struct instance.
  *
  * Set all new contexts to 0, that way the generation will never match
  * the currently running generation when this context is switched in.
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 					struct mm_struct *mm)
 {
@@ -43,26 +40,16 @@ static inline int init_new_context(struct task_struct=
 *tsk,
 	return 0;
 }
=20
-/*
- * Destroy context related info for an mm_struct that is about
- * to be put to rest.
- */
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		struct task_struct *tsk);
=20
-static inline void deactivate_mm(struct task_struct *tsk,
-				struct mm_struct *mm)
-{
-}
-
 /*
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 void activate_mm(struct mm_struct *prev, struct mm_struct *next);
=20
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_NIOS2_MMU_CONTEXT_H */
diff --git a/arch/nios2/mm/mmu_context.c b/arch/nios2/mm/mmu_context.c
index 45d6b9c58d67..d77aa542deb2 100644
--- a/arch/nios2/mm/mmu_context.c
+++ b/arch/nios2/mm/mmu_context.c
@@ -103,6 +103,7 @@ void switch_mm(struct mm_struct *prev, struct mm_stru=
ct *next,
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	next->context =3D get_new_context();
diff --git a/arch/openrisc/include/asm/mmu_context.h b/arch/openrisc/incl=
ude/asm/mmu_context.h
index ced577542e29..a6702384c77d 100644
--- a/arch/openrisc/include/asm/mmu_context.h
+++ b/arch/openrisc/include/asm/mmu_context.h
@@ -17,13 +17,13 @@
=20
 #include <asm-generic/mm_hooks.h>
=20
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *m=
m);
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		      struct task_struct *tsk);
=20
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
 #define activate_mm(prev, next) switch_mm((prev), (next), NULL)
=20
 /* current active pgd - this is similar to other processors pgd
@@ -32,8 +32,6 @@ extern void switch_mm(struct mm_struct *prev, struct mm=
_struct *next,
=20
 extern volatile pgd_t *current_pgd[]; /* defined in arch/openrisc/mm/fau=
lt.c */
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
+#include <asm-generic/mmu_context.h>
=20
 #endif
diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index 4b680aed8f5f..821aab4cf3be 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -159,6 +159,7 @@ void switch_mm(struct mm_struct *prev, struct mm_stru=
ct *next,
  * instance.
  */
=20
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	mm->context =3D NO_CONTEXT;
@@ -170,6 +171,7 @@ int init_new_context(struct task_struct *tsk, struct =
mm_struct *mm)
  * drops it.
  */
=20
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm)
 {
 	flush_tlb_mm(mm);
diff --git a/arch/parisc/include/asm/mmu_context.h b/arch/parisc/include/=
asm/mmu_context.h
index 07b89c74abeb..71f8a3679b83 100644
--- a/arch/parisc/include/asm/mmu_context.h
+++ b/arch/parisc/include/asm/mmu_context.h
@@ -8,16 +8,13 @@
 #include <asm/pgalloc.h>
 #include <asm-generic/mm_hooks.h>
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
-
 /* on PA-RISC, we actually have enough contexts to justify an allocator
  * for them.  prumpf */
=20
 extern unsigned long alloc_sid(void);
 extern void free_sid(unsigned long);
=20
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -27,6 +24,7 @@ init_new_context(struct task_struct *tsk, struct mm_str=
uct *mm)
 	return 0;
 }
=20
+#define destroy_context destroy_context
 static inline void
 destroy_context(struct mm_struct *mm)
 {
@@ -72,8 +70,7 @@ static inline void switch_mm(struct mm_struct *prev,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct =
*next)
 {
 	/*
@@ -91,4 +88,7 @@ static inline void activate_mm(struct mm_struct *prev, =
struct mm_struct *next)
=20
 	switch_mm(prev,next,current);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/includ=
e/asm/mmu_context.h
index 1a474f6b1992..242bd987247b 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -14,7 +14,9 @@
 /*
  * Most if the context management is out of line
  */
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *m=
m);
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 struct mm_iommu_table_group_mem_t;
@@ -237,27 +239,15 @@ static inline void switch_mm(struct mm_struct *prev=
, struct mm_struct *next,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
=20
-
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-static inline void activate_mm(struct mm_struct *prev, struct mm_struct =
*next)
-{
-	switch_mm(prev, next, current);
-}
-
-/* We don't currently use enter_lazy_tlb() for anything */
+#ifdef CONFIG_PPC_BOOK3E_64
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void enter_lazy_tlb(struct mm_struct *mm,
 				  struct task_struct *tsk)
 {
 	/* 64-bit Book3E keeps track of current PGD in the PACA */
-#ifdef CONFIG_PPC_BOOK3E_64
 	get_paca()->pgd =3D NULL;
-#endif
 }
+#endif
=20
 extern void arch_exit_mmap(struct mm_struct *mm);
=20
@@ -300,5 +290,7 @@ static inline int arch_dup_mmap(struct mm_struct *old=
mm,
 	return 0;
 }
=20
+#include <asm-generic/mmu_context.h>
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/as=
m/mmu_context.h
index 67c463812e2d..250defa06f3a 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -13,34 +13,16 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-	struct task_struct *task)
-{
-}
-
-/* Initialize context-related info for a new mm_struct */
-static inline int init_new_context(struct task_struct *task,
-	struct mm_struct *mm)
-{
-	return 0;
-}
-
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task);
=20
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
 			       struct mm_struct *next)
 {
 	switch_mm(prev, next, NULL);
 }
=20
-static inline void deactivate_mm(struct task_struct *task,
-	struct mm_struct *mm)
-{
-}
+#include <asm-generic/mmu_context.h>
=20
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/=
mmu_context.h
index c9f3d8a52756..66f9cf0a07e3 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -15,6 +15,7 @@
 #include <asm/ctl_reg.h>
 #include <asm-generic/mm_hooks.h>
=20
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -69,8 +70,6 @@ static inline int init_new_context(struct task_struct *=
tsk,
 	return 0;
 }
=20
-#define destroy_context(mm)             do { } while (0)
-
 static inline void set_user_asce(struct mm_struct *mm)
 {
 	S390_lowcore.user_asce =3D mm->context.asce;
@@ -125,9 +124,7 @@ static inline void finish_arch_post_lock_switch(void)
 	set_fs(current->thread.mm_segment);
 }
=20
-#define enter_lazy_tlb(mm,tsk)	do { } while (0)
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
                                struct mm_struct *next)
 {
@@ -136,4 +133,6 @@ static inline void activate_mm(struct mm_struct *prev=
,
 	set_user_asce(next);
 }
=20
+#include <asm-generic/mmu_context.h>
+
 #endif /* __S390_MMU_CONTEXT_H */
diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_=
context.h
index 9470d17c71c2..ce40147d4a7d 100644
--- a/arch/sh/include/asm/mmu_context.h
+++ b/arch/sh/include/asm/mmu_context.h
@@ -85,6 +85,7 @@ static inline void get_mmu_context(struct mm_struct *mm=
, unsigned int cpu)
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -121,9 +122,7 @@ static inline void switch_mm(struct mm_struct *prev,
 			activate_context(next, cpu);
 }
=20
-#define activate_mm(prev, next)		switch_mm((prev),(next),NULL)
-#define deactivate_mm(tsk,mm)		do { } while (0)
-#define enter_lazy_tlb(mm,tsk)		do { } while (0)
+#include <asm-generic/mmu_context.h>
=20
 #else
=20
diff --git a/arch/sh/include/asm/mmu_context_32.h b/arch/sh/include/asm/m=
mu_context_32.h
index 71bf12ef1f65..bc5034fa6249 100644
--- a/arch/sh/include/asm/mmu_context_32.h
+++ b/arch/sh/include/asm/mmu_context_32.h
@@ -2,15 +2,6 @@
 #ifndef __ASM_SH_MMU_CONTEXT_32_H
 #define __ASM_SH_MMU_CONTEXT_32_H
=20
-/*
- * Destroy context related info for an mm_struct that is about
- * to be put to rest.
- */
-static inline void destroy_context(struct mm_struct *mm)
-{
-	/* Do nothing */
-}
-
 #ifdef CONFIG_CPU_HAS_PTEAEX
 static inline void set_asid(unsigned long asid)
 {
diff --git a/arch/sparc/include/asm/mmu_context_32.h b/arch/sparc/include=
/asm/mmu_context_32.h
index 7ddcb8badf70..509043f81560 100644
--- a/arch/sparc/include/asm/mmu_context_32.h
+++ b/arch/sparc/include/asm/mmu_context_32.h
@@ -6,13 +6,10 @@
=20
 #include <asm-generic/mm_hooks.h>
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
-
 /* Initialize a new mmu context.  This is invoked when a new
  * address space instance (unique or shared) is instantiated.
  */
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
=20
 /* Destroy a dead context.  This occurs when mmput drops the
@@ -20,17 +17,18 @@ int init_new_context(struct task_struct *tsk, struct =
mm_struct *mm);
  * all the page tables have been flushed.  Our job is to destroy
  * any remaining processor-specific state.
  */
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm);
=20
 /* Switch the current MM context. */
 void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 	       struct task_struct *tsk);
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 /* Activate a new MM instance for the current task. */
 #define activate_mm(active_mm, mm) switch_mm((active_mm), (mm), NULL)
=20
+#include <asm-generic/mmu_context.h>
+
 #endif /* !(__ASSEMBLY__) */
=20
 #endif /* !(__SPARC_MMU_CONTEXT_H) */
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include=
/asm/mmu_context_64.h
index 312fcee8df2b..7a8380c63aab 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -16,17 +16,16 @@
 #include <asm-generic/mm_hooks.h>
 #include <asm/percpu.h>
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
-
 extern spinlock_t ctx_alloc_lock;
 extern unsigned long tlb_context_cache;
 extern unsigned long mmu_context_bmap[];
=20
 DECLARE_PER_CPU(struct mm_struct *, per_cpu_secondary_mm);
 void get_new_mmu_context(struct mm_struct *mm);
+
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm);
=20
 void __tsb_context_switch(unsigned long pgd_pa,
@@ -136,7 +135,6 @@ static inline void switch_mm(struct mm_struct *old_mm=
, struct mm_struct *mm, str
 	spin_unlock_irqrestore(&mm->context.lock, flags);
 }
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
 #define activate_mm(active_mm, mm) switch_mm(active_mm, mm, NULL)
=20
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
@@ -187,6 +185,8 @@ static inline void finish_arch_post_lock_switch(void)
 	}
 }
=20
+#include <asm-generic/mmu_context.h>
+
 #endif /* !(__ASSEMBLY__) */
=20
 #endif /* !(__SPARC64_MMU_CONTEXT_H) */
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_=
context.h
index 17ddd4edf875..f8a100770691 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -37,10 +37,9 @@ static inline bool arch_vma_access_permitted(struct vm=
_area_struct *vma,
  * end asm-generic/mm_hooks.h functions
  */
=20
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 extern void force_flush_all(void);
=20
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *=
new)
 {
 	/*
@@ -66,13 +65,12 @@ static inline void switch_mm(struct mm_struct *prev, =
struct mm_struct *next,
 	}
 }
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm,=20
-				  struct task_struct *tsk)
-{
-}
-
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *task, struct mm_struct *=
mm);
=20
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
=20
+#include <asm-generic/mmu_context.h>
+
 #endif
diff --git a/arch/unicore32/include/asm/mmu_context.h b/arch/unicore32/in=
clude/asm/mmu_context.h
index 388c0c811c68..e1751cb5439c 100644
--- a/arch/unicore32/include/asm/mmu_context.h
+++ b/arch/unicore32/include/asm/mmu_context.h
@@ -18,24 +18,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu-single.h>
=20
-#define init_new_context(tsk, mm)	0
-
-#define destroy_context(mm)		do { } while (0)
-
-/*
- * This is called when "tsk" is about to enter lazy TLB mode.
- *
- * mm:  describes the currently active mm context
- * tsk: task which is entering lazy tlb
- * cpu: cpu number which is entering lazy tlb
- *
- * tsk->mm will be NULL
- */
-static inline void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * This is the actual mm switch as far as the scheduler
  * is concerned.  No registers are touched.  We avoid
@@ -52,9 +34,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *nex=
t,
 		cpu_switch_mm(next->pgd, next);
 }
=20
-#define deactivate_mm(tsk, mm)	do { } while (0)
-#define activate_mm(prev, next)	switch_mm(prev, next, NULL)
-
 /*
  * We are inserting a "fake" vma for the user-accessible vector page so
  * gdb and friends can get to it through ptrace and /proc/<pid>/mem.
@@ -95,4 +74,7 @@ static inline bool arch_vma_access_permitted(struct vm_=
area_struct *vma,
 	/* by default, allow everything */
 	return true;
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mm=
u_context.h
index 47562147e70b..255750548433 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -92,12 +92,14 @@ static inline void switch_ldt(struct mm_struct *prev,=
 struct mm_struct *next)
 }
 #endif
=20
+#define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk=
);
=20
 /*
  * Init a new mm.  Used on mm copies, like at fork()
  * and on mm's that are brand-new, like at execve().
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -117,6 +119,8 @@ static inline int init_new_context(struct task_struct=
 *tsk,
 	init_new_context_ldt(mm);
 	return 0;
 }
+
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
@@ -215,4 +219,6 @@ static inline bool arch_vma_access_permitted(struct v=
m_area_struct *vma,
=20
 unsigned long __get_current_cr3_fast(void);
=20
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
diff --git a/arch/xtensa/include/asm/mmu_context.h b/arch/xtensa/include/=
asm/mmu_context.h
index 74923ef3b228..e337ba9686e9 100644
--- a/arch/xtensa/include/asm/mmu_context.h
+++ b/arch/xtensa/include/asm/mmu_context.h
@@ -111,6 +111,7 @@ static inline void activate_context(struct mm_struct =
*mm, unsigned int cpu)
  * to -1 says the process has never run on any core.
  */
=20
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 		struct mm_struct *mm)
 {
@@ -136,24 +137,18 @@ static inline void switch_mm(struct mm_struct *prev=
, struct mm_struct *next,
 		activate_context(next, cpu);
 }
=20
-#define activate_mm(prev, next)	switch_mm((prev), (next), NULL)
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
 /*
  * Destroy context related info for an mm_struct that is about
  * to be put to rest.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	invalidate_page_directory();
 }
=20
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-	/* Nothing to do. */
-
-}
+#include <asm-generic/mmu_context.h>
=20
 #endif /* CONFIG_MMU */
 #endif /* _XTENSA_MMU_CONTEXT_H */
diff --git a/arch/xtensa/include/asm/nommu_context.h b/arch/xtensa/includ=
e/asm/nommu_context.h
index 37251b2ef871..7c9d1918dc41 100644
--- a/arch/xtensa/include/asm/nommu_context.h
+++ b/arch/xtensa/include/asm/nommu_context.h
@@ -7,28 +7,4 @@ static inline void init_kio(void)
 {
 }
=20
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
-{
-}
-
-static inline int init_new_context(struct task_struct *tsk,struct mm_str=
uct *mm)
-{
-	return 0;
-}
-
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
-static inline void activate_mm(struct mm_struct *prev, struct mm_struct =
*next)
-{
-}
-
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *n=
ext,
-				struct task_struct *tsk)
-{
-}
-
-static inline void deactivate_mm(struct task_struct *tsk, struct mm_stru=
ct *mm)
-{
-}
+#include <asm-generic/nommu_context.h>
--=20
2.23.0

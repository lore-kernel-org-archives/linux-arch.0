Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42F212F4.5020609@yahoo.com.au>
Date: Thu, 04 Aug 2005 23:07:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: [patch] make spin_lock_prefetch a noop for UP
Content-Type: multipart/mixed;
 boundary="------------060204060908020505030308"
To: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060204060908020505030308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Is this any good?

The counter argument would be that one might prefetch a
spinlock in the head of a data structure, and expect
the rest of the cacheline to be in cache as well. Though
in that case, maybe prefetch/prefetchw should be used
instead.

-- 
SUSE Labs, Novell Inc.


--------------060204060908020505030308
Content-Type: image/x-xbitmap;
 name="prefetch-noop-spinlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prefetch-noop-spinlock.patch"

#define spin_lock_prefetch to be a noop on UP builds.

Also, make architectures that define spin_lock_prefetch to be prefetchw
just use the generic spin_lock_prefetch.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/asm-i386/processor.h
===================================================================
--- linux-2.6.orig/include/asm-i386/processor.h	2005-08-04 23:00:23.000000000 +1000
+++ linux-2.6/include/asm-i386/processor.h	2005-08-04 23:00:34.000000000 +1000
@@ -673,7 +673,6 @@ extern inline void prefetch(const void *
 
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
 
 /* 3dnow! prefetch to get an exclusive cache line. Useful for 
    spinlocks to avoid one state transition in the cache coherency protocol. */
@@ -684,7 +683,6 @@ extern inline void prefetchw(const void 
 			  X86_FEATURE_3DNOW,
 			  "r" (x));
 }
-#define spin_lock_prefetch(x)	prefetchw(x)
 
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 
Index: linux-2.6/include/asm-ia64/processor.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/processor.h	2005-08-04 23:00:23.000000000 +1000
+++ linux-2.6/include/asm-ia64/processor.h	2005-08-04 23:00:34.000000000 +1000
@@ -676,7 +676,6 @@ ia64_imva (void *addr)
 
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
 #define PREFETCH_STRIDE			L1_CACHE_BYTES
 
 static inline void
@@ -691,8 +690,6 @@ prefetchw (const void *x)
 	ia64_lfetch_excl(ia64_lfhint_none, x);
 }
 
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 extern unsigned long boot_option_idle_override;
 
 #endif /* !__ASSEMBLY__ */
Index: linux-2.6/include/asm-ppc/processor.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/processor.h	2005-08-04 23:00:23.000000000 +1000
+++ linux-2.6/include/asm-ppc/processor.h	2005-08-04 23:00:34.000000000 +1000
@@ -179,7 +179,6 @@ void _nmask_and_or_msr(unsigned long nma
  */
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
 
 extern inline void prefetch(const void *x)
 {
@@ -191,8 +190,6 @@ extern inline void prefetchw(const void 
 	 __asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
 }
 
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 extern int emulate_altivec(struct pt_regs *regs);
 
 #endif /* !__ASSEMBLY__ */
Index: linux-2.6/include/asm-ppc64/processor.h
===================================================================
--- linux-2.6.orig/include/asm-ppc64/processor.h	2005-08-04 23:00:23.000000000 +1000
+++ linux-2.6/include/asm-ppc64/processor.h	2005-08-04 23:00:34.000000000 +1000
@@ -476,7 +476,6 @@ static inline unsigned long __pack_fe01(
  */
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
 
 static inline void prefetch(const void *x)
 {
@@ -494,8 +493,6 @@ static inline void prefetchw(const void 
 	__asm__ __volatile__ ("dcbtst 0,%0" : : "r" (x));
 }
 
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
 static inline void ppc64_runlatch_on(void)
Index: linux-2.6/include/asm-sparc64/processor.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/processor.h	2005-08-04 23:00:23.000000000 +1000
+++ linux-2.6/include/asm-sparc64/processor.h	2005-08-04 23:00:34.000000000 +1000
@@ -198,7 +198,6 @@ extern unsigned long get_wchan(struct ta
  */
 #define ARCH_HAS_PREFETCH
 #define ARCH_HAS_PREFETCHW
-#define ARCH_HAS_SPINLOCK_PREFETCH
 
 static inline void prefetch(const void *x)
 {
@@ -224,8 +223,6 @@ static inline void prefetchw(const void 
 			     : "r" (x));
 }
 
-#define spin_lock_prefetch(x)	prefetchw(x)
-
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__ASM_SPARC64_PROCESSOR_H) */
Index: linux-2.6/include/asm-x86_64/processor.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/processor.h	2005-08-04 23:00:23.000000000 +1000
+++ linux-2.6/include/asm-x86_64/processor.h	2005-08-04 23:00:34.000000000 +1000
@@ -404,10 +404,6 @@ static inline void prefetchw(void *x) 
 			  "r" (x));
 } 
 
-#define ARCH_HAS_SPINLOCK_PREFETCH 1
-
-#define spin_lock_prefetch(x)  prefetchw(x)
-
 #define cpu_relax()   rep_nop()
 
 /*
Index: linux-2.6/include/linux/prefetch.h
===================================================================
--- linux-2.6.orig/include/linux/prefetch.h	2005-08-04 23:00:23.000000000 +1000
+++ linux-2.6/include/linux/prefetch.h	2005-08-04 23:00:34.000000000 +1000
@@ -48,7 +48,11 @@ static inline void prefetchw(const void 
 #endif
 
 #ifndef ARCH_HAS_SPINLOCK_PREFETCH
+#ifdef CONFIG_SMP
 #define spin_lock_prefetch(x) prefetchw(x)
+#else
+#define spin_lock_prefetch(x)
+#endif
 #endif
 
 #ifndef PREFETCH_STRIDE

--------------060204060908020505030308--
Send instant messages to your online friends http://au.messenger.yahoo.com 

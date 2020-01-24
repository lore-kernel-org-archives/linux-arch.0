Return-Path: <SRS0=HZcf=3N=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgAXKlw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 05:41:52 -0500
Date: Fri, 24 Jan 2020 11:41:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Message-ID: <20200124104137.GH14946@hirez.programming.kicks-ass.net>
References: <20200123153341.19947-1-will@kernel.org>
 <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
 <20200124083307.GA14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124083307.GA14914@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <20200124104137.HxQiWpX9gQ2zLVV-jHLj6l0E1mjGBKjscTMNqorbfDU@z>

On Fri, Jan 24, 2020 at 09:33:07AM +0100, Peter Zijlstra wrote:
> On Thu, Jan 23, 2020 at 09:59:03AM -0800, Linus Torvalds wrote:
> > On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > This is version two of the patches I previously posted as an RFC here:
> > 
> > Looks fine to me, as far as I can tell,
> 
> Awesome, I've picked them up with a target for tip/locking/core.

FWIW, I have the following merge resolution against locking/kcsan.

---

diff --cc include/linux/compiler.h
index 8c0beb10c1dd,994c35638584..000000000000
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@@ -177,28 -177,69 +177,74 @@@ void ftrace_likely_update(struct ftrace
  # define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
  #endif
  
- #include <uapi/linux/types.h>
- #include <linux/kcsan-checks.h>
+ /*
+  * Prevent the compiler from merging or refetching reads or writes. The
+  * compiler is also forbidden from reordering successive instances of
+  * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
+  * particular ordering. One way to make the compiler aware of ordering is to
+  * put the two invocations of READ_ONCE or WRITE_ONCE in different C
+  * statements.
+  *
+  * These two macros will also work on aggregate data types like structs or
+  * unions.
+  *
+  * Their two major use cases are: (1) Mediating communication between
+  * process-level code and irq/NMI handlers, all running on the same CPU,
+  * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
+  * mutilate accesses that either do not require ordering or that interact
+  * with an explicit memory barrier or atomic instruction that provides the
+  * required ordering.
+  */
+ #include <asm/barrier.h>
+ #include <linux/kasan-checks.h>
+ 
+ /*
+  * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
+  * atomicity or dependency ordering guarantees. Note that this may result
+  * in tears!
+  */
+ #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
+ 
+ #define __READ_ONCE_SCALAR(x)						\
+ ({									\
+ 	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
+ 	smp_read_barrier_depends();					\
+ 	(typeof(x))__x;							\
+ })
  
- #define __READ_ONCE_SIZE						\
+ /*
+  * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
+  * to hide memory access from KASAN.
+  */
+ #define READ_ONCE_NOCHECK(x)						\
  ({									\
- 	switch (size) {							\
- 	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
- 	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
- 	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
- 	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
- 	default:							\
- 		barrier();						\
- 		__builtin_memcpy((void *)res, (const void *)p, size);	\
- 		barrier();						\
- 	}								\
+ 	compiletime_assert_rwonce_type(x);				\
+ 	__READ_ONCE_SCALAR(x);						\
+ })
+ 
 -#define READ_ONCE(x)	READ_ONCE_NOCHECK(x)
++#define READ_ONCE(x)					\
++({							\
++	kcsan_check_atomic_read(&(x), sizeof(x));	\
++	READ_ONCE_NOCHECK(x);				\
 +})
  
+ #define __WRITE_ONCE(x, val)				\
+ do {							\
+ 	*(volatile typeof(x) *)&(x) = (val);		\
+ } while (0)
+ 
+ #define WRITE_ONCE(x, val)				\
+ do {							\
+ 	compiletime_assert_rwonce_type(x);		\
++	kcsan_check_atomic_write(&(x), sizeof(x));	\
+ 	__WRITE_ONCE(x, val);				\
+ } while (0)
+ 
  #ifdef CONFIG_KASAN
  /*
 - * We can't declare function 'inline' because __no_sanitize_address conflicts
 + * We can't declare function 'inline' because __no_sanitize_address confilcts
   * with inlining. Attempt to inline it may cause a build failure.
-  * 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
 - *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
++ *	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
   * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
   */
  # define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
@@@ -207,97 -247,6 +253,24 @@@
  # define __no_kasan_or_inline __always_inline
  #endif
  
 +#define __no_kcsan __no_sanitize_thread
 +#ifdef __SANITIZE_THREAD__
 +/*
 + * Rely on __SANITIZE_THREAD__ instead of CONFIG_KCSAN, to avoid not inlining in
 + * compilation units where instrumentation is disabled. The attribute 'noinline'
 + * is required for older compilers, where implicit inlining of very small
 + * functions renders __no_sanitize_thread ineffective.
 + */
 +# define __no_kcsan_or_inline __no_kcsan noinline notrace __maybe_unused
 +# define __no_sanitize_or_inline __no_kcsan_or_inline
 +#else
 +# define __no_kcsan_or_inline __always_inline
 +#endif
 +
 +#ifndef __no_sanitize_or_inline
 +#define __no_sanitize_or_inline __always_inline
 +#endif
 +
- static __no_kcsan_or_inline
- void __read_once_size(const volatile void *p, void *res, int size)
- {
- 	kcsan_check_atomic_read(p, size);
- 	__READ_ONCE_SIZE;
- }
- 
- static __no_sanitize_or_inline
- void __read_once_size_nocheck(const volatile void *p, void *res, int size)
- {
- 	__READ_ONCE_SIZE;
- }
- 
- static __no_kcsan_or_inline
- void __write_once_size(volatile void *p, void *res, int size)
- {
- 	kcsan_check_atomic_write(p, size);
- 
- 	switch (size) {
- 	case 1: *(volatile __u8 *)p = *(__u8 *)res; break;
- 	case 2: *(volatile __u16 *)p = *(__u16 *)res; break;
- 	case 4: *(volatile __u32 *)p = *(__u32 *)res; break;
- 	case 8: *(volatile __u64 *)p = *(__u64 *)res; break;
- 	default:
- 		barrier();
- 		__builtin_memcpy((void *)p, (const void *)res, size);
- 		barrier();
- 	}
- }
- 
- /*
-  * Prevent the compiler from merging or refetching reads or writes. The
-  * compiler is also forbidden from reordering successive instances of
-  * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
-  * particular ordering. One way to make the compiler aware of ordering is to
-  * put the two invocations of READ_ONCE or WRITE_ONCE in different C
-  * statements.
-  *
-  * These two macros will also work on aggregate data types like structs or
-  * unions. If the size of the accessed data type exceeds the word size of
-  * the machine (e.g., 32 bits or 64 bits) READ_ONCE() and WRITE_ONCE() will
-  * fall back to memcpy(). There's at least two memcpy()s: one for the
-  * __builtin_memcpy() and then one for the macro doing the copy of variable
-  * - '__u' allocated on the stack.
-  *
-  * Their two major use cases are: (1) Mediating communication between
-  * process-level code and irq/NMI handlers, all running on the same CPU,
-  * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
-  * mutilate accesses that either do not require ordering or that interact
-  * with an explicit memory barrier or atomic instruction that provides the
-  * required ordering.
-  */
- #include <asm/barrier.h>
- #include <linux/kasan-checks.h>
- 
- #define __READ_ONCE(x, check)						\
- ({									\
- 	union { typeof(x) __val; char __c[1]; } __u;			\
- 	if (check)							\
- 		__read_once_size(&(x), __u.__c, sizeof(x));		\
- 	else								\
- 		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
- 	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
- 	__u.__val;							\
- })
- #define READ_ONCE(x) __READ_ONCE(x, 1)
- 
- /*
-  * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need
-  * to hide memory access from KASAN.
-  */
- #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
- 
  static __no_kasan_or_inline
  unsigned long read_word_at_a_time(const void *addr)
  {
@@@ -305,34 -254,6 +278,26 @@@
  	return *(unsigned long *)addr;
  }
  
- #define WRITE_ONCE(x, val) \
- ({							\
- 	union { typeof(x) __val; char __c[1]; } __u =	\
- 		{ .__val = (__force typeof(x)) (val) }; \
- 	__write_once_size(&(x), __u.__c, sizeof(x));	\
- 	__u.__val;					\
- })
- 
 +#include <linux/kcsan.h>
 +
 +/*
 + * data_race(): macro to document that accesses in an expression may conflict with
 + * other concurrent accesses resulting in data races, but the resulting
 + * behaviour is deemed safe regardless.
 + *
 + * This macro *does not* affect normal code generation, but is a hint to tooling
 + * that data races here should be ignored.
 + */
 +#define data_race(expr)                                                        \
 +	({                                                                     \
 +		typeof(({ expr; })) __val;                                     \
 +		kcsan_nestable_atomic_begin();                                 \
 +		__val = ({ expr; });                                           \
 +		kcsan_nestable_atomic_end();                                   \
 +		__val;                                                         \
 +	})
 +#else
 +
  #endif /* __KERNEL__ */
  
  /*

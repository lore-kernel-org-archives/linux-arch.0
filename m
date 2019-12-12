Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbfLLKq0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 05:46:26 -0500
Date: Thu, 12 Dec 2019 11:46:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191212104610.GW2827@hirez.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212100756.GA11317@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr, linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20191212104610.NsY5Pa60DbQvhEqvmv4f1aTn4mTuHjwY5oNHqBwHHmw@z>

On Thu, Dec 12, 2019 at 10:07:56AM +0000, Will Deacon wrote:

> > So your proposed change _should_ be fine. Will, I'm assuming you never
> > saw this on your ARGH64 builds when you did this code ?
> 
> I did see it, but (a) looking at the code out-of-line makes it look a lot
> worse than it actually is (so the ext4 example is really helpful -- thanks
> Michael!) and (b) I chalked it up to a crappy compiler.
> 
> However, see this comment from Arnd on my READ_ONCE series from the other
> day:
> 
> https://lore.kernel.org/lkml/CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com
> 
> In which case, I'm thinking that we should be doing better in READ_ONCE()
> for non-buggy compilers which would also keep the KCSAN folks happy for this
> code (and would help with [1] too).

So something like this then? Although I suppose that should be moved
into compiler-gcc.h and then guarded by #ifndef READ_ONCE or so.

---

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ad8c76144a3c..8326e2cf28b4 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -179,20 +179,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 #include <uapi/linux/types.h>
 #include <linux/kcsan-checks.h>
-
-#define __READ_ONCE_SIZE						\
-({									\
-	switch (size) {							\
-	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
-	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
-	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
-	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
-	default:							\
-		barrier();						\
-		__builtin_memcpy((void *)res, (const void *)p, size);	\
-		barrier();						\
-	}								\
-})
+#include <asm/barrier.h>
+#include <linux/kasan-checks.h>
 
 #ifdef CONFIG_KASAN
 /*
@@ -222,6 +210,22 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __no_sanitize_or_inline __always_inline
 #endif
 
+#ifdef GCC_VERSION < 40800
+
+#define __READ_ONCE_SIZE						\
+({									\
+	switch (size) {							\
+	case 1: *(__u8 *)res = *(volatile __u8 *)p; break;		\
+	case 2: *(__u16 *)res = *(volatile __u16 *)p; break;		\
+	case 4: *(__u32 *)res = *(volatile __u32 *)p; break;		\
+	case 8: *(__u64 *)res = *(volatile __u64 *)p; break;		\
+	default:							\
+		barrier();						\
+		__builtin_memcpy((void *)res, (const void *)p, size);	\
+		barrier();						\
+	}								\
+})
+
 static __no_kcsan_or_inline
 void __read_once_size(const volatile void *p, void *res, int size)
 {
@@ -274,9 +278,6 @@ void __write_once_size(volatile void *p, void *res, int size)
  * with an explicit memory barrier or atomic instruction that provides the
  * required ordering.
  */
-#include <asm/barrier.h>
-#include <linux/kasan-checks.h>
-
 #define __READ_ONCE(x, check)						\
 ({									\
 	union { typeof(x) __val; char __c[1]; } __u;			\
@@ -295,6 +296,23 @@ void __write_once_size(volatile void *p, void *res, int size)
  */
 #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
 
+#else /* GCC_VERSION < 40800 */
+
+#define READ_ONCE_NOCHECK(x)						\
+({									\
+	typeof(x) __x = *(volatile typeof(x))&(x);			\
+	smp_read_barrier_depends();					\
+	__x;
+})
+
+#define READ_ONCE(x)							\
+({									\
+	kcsan_check_atomic_read(&(x), sizeof(x));			\
+	READ_ONCE_NOCHECK(x);						\
+})
+
+#endif /* GCC_VERSION < 40800 */
+
 static __no_kasan_or_inline
 unsigned long read_word_at_a_time(const void *addr)
 {

From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 12/15] x86: Use ISO xchg(), cmpxchg() and friends
Date: Wed, 18 May 2016 16:12:07 +0100
Message-ID: <146358432774.8596.8004304272934835091.stgit@warthog.procyon.org.uk>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

Make x86 use the ISO intrinsic xchg(), cmpxchg() and similar functions.

This boots fine, however it can't NOP out the LOCK prefixes if the number
of online CPUs is 1.

Without this patch, according to size -A, .text for my test kernel is:

	.text                     6273589   18446744071578845184

with this patch:

	.text                     6273013   18446744071578845184

There are still some underoptimisations to be dealt with.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/include/asm/cmpxchg.h    |   99 -------------------------------------
 arch/x86/include/asm/cmpxchg_32.h |    3 -
 arch/x86/include/asm/cmpxchg_64.h |    6 --
 3 files changed, 1 insertion(+), 107 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index 9733361fed6f..cde270af1b94 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -2,6 +2,7 @@
 #define ASM_X86_CMPXCHG_H
 
 #include <linux/compiler.h>
+#include <asm-generic/iso-cmpxchg.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h> /* Provides LOCK_PREFIX */
 
@@ -9,12 +10,8 @@
  * Non-existant functions to indicate usage errors at link time
  * (or compile-time if the compiler implements __compiletime_error().
  */
-extern void __xchg_wrong_size(void)
-	__compiletime_error("Bad argument size for xchg");
 extern void __cmpxchg_wrong_size(void)
 	__compiletime_error("Bad argument size for cmpxchg");
-extern void __xadd_wrong_size(void)
-	__compiletime_error("Bad argument size for xadd");
 extern void __add_wrong_size(void)
 	__compiletime_error("Bad argument size for add");
 
@@ -34,48 +31,6 @@ extern void __add_wrong_size(void)
 #define	__X86_CASE_Q	-1		/* sizeof will never return -1 */
 #endif
 
-/* 
- * An exchange-type operation, which takes a value and a pointer, and
- * returns the old value.
- */
-#define __xchg_op(ptr, arg, op, lock)					\
-	({								\
-	        __typeof__ (*(ptr)) __ret = (arg);			\
-		switch (sizeof(*(ptr))) {				\
-		case __X86_CASE_B:					\
-			asm volatile (lock #op "b %b0, %1\n"		\
-				      : "+q" (__ret), "+m" (*(ptr))	\
-				      : : "memory", "cc");		\
-			break;						\
-		case __X86_CASE_W:					\
-			asm volatile (lock #op "w %w0, %1\n"		\
-				      : "+r" (__ret), "+m" (*(ptr))	\
-				      : : "memory", "cc");		\
-			break;						\
-		case __X86_CASE_L:					\
-			asm volatile (lock #op "l %0, %1\n"		\
-				      : "+r" (__ret), "+m" (*(ptr))	\
-				      : : "memory", "cc");		\
-			break;						\
-		case __X86_CASE_Q:					\
-			asm volatile (lock #op "q %q0, %1\n"		\
-				      : "+r" (__ret), "+m" (*(ptr))	\
-				      : : "memory", "cc");		\
-			break;						\
-		default:						\
-			__ ## op ## _wrong_size();			\
-		}							\
-		__ret;							\
-	})
-
-/*
- * Note: no "lock" prefix even on SMP: xchg always implies lock anyway.
- * Since this is generally used to protect other memory information, we
- * use "asm volatile" and "memory" clobbers to prevent gcc from moving
- * information around.
- */
-#define xchg(ptr, v)	__xchg_op((ptr), (v), xchg, "")
-
 /*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
  * store NEW in MEM.  Return the initial value in MEM.  Success is
@@ -129,9 +84,6 @@ extern void __add_wrong_size(void)
 	__ret;								\
 })
 
-#define __cmpxchg(ptr, old, new, size)					\
-	__raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
-
 #define __sync_cmpxchg(ptr, old, new, size)				\
 	__raw_cmpxchg((ptr), (old), (new), (size), "lock; ")
 
@@ -144,9 +96,6 @@ extern void __add_wrong_size(void)
 # include <asm/cmpxchg_64.h>
 #endif
 
-#define cmpxchg(ptr, old, new)						\
-	__cmpxchg(ptr, old, new, sizeof(*(ptr)))
-
 #define sync_cmpxchg(ptr, old, new)					\
 	__sync_cmpxchg(ptr, old, new, sizeof(*(ptr)))
 
@@ -154,56 +103,10 @@ extern void __add_wrong_size(void)
 	__cmpxchg_local(ptr, old, new, sizeof(*(ptr)))
 
 /*
- * xadd() adds "inc" to "*ptr" and atomically returns the previous
- * value of "*ptr".
- *
- * xadd() is locked when multiple CPUs are online
- * xadd_sync() is always locked
- * xadd_local() is never locked
- */
-#define __xadd(ptr, inc, lock)	__xchg_op((ptr), (inc), xadd, lock)
-#define xadd(ptr, inc)		__xadd((ptr), (inc), LOCK_PREFIX)
-#define xadd_sync(ptr, inc)	__xadd((ptr), (inc), "lock; ")
-#define xadd_local(ptr, inc)	__xadd((ptr), (inc), "")
-
-#define __add(ptr, inc, lock)						\
-	({								\
-	        __typeof__ (*(ptr)) __ret = (inc);			\
-		switch (sizeof(*(ptr))) {				\
-		case __X86_CASE_B:					\
-			asm volatile (lock "addb %b1, %0\n"		\
-				      : "+m" (*(ptr)) : "qi" (inc)	\
-				      : "memory", "cc");		\
-			break;						\
-		case __X86_CASE_W:					\
-			asm volatile (lock "addw %w1, %0\n"		\
-				      : "+m" (*(ptr)) : "ri" (inc)	\
-				      : "memory", "cc");		\
-			break;						\
-		case __X86_CASE_L:					\
-			asm volatile (lock "addl %1, %0\n"		\
-				      : "+m" (*(ptr)) : "ri" (inc)	\
-				      : "memory", "cc");		\
-			break;						\
-		case __X86_CASE_Q:					\
-			asm volatile (lock "addq %1, %0\n"		\
-				      : "+m" (*(ptr)) : "ri" (inc)	\
-				      : "memory", "cc");		\
-			break;						\
-		default:						\
-			__add_wrong_size();				\
-		}							\
-		__ret;							\
-	})
-
-/*
  * add_*() adds "inc" to "*ptr"
  *
- * __add() takes a lock prefix
- * add_smp() is locked when multiple CPUs are online
  * add_sync() is always locked
  */
-#define add_smp(ptr, inc)	__add((ptr), (inc), LOCK_PREFIX)
 #define add_sync(ptr, inc)	__add((ptr), (inc), "lock; ")
 
 #define __cmpxchg_double(pfx, p1, p2, o1, o2, n1, n2)			\
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index e4959d023af8..959908c06569 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -35,9 +35,6 @@ static inline void set_64bit(volatile u64 *ptr, u64 value)
 }
 
 #ifdef CONFIG_X86_CMPXCHG64
-#define cmpxchg64(ptr, o, n)						\
-	((__typeof__(*(ptr)))__cmpxchg64((ptr), (unsigned long long)(o), \
-					 (unsigned long long)(n)))
 #define cmpxchg64_local(ptr, o, n)					\
 	((__typeof__(*(ptr)))__cmpxchg64_local((ptr), (unsigned long long)(o), \
 					       (unsigned long long)(n)))
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index caa23a34c963..3f86acb1f6d2 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -6,12 +6,6 @@ static inline void set_64bit(volatile u64 *ptr, u64 val)
 	*ptr = val;
 }
 
-#define cmpxchg64(ptr, o, n)						\
-({									\
-	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
-})
-
 #define cmpxchg64_local(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\

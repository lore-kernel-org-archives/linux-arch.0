From: Will Deacon <will@kernel.org>
Subject: [PATCH v3 10/12] arm64: barrier: Use '__unqual_scalar_typeof' for acquire/release macros
Date: Wed, 15 Apr 2020 17:52:16 +0100
Message-ID: <20200415165218.20251-11-will@kernel.org>
References: <20200415165218.20251-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410528AbgDOQxS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 12:53:18 -0400
In-Reply-To: <20200415165218.20251-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Mark Rutland <mark.rutland@arm.com>

Passing volatile-qualified pointers to the arm64 implementations of the
load-acquire/store-release macros results in a re-load from the stack
and a bunch of associated stack-protector churn due to the temporary
result variable inheriting the volatile semantics thanks to the use of
'typeof()'.

Define these temporary variables using 'unqual_scalar_typeof' to drop
the volatile qualifier in the case that they are scalar types.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/barrier.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 7d9cc5ec4971..fb4c27506ef4 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -76,8 +76,8 @@ static inline unsigned long array_index_mask_nospec(unsigned long idx,
 #define __smp_store_release(p, v)					\
 do {									\
 	typeof(p) __p = (p);						\
-	union { typeof(*p) __val; char __c[1]; } __u =			\
-		{ .__val = (__force typeof(*p)) (v) };			\
+	union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u =	\
+		{ .__val = (__force __unqual_scalar_typeof(*p)) (v) };	\
 	compiletime_assert_atomic_type(*p);				\
 	kasan_check_write(__p, sizeof(*p));				\
 	switch (sizeof(*p)) {						\
@@ -110,7 +110,7 @@ do {									\
 
 #define __smp_load_acquire(p)						\
 ({									\
-	union { typeof(*p) __val; char __c[1]; } __u;			\
+	union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u;	\
 	typeof(p) __p = (p);						\
 	compiletime_assert_atomic_type(*p);				\
 	kasan_check_read(__p, sizeof(*p));				\
@@ -136,33 +136,33 @@ do {									\
 			: "Q" (*__p) : "memory");			\
 		break;							\
 	}								\
-	__u.__val;							\
+	(typeof(*p))__u.__val;						\
 })
 
 #define smp_cond_load_relaxed(ptr, cond_expr)				\
 ({									\
 	typeof(ptr) __PTR = (ptr);					\
-	typeof(*ptr) VAL;						\
+	__unqual_scalar_typeof(*ptr) VAL;				\
 	for (;;) {							\
 		VAL = READ_ONCE(*__PTR);				\
 		if (cond_expr)						\
 			break;						\
 		__cmpwait_relaxed(__PTR, VAL);				\
 	}								\
-	VAL;								\
+	(typeof(*ptr))VAL;						\
 })
 
 #define smp_cond_load_acquire(ptr, cond_expr)				\
 ({									\
 	typeof(ptr) __PTR = (ptr);					\
-	typeof(*ptr) VAL;						\
+	__unqual_scalar_typeof(*ptr) VAL;				\
 	for (;;) {							\
 		VAL = smp_load_acquire(__PTR);				\
 		if (cond_expr)						\
 			break;						\
 		__cmpwait_relaxed(__PTR, VAL);				\
 	}								\
-	VAL;								\
+	(typeof(*ptr))VAL;						\
 })
 
 #include <asm-generic/barrier.h>
-- 
2.26.0.110.g2183baf09c-goog

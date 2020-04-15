From: Will Deacon <will@kernel.org>
Subject: [PATCH v3 09/12] locking/barriers: Use '__unqual_scalar_typeof' for load-acquire macros
Date: Wed, 15 Apr 2020 17:52:15 +0100
Message-ID: <20200415165218.20251-10-will@kernel.org>
References: <20200415165218.20251-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410521AbgDOQxO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 12:53:14 -0400
In-Reply-To: <20200415165218.20251-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

Passing volatile-qualified pointers to the asm-generic implementations of
the load-acquire macros results in a re-load from the stack due to the
temporary result variable inheriting the volatile semantics thanks to the
use of 'typeof()'.

Define these temporary variables using 'unqual_scalar_typeof' to drop
the volatile qualifier in the case that they are scalar types.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/barrier.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 85b28eb80b11..2eacaf7d62f6 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -128,10 +128,10 @@ do {									\
 #ifndef __smp_load_acquire
 #define __smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	__unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);		\
 	compiletime_assert_atomic_type(*p);				\
 	__smp_mb();							\
-	___p1;								\
+	(typeof(*p))___p1;						\
 })
 #endif
 
@@ -183,10 +183,10 @@ do {									\
 #ifndef smp_load_acquire
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
+	__unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);		\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
-	___p1;								\
+	(typeof(*p))___p1;						\
 })
 #endif
 
@@ -229,14 +229,14 @@ do {									\
 #ifndef smp_cond_load_relaxed
 #define smp_cond_load_relaxed(ptr, cond_expr) ({		\
 	typeof(ptr) __PTR = (ptr);				\
-	typeof(*ptr) VAL;					\
+	__unqual_scalar_typeof(*ptr) VAL;			\
 	for (;;) {						\
 		VAL = READ_ONCE(*__PTR);			\
 		if (cond_expr)					\
 			break;					\
 		cpu_relax();					\
 	}							\
-	VAL;							\
+	(typeof(*ptr))VAL;					\
 })
 #endif
 
@@ -250,10 +250,10 @@ do {									\
  */
 #ifndef smp_cond_load_acquire
 #define smp_cond_load_acquire(ptr, cond_expr) ({		\
-	typeof(*ptr) _val;					\
+	__unqual_scalar_typeof(*ptr) _val;			\
 	_val = smp_cond_load_relaxed(ptr, cond_expr);		\
 	smp_acquire__after_ctrl_dep();				\
-	_val;							\
+	(typeof(*ptr))_val;					\
 })
 #endif
 
-- 
2.26.0.110.g2183baf09c-goog

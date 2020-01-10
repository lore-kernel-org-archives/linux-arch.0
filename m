From: Will Deacon <will@kernel.org>
Subject: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading from scalar types
Date: Fri, 10 Jan 2020 16:56:34 +0000
Message-ID: <20200110165636.28035-7-will@kernel.org>
References: <20200110165636.28035-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbgAJQ46 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 11:56:58 -0500
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>

Passing a volatile-qualified pointer to READ_ONCE() is an absolute
trainwreck for code generation: the use of 'typeof()' to define a
temporary variable inside the macro means that the final evaluation in
macro scope ends up forcing a read back from the stack. When stack
protector is enabled (the default for arm64, at least), this causes
the compiler to vomit up all sorts of junk.

Unfortunately, dropping pointer qualifiers inside the macro poses quite
a challenge, especially since the pointed-to type is permitted to be an
aggregate, and this is relied upon by mm/ code accessing things like
'pmd_t'. Based on numerous hacks and discussions on the mailing list,
this is the best I've managed to come up with.

Introduce '__unqual_scalar_typeof()' which takes an expression and, if
the expression is an optionally qualified 8, 16, 32 or 64-bit scalar
type, evaluates to the unqualified type. Other input types, including
aggregates, remain unchanged. Hopefully READ_ONCE() on volatile aggregate
pointers isn't something we do on a fast-path.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler.h       |  6 +++---
 include/linux/compiler_types.h | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 863180641336..d3491fd44c19 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -203,13 +203,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * atomicity or dependency ordering guarantees. Note that this may result
  * in tears!
  */
-#define __READ_ONCE(x)	(*(volatile typeof(x) *)&(x))
+#define __READ_ONCE(x)	(*(volatile __unqual_scalar_typeof(x) *)&(x))
 
 #define __READ_ONCE_SCALAR(x)						\
 ({									\
-	typeof(x) __x = __READ_ONCE(x);					\
+	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
 	smp_read_barrier_depends();					\
-	__x;								\
+	(typeof(x))__x;							\
 })
 
 /*
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a8c1a6c..21e7859a356f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -219,6 +219,21 @@ struct ftrace_likely_data {
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
+/* Declare an unqualified scalar type. Leaves non-scalar types unchanged. */
+#define __unqual_scalar_typeof(x) typeof(					\
+	__builtin_choose_expr(__same_type(x, (__s8)0), (__s8)0,			\
+	__builtin_choose_expr(__same_type(x, (__u8)0), (__u8)0,			\
+	__builtin_choose_expr(__same_type(x, (__s16)0), (__s16)0,		\
+	__builtin_choose_expr(__same_type(x, (__u16)0), (__u16)0,		\
+	__builtin_choose_expr(__same_type(x, (__s32)0), (__s32)0,		\
+	__builtin_choose_expr(__same_type(x, (__u32)0), (__u32)0,		\
+	__builtin_choose_expr(__same_type(x, 0L), 0L,				\
+	__builtin_choose_expr(__same_type(x, 0UL), 0UL,				\
+	__builtin_choose_expr(__same_type(x, 0LL), 0LL,				\
+	__builtin_choose_expr(__same_type(x, 0ULL), 0ULL,			\
+	(x)									\
+)))))))))))
+
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
-- 
2.25.0.rc1.283.g88dfdc4193-goog

From: Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v5 5/6] bug: split BUILD_BUG stuff out into <linux/build_bug.h>
Date: Thu, 25 May 2017 13:03:15 +0100
Message-ID: <20170525120316.24473-6-abbotti@mev.co.uk>
References: <20170525120316.24473-1-abbotti@mev.co.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp120.ord1c.emailsrvr.com ([108.166.43.120]:56425 "EHLO
        smtp120.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1424010AbdEYMEA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 May 2017 08:04:00 -0400
In-Reply-To: <20170525120316.24473-1-abbotti@mev.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Ian Abbott <abbotti@mev.co.uk>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>, Michal Nazarewicz <mina86@mina86.com>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>

Including <linux/bug.h> pulls in a lot of bloat from <asm/bug.h> and
<asm-generic/bug.h> that is not needed to call the BUILD_BUG() family of
macros.  Split them out into their own header, <linux/build_bug.h>.

Also correct some checkpatch.pl errors for the BUILD_BUG_ON_ZERO() and
BUILD_BUG_ON_NULL() macros by adding parentheses around the bitfield
widths that begin with a minus sign.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v5: Actually, there was no v1 thru v4.  I called this v5 to match the
series.
---
 include/linux/bug.h       | 74 +----------------------------------------
 include/linux/build_bug.h | 84 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 73 deletions(-)
 create mode 100644 include/linux/build_bug.h

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 483207cb99fb..5d5554c874fd 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -3,6 +3,7 @@
 
 #include <asm/bug.h>
 #include <linux/compiler.h>
+#include <linux/build_bug.h>
 
 enum bug_trap_type {
 	BUG_TRAP_TYPE_NONE = 0,
@@ -13,82 +14,9 @@ enum bug_trap_type {
 struct pt_regs;
 
 #ifdef __CHECKER__
-#define __BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
-#define BUILD_BUG_ON_ZERO(e) (0)
-#define BUILD_BUG_ON_NULL(e) ((void *)0)
-#define BUILD_BUG_ON_INVALID(e) (0)
-#define BUILD_BUG_ON_MSG(cond, msg) (0)
-#define BUILD_BUG_ON(condition) (0)
-#define BUILD_BUG() (0)
 #define MAYBE_BUILD_BUG_ON(cond) (0)
 #else /* __CHECKER__ */
 
-/* Force a compilation error if a constant expression is not a power of 2 */
-#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
-	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
-	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
-
-/*
- * Force a compilation error if condition is true, but also produce a
- * result (of value 0 and type size_t), so the expression can be used
- * e.g. in a structure initializer (or where-ever else comma expressions
- * aren't permitted).
- */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
-#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:(-!!(e)); }))
-
-/*
- * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
- * expression but avoids the generation of any code, even if that expression
- * has side-effects.
- */
-#define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
-
-/**
- * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
- *		      error message.
- * @condition: the condition which the compiler should know is false.
- *
- * See BUILD_BUG_ON for description.
- */
-#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
-
-/**
- * BUILD_BUG_ON - break compile if a condition is true.
- * @condition: the condition which the compiler should know is false.
- *
- * If you have some code which relies on certain constants being equal, or
- * some other compile-time-evaluated condition, you should use BUILD_BUG_ON to
- * detect if someone changes it.
- *
- * The implementation uses gcc's reluctance to create a negative array, but gcc
- * (as of 4.4) only emits that error for obvious cases (e.g. not arguments to
- * inline functions).  Luckily, in 4.3 they added the "error" function
- * attribute just for this type of case.  Thus, we use a negative sized array
- * (should always create an error on gcc versions older than 4.4) and then call
- * an undefined function with the error attribute (should always create an
- * error on gcc 4.3 and later).  If for some reason, neither creates a
- * compile-time error, we'll still have a link-time error, which is harder to
- * track down.
- */
-#ifndef __OPTIMIZE__
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
-#else
-#define BUILD_BUG_ON(condition) \
-	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
-#endif
-
-/**
- * BUILD_BUG - break compile if used.
- *
- * If you have some code that you expect the compiler to eliminate at
- * build time, you should use BUILD_BUG to detect if it is
- * unexpectedly used.
- */
-#define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
-
 #define MAYBE_BUILD_BUG_ON(cond)			\
 	do {						\
 		if (__builtin_constant_p((cond)))       \
diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
new file mode 100644
index 000000000000..b7d22d60008a
--- /dev/null
+++ b/include/linux/build_bug.h
@@ -0,0 +1,84 @@
+#ifndef _LINUX_BUILD_BUG_H
+#define _LINUX_BUILD_BUG_H
+
+#include <linux/compiler.h>
+
+#ifdef __CHECKER__
+#define __BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n) (0)
+#define BUILD_BUG_ON_ZERO(e) (0)
+#define BUILD_BUG_ON_NULL(e) ((void *)0)
+#define BUILD_BUG_ON_INVALID(e) (0)
+#define BUILD_BUG_ON_MSG(cond, msg) (0)
+#define BUILD_BUG_ON(condition) (0)
+#define BUILD_BUG() (0)
+#else /* __CHECKER__ */
+
+/* Force a compilation error if a constant expression is not a power of 2 */
+#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
+	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
+	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
+
+/*
+ * Force a compilation error if condition is true, but also produce a
+ * result (of value 0 and type size_t), so the expression can be used
+ * e.g. in a structure initializer (or where-ever else comma expressions
+ * aren't permitted).
+ */
+#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
+#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:(-!!(e)); }))
+
+/*
+ * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
+ * expression but avoids the generation of any code, even if that expression
+ * has side-effects.
+ */
+#define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
+
+/**
+ * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
+ *		      error message.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * See BUILD_BUG_ON for description.
+ */
+#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
+
+/**
+ * BUILD_BUG_ON - break compile if a condition is true.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * If you have some code which relies on certain constants being equal, or
+ * some other compile-time-evaluated condition, you should use BUILD_BUG_ON to
+ * detect if someone changes it.
+ *
+ * The implementation uses gcc's reluctance to create a negative array, but gcc
+ * (as of 4.4) only emits that error for obvious cases (e.g. not arguments to
+ * inline functions).  Luckily, in 4.3 they added the "error" function
+ * attribute just for this type of case.  Thus, we use a negative sized array
+ * (should always create an error on gcc versions older than 4.4) and then call
+ * an undefined function with the error attribute (should always create an
+ * error on gcc 4.3 and later).  If for some reason, neither creates a
+ * compile-time error, we'll still have a link-time error, which is harder to
+ * track down.
+ */
+#ifndef __OPTIMIZE__
+#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
+#else
+#define BUILD_BUG_ON(condition) \
+	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
+#endif
+
+/**
+ * BUILD_BUG - break compile if used.
+ *
+ * If you have some code that you expect the compiler to eliminate at
+ * build time, you should use BUILD_BUG to detect if it is
+ * unexpectedly used.
+ */
+#define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
+
+#endif	/* __CHECKER__ */
+
+#endif	/* _LINUX_BUILD_BUG_H */
-- 
2.11.0

From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 27/27] x86/int3: Ensure that poke_int3_handler() is not sanitized
Date: Fri, 21 Feb 2020 14:34:43 +0100
Message-ID: <20200221134216.860887691@infradead.org>
References: <20200221133416.777099322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-arch.vger.kernel.org

In order to ensure poke_int3_handler() is completely self contained --
we call this while we're modifying other text, imagine the fun of
hitting another INT3 -- ensure that everything is without sanitize
instrumentation.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 arch/x86/kernel/alternative.c       |    2 +-
 arch/x86/kernel/traps.c             |    2 +-
 include/linux/compiler-clang.h      |    7 +++++++
 include/linux/compiler-gcc.h        |    6 ++++++
 include/linux/compiler.h            |    5 +++++
 include/linux/compiler_attributes.h |    1 +
 6 files changed, 21 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -990,7 +990,7 @@ static __always_inline int patch_cmp(con
 	return 0;
 }
 
-int notrace poke_int3_handler(struct pt_regs *regs)
+notrace __no_sanitize int poke_int3_handler(struct pt_regs *regs)
 {
 	struct bp_patching_desc *desc;
 	struct text_poke_loc *tp;
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -502,7 +502,7 @@ dotraplinkage void do_general_protection
 }
 NOKPROBE_SYMBOL(do_general_protection);
 
-dotraplinkage notrace void do_int3(struct pt_regs *regs, long error_code)
+dotraplinkage notrace __no_sanitize void do_int3(struct pt_regs *regs, long error_code)
 {
 	if (poke_int3_handler(regs))
 		return;
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -24,6 +24,13 @@
 #define __no_sanitize_address
 #endif
 
+#if __has_feature(undefined_sanitizer)
+#define __no_sanitize_undefined \
+		__atribute__((no_sanitize("undefined")))
+#else
+#define __no_sanitize_undefined
+#endif
+
 /*
  * Not all versions of clang implement the the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -145,6 +145,12 @@
 #define __no_sanitize_address
 #endif
 
+#if __has_attribute(__no_sanitize_undefined__)
+#define __no_sanitize_undefined __attribute__((no_sanitize_undefined))
+#else
+#define __no_sanitize_undefined
+#endif
+
 #if GCC_VERSION >= 50100
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -199,6 +199,7 @@ void __read_once_size(const volatile voi
 	__READ_ONCE_SIZE;
 }
 
+#define __no_kasan __no_sanitize_address
 #ifdef CONFIG_KASAN
 /*
  * We can't declare function 'inline' because __no_sanitize_address confilcts
@@ -274,6 +275,10 @@ static __always_inline void __write_once
  */
 #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
 
+#define __no_ubsan __no_sanitize_undefined
+
+#define __no_sanitize __no_kasan __no_ubsan
+
 static __no_kasan_or_inline
 unsigned long read_word_at_a_time(const void *addr)
 {
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -41,6 +41,7 @@
 # define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
 # define __GCC4_has_attribute___fallthrough__         0
+# define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
 #endif
 
 /*

From: Marco Elver <elver@google.com>
Subject: [PATCH v2 1/8] kcsan: Support compounded read-write instrumentation
Date: Fri, 24 Jul 2020 09:00:01 +0200
Message-ID: <20200724070008.1389205-2-elver@google.com>
References: <20200724070008.1389205-1-elver@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200724070008.1389205-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: elver@google.com, paulmck@kernel.org
Cc: will@kernel.org, peterz@infradead.org, arnd@arndb.de, mark.rutland@arm.com, dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Add support for compounded read-write instrumentation if supported by
the compiler. Adds the necessary instrumentation functions, and a new
type which is used to generate a more descriptive report.

Furthermore, such compounded memory access instrumentation is excluded
from the "assume aligned writes up to word size are atomic" rule,
because we cannot assume that the compiler emits code that is atomic for
compound ops.

LLVM/Clang added support for the feature in:
https://github.com/llvm/llvm-project/commit/785d41a261d136b64ab6c15c5d35f2adc5ad53e3

The new instrumentation is emitted for sets of memory accesses in the
same basic block to the same address with at least one read appearing
before a write. These typically result from compound operations such as
++, --, +=, -=, |=, &=, etc. but also equivalent forms such as "var =
var + 1". Where the compiler determines that it is equivalent to emit a
call to a single __tsan_read_write instead of separate __tsan_read and
__tsan_write, we can then benefit from improved performance and better
reporting for such access patterns.

The new reports now show that the ops are both reads and writes, for
example:

	read-write to 0xffffffff90548a38 of 8 bytes by task 143 on cpu 3:
	 test_kernel_rmw_array+0x45/0xa0
	 access_thread+0x71/0xb0
	 kthread+0x21e/0x240
	 ret_from_fork+0x22/0x30

	read-write to 0xffffffff90548a38 of 8 bytes by task 144 on cpu 2:
	 test_kernel_rmw_array+0x45/0xa0
	 access_thread+0x71/0xb0
	 kthread+0x21e/0x240
	 ret_from_fork+0x22/0x30

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan-checks.h | 45 ++++++++++++++++++++++++------------
 kernel/kcsan/core.c          | 23 ++++++++++++++----
 kernel/kcsan/report.c        |  4 ++++
 scripts/Makefile.kcsan       |  2 +-
 4 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 7b0b9c44f5f3..ab23b38ad93d 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -7,19 +7,13 @@
 #include <linux/compiler_attributes.h>
 #include <linux/types.h>
 
-/*
- * ACCESS TYPE MODIFIERS
- *
- *   <none>: normal read access;
- *   WRITE : write access;
- *   ATOMIC: access is atomic;
- *   ASSERT: access is not a regular access, but an assertion;
- *   SCOPED: access is a scoped access;
- */
-#define KCSAN_ACCESS_WRITE  0x1
-#define KCSAN_ACCESS_ATOMIC 0x2
-#define KCSAN_ACCESS_ASSERT 0x4
-#define KCSAN_ACCESS_SCOPED 0x8
+/* Access types -- if KCSAN_ACCESS_WRITE is not set, the access is a read. */
+#define KCSAN_ACCESS_WRITE	(1 << 0) /* Access is a write. */
+#define KCSAN_ACCESS_COMPOUND	(1 << 1) /* Compounded read-write instrumentation. */
+#define KCSAN_ACCESS_ATOMIC	(1 << 2) /* Access is atomic. */
+/* The following are special, and never due to compiler instrumentation. */
+#define KCSAN_ACCESS_ASSERT	(1 << 3) /* Access is an assertion. */
+#define KCSAN_ACCESS_SCOPED	(1 << 4) /* Access is a scoped access. */
 
 /*
  * __kcsan_*: Always calls into the runtime when KCSAN is enabled. This may be used
@@ -204,6 +198,15 @@ static inline void __kcsan_disable_current(void) { }
 #define __kcsan_check_write(ptr, size)                                         \
 	__kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
 
+/**
+ * __kcsan_check_read_write - check regular read-write access for races
+ *
+ * @ptr: address of access
+ * @size: size of access
+ */
+#define __kcsan_check_read_write(ptr, size)                                    \
+	__kcsan_check_access(ptr, size, KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE)
+
 /**
  * kcsan_check_read - check regular read access for races
  *
@@ -221,18 +224,30 @@ static inline void __kcsan_disable_current(void) { }
 #define kcsan_check_write(ptr, size)                                           \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
 
+/**
+ * kcsan_check_read_write - check regular read-write access for races
+ *
+ * @ptr: address of access
+ * @size: size of access
+ */
+#define kcsan_check_read_write(ptr, size)                                      \
+	kcsan_check_access(ptr, size, KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE)
+
 /*
  * Check for atomic accesses: if atomic accesses are not ignored, this simply
  * aliases to kcsan_check_access(), otherwise becomes a no-op.
  */
 #ifdef CONFIG_KCSAN_IGNORE_ATOMICS
-#define kcsan_check_atomic_read(...)	do { } while (0)
-#define kcsan_check_atomic_write(...)	do { } while (0)
+#define kcsan_check_atomic_read(...)		do { } while (0)
+#define kcsan_check_atomic_write(...)		do { } while (0)
+#define kcsan_check_atomic_read_write(...)	do { } while (0)
 #else
 #define kcsan_check_atomic_read(ptr, size)                                     \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC)
 #define kcsan_check_atomic_write(ptr, size)                                    \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
+#define kcsan_check_atomic_read_write(ptr, size)                               \
+	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND)
 #endif
 
 /**
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index f8dd9b2b8068..fb52de2facf3 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -223,7 +223,7 @@ is_atomic(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx
 
 	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
 	    (type & KCSAN_ACCESS_WRITE) && size <= sizeof(long) &&
-	    IS_ALIGNED((unsigned long)ptr, size))
+	    !(type & KCSAN_ACCESS_COMPOUND) && IS_ALIGNED((unsigned long)ptr, size))
 		return true; /* Assume aligned writes up to word size are atomic. */
 
 	if (ctx->atomic_next > 0) {
@@ -771,7 +771,17 @@ EXPORT_SYMBOL(__kcsan_check_access);
 	EXPORT_SYMBOL(__tsan_write##size);                                     \
 	void __tsan_unaligned_write##size(void *ptr)                           \
 		__alias(__tsan_write##size);                                   \
-	EXPORT_SYMBOL(__tsan_unaligned_write##size)
+	EXPORT_SYMBOL(__tsan_unaligned_write##size);                           \
+	void __tsan_read_write##size(void *ptr);                               \
+	void __tsan_read_write##size(void *ptr)                                \
+	{                                                                      \
+		check_access(ptr, size,                                        \
+			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE);      \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_read_write##size);                                \
+	void __tsan_unaligned_read_write##size(void *ptr)                      \
+		__alias(__tsan_read_write##size);                              \
+	EXPORT_SYMBOL(__tsan_unaligned_read_write##size)
 
 DEFINE_TSAN_READ_WRITE(1);
 DEFINE_TSAN_READ_WRITE(2);
@@ -894,7 +904,8 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
 	u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		check_access(ptr, bits / BITS_PER_BYTE,                                            \
+			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
 		return __atomic_##op##suffix(ptr, v, memorder);                                    \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
@@ -922,7 +933,8 @@ EXPORT_SYMBOL(__tsan_init);
 	int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
 							      u##bits val, int mo, int fail_mo)    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		check_access(ptr, bits / BITS_PER_BYTE,                                            \
+			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
 		return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
 	}                                                                                          \
 	EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
@@ -933,7 +945,8 @@ EXPORT_SYMBOL(__tsan_init);
 	u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
 							   int mo, int fail_mo)                    \
 	{                                                                                          \
-		check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
+		check_access(ptr, bits / BITS_PER_BYTE,                                            \
+			     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
 		__atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
 		return exp;                                                                        \
 	}                                                                                          \
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ac5f8345bae9..d05052c23261 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -228,6 +228,10 @@ static const char *get_access_type(int type)
 		return "write";
 	case KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
 		return "write (marked)";
+	case KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE:
+		return "read-write";
+	case KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
+		return "read-write (marked)";
 	case KCSAN_ACCESS_SCOPED:
 		return "read (scoped)";
 	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_ATOMIC:
diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index dd66206f4578..a20dd63dfd17 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -13,7 +13,7 @@ endif
 # of some options does not break KCSAN nor causes false positive reports.
 CFLAGS_KCSAN := -fsanitize=thread \
 	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
-	$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1)) \
+	$(call cc-option,$(call cc-param,tsan-compound-read-before-write=1),$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1))) \
 	$(call cc-param,tsan-distinguish-volatile=1)
 
 endif # CONFIG_KCSAN
-- 
2.28.0.rc0.142.g3c755180ce-goog

From: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch description
Date: Thu,  7 Feb 2019 23:46:29 +1100
Message-ID: <20190207124635.3885-1-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dyoung@redhat.com, sergey.senozhatsky@gmail.com, pmladek@suse.com
List-Id: linux-arch.vger.kernel.org

Arch code can set a "dump stack arch description string" which is
displayed with oops output to describe the hardware platform.

It is useful to initialise this as early as possible, so that an early
oops will have the hardware description.

However in practice we discover the hardware platform in stages, so it
would be useful to be able to incrementally fill in the hardware
description as we discover it.

This patch adds that ability, by creating dump_stack_add_arch_desc().

If there is no existing string it behaves exactly like
dump_stack_set_arch_desc(). However if there is an existing string it
appends to it, with a leading space.

This makes it easy to call it multiple times from different parts of the
code and get a reasonable looking result.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 include/linux/printk.h |  5 ++++
 lib/dump_stack.c       | 58 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

v3: No change, just widened Cc list.

v2: Add a smp_wmb() and comment.

v1 is here for reference https://lore.kernel.org/lkml/1430824337-15339-1-git-send-email-mpe@ellerman.id.au/

I'll take this series via the powerpc tree if no one minds?


diff --git a/include/linux/printk.h b/include/linux/printk.h
index 77740a506ebb..d5fb4f960271 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -198,6 +198,7 @@ u32 log_buf_len_get(void);
 void log_buf_vmcoreinfo_setup(void);
 void __init setup_log_buf(int early);
 __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
+__printf(1, 2) void dump_stack_add_arch_desc(const char *fmt, ...);
 void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack(void) __cold;
@@ -256,6 +257,10 @@ static inline __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...)
 {
 }
 
+static inline __printf(1, 2) void dump_stack_add_arch_desc(const char *fmt, ...)
+{
+}
+
 static inline void dump_stack_print_info(const char *log_lvl)
 {
 }
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 5cff72f18c4a..69b710ff92b5 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -35,6 +35,64 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
 	va_end(args);
 }
 
+/**
+ * dump_stack_add_arch_desc - add arch-specific info to show with task dumps
+ * @fmt: printf-style format string
+ * @...: arguments for the format string
+ *
+ * See dump_stack_set_arch_desc() for why you'd want to use this.
+ *
+ * This version adds to any existing string already created with either
+ * dump_stack_set_arch_desc() or dump_stack_add_arch_desc(). If there is an
+ * existing string a space will be prepended to the passed string.
+ */
+void __init dump_stack_add_arch_desc(const char *fmt, ...)
+{
+	va_list args;
+	int pos, len;
+	char *p;
+
+	/*
+	 * If there's an existing string we snprintf() past the end of it, and
+	 * then turn the terminating NULL of the existing string into a space
+	 * to create one string separated by a space.
+	 *
+	 * If there's no existing string we just snprintf() to the buffer, like
+	 * dump_stack_set_arch_desc(), but without calling it because we'd need
+	 * a varargs version.
+	 */
+	len = strnlen(dump_stack_arch_desc_str, sizeof(dump_stack_arch_desc_str));
+	pos = len;
+
+	if (len)
+		pos++;
+
+	if (pos >= sizeof(dump_stack_arch_desc_str))
+		return; /* Ran out of space */
+
+	p = &dump_stack_arch_desc_str[pos];
+
+	va_start(args, fmt);
+	vsnprintf(p, sizeof(dump_stack_arch_desc_str) - pos, fmt, args);
+	va_end(args);
+
+	if (len) {
+		/*
+		 * Order the stores above in vsnprintf() vs the store of the
+		 * space below which joins the two strings. Note this doesn't
+		 * make the code truly race free because there is no barrier on
+		 * the read side. ie. Another CPU might load the uninitialised
+		 * tail of the buffer first and then the space below (rather
+		 * than the NULL that was there previously), and so print the
+		 * uninitialised tail. But the whole string lives in BSS so in
+		 * practice it should just see NULLs.
+		 */
+		smp_wmb();
+
+		dump_stack_arch_desc_str[len] = ' ';
+	}
+}
+
 /**
  * dump_stack_print_info - print generic debug info for dump_stack()
  * @log_lvl: log level
-- 
2.20.1

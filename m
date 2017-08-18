From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 4/6] init: allow initcall tables to be emitted using relative references
Date: Fri, 18 Aug 2017 12:26:22 +0100
Message-ID: <20170818112624.24991-5-ard.biesheuvel@linaro.org>
References: <20170818112624.24991-1-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34218 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdHRL1D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 07:27:03 -0400
Received: by mail-wr0-f169.google.com with SMTP id y96so65057734wrc.1
        for <linux-arch@vger.kernel.org>; Fri, 18 Aug 2017 04:27:03 -0700 (PDT)
In-Reply-To: <20170818112624.24991-1-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Nicolas Pitre <nico@linaro.org>, Steve

Allow the initcall tables to be emitted using relative references that
are only half the size on 64-bit architectures and don't require fixups
at runtime on relocatable kernels.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: James Morris <james.l.morris@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/init.h   | 64 ++++++++++++++++----
 init/main.c            | 22 ++-----
 kernel/printk/printk.c |  4 +-
 security/security.c    |  6 +-
 4 files changed, 62 insertions(+), 34 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 94769d687cf0..61022aec47ea 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -110,9 +110,6 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-extern initcall_t __con_initcall_start[], __con_initcall_end[];
-extern initcall_t __security_initcall_start[], __security_initcall_end[];
-
 /* Used for contructor calls. */
 typedef void (*ctor_fn_t)(void);
 
@@ -161,9 +158,57 @@ extern bool initcall_debug;
  * as KEEP() in the linker script.
  */
 
-#define __define_initcall(fn, id) \
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define ___define_initcall(fn, id, __sec)		\
+	__ADDRESSABLE(fn)				\
+	asm(".section	\"" #__sec ".init\", \"a\"\n"	\
+	"__initcall_" #fn #id ":\n"			\
+	    ".long "	VMLINUX_SYMBOL_STR(fn) " - .\n"	\
+	    ".previous\n")
+
+struct initcall_entry_t {
+	int offset;
+};
+
+static inline
+initcall_t initcall_from_entry(const struct initcall_entry_t *entry)
+{
+	return (initcall_t)((unsigned long)entry + entry->offset);
+}
+#else
+#define ___define_initcall(fn, id, __sec) \
 	static initcall_t __initcall_##fn##id __used \
-	__attribute__((__section__(".initcall" #id ".init"))) = fn;
+		__attribute__((__section__(#__sec ".init"))) = fn
+
+struct initcall_entry_t {
+	initcall_t call;
+};
+
+static inline
+initcall_t initcall_from_entry(const struct initcall_entry_t *entry)
+{
+	return entry->call;
+}
+#endif
+
+extern struct initcall_entry_t __initcall_start[];
+extern struct initcall_entry_t __initcall0_start[];
+extern struct initcall_entry_t __initcall1_start[];
+extern struct initcall_entry_t __initcall2_start[];
+extern struct initcall_entry_t __initcall3_start[];
+extern struct initcall_entry_t __initcall4_start[];
+extern struct initcall_entry_t __initcall5_start[];
+extern struct initcall_entry_t __initcall6_start[];
+extern struct initcall_entry_t __initcall7_start[];
+extern struct initcall_entry_t __initcall_end[];
+
+extern struct initcall_entry_t __con_initcall_start[];
+extern struct initcall_entry_t __con_initcall_end[];
+
+extern struct initcall_entry_t __security_initcall_start[];
+extern struct initcall_entry_t __security_initcall_end[];
+
+#define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
 /*
  * Early initcalls run before initializing SMP.
@@ -202,13 +247,8 @@ extern bool initcall_debug;
 #define __exitcall(fn)						\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define console_initcall(fn)					\
-	static initcall_t __initcall_##fn			\
-	__used __section(.con_initcall.init) = fn
-
-#define security_initcall(fn)					\
-	static initcall_t __initcall_##fn			\
-	__used __section(.security_initcall.init) = fn
+#define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
+#define security_initcall(fn)	___define_initcall(fn,, .security_initcall)
 
 struct obs_kernel_param {
 	const char *str;
diff --git a/init/main.c b/init/main.c
index 052481fbe363..174a68ee85c4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -832,19 +832,7 @@ int __init_or_module do_one_initcall(initcall_t fn)
 	return ret;
 }
 
-
-extern initcall_t __initcall_start[];
-extern initcall_t __initcall0_start[];
-extern initcall_t __initcall1_start[];
-extern initcall_t __initcall2_start[];
-extern initcall_t __initcall3_start[];
-extern initcall_t __initcall4_start[];
-extern initcall_t __initcall5_start[];
-extern initcall_t __initcall6_start[];
-extern initcall_t __initcall7_start[];
-extern initcall_t __initcall_end[];
-
-static initcall_t *initcall_levels[] __initdata = {
+static struct initcall_entry_t *initcall_levels[] __initdata = {
 	__initcall0_start,
 	__initcall1_start,
 	__initcall2_start,
@@ -870,7 +858,7 @@ static char *initcall_level_names[] __initdata = {
 
 static void __init do_initcall_level(int level)
 {
-	initcall_t *fn;
+	struct initcall_entry_t *fn;
 
 	strcpy(initcall_command_line, saved_command_line);
 	parse_args(initcall_level_names[level],
@@ -880,7 +868,7 @@ static void __init do_initcall_level(int level)
 		   NULL, &repair_env_string);
 
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(*fn);
+		do_one_initcall(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -911,10 +899,10 @@ static void __init do_basic_setup(void)
 
 static void __init do_pre_smp_initcalls(void)
 {
-	initcall_t *fn;
+	struct initcall_entry_t *fn;
 
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(*fn);
+		do_one_initcall(initcall_from_entry(fn));
 }
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fc47863f629c..95a964592dc6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2623,7 +2623,7 @@ EXPORT_SYMBOL(unregister_console);
  */
 void __init console_init(void)
 {
-	initcall_t *call;
+	struct initcall_entry_t *call;
 
 	/* Setup the default TTY line discipline. */
 	n_tty_init();
@@ -2634,7 +2634,7 @@ void __init console_init(void)
 	 */
 	call = __con_initcall_start;
 	while (call < __con_initcall_end) {
-		(*call)();
+		initcall_from_entry(call)();
 		call++;
 	}
 }
diff --git a/security/security.c b/security/security.c
index 30132378d103..e878b6f5ce9c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -44,10 +44,10 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 
 static void __init do_security_initcalls(void)
 {
-	initcall_t *call;
-	call = __security_initcall_start;
+	struct initcall_entry_t *call = __security_initcall_start;
+
 	while (call < __security_initcall_end) {
-		(*call) ();
+		initcall_from_entry(call)();
 		call++;
 	}
 }
-- 
2.11.0

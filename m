From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 5/5] kernel: tracepoints: add support for relative references
Date: Mon, 14 Aug 2017 11:52:31 +0100
Message-ID: <20170814105231.14608-6-ard.biesheuvel@linaro.org>
References: <20170814105231.14608-1-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34647 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752986AbdHNKx1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Aug 2017 06:53:27 -0400
Received: by mail-wr0-f178.google.com with SMTP id l9so10573932wrl.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Aug 2017 03:53:26 -0700 (PDT)
In-Reply-To: <20170814105231.14608-1-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>, Steven Rostedt <rostedt@goodmis.org>

To avoid the need for relocating absolute references to tracepoint
structures at boot time when running relocatable kernels (which may
take a disproportionate amount of space), add the option to emit
these tables as relative references instead.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/tracepoint.h | 19 +++++++++++++++----
 kernel/tracepoint.c        | 19 ++++++++++++++-----
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index a26ffbe09e71..d02bf1a695e8 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -228,6 +228,19 @@ extern void syscall_unregfunc(void);
 		return static_key_false(&__tracepoint_##name.key);	\
 	}
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __TRACEPOINT_ENTRY(name)					 \
+	asm("	.section \"__tracepoints_ptrs\", \"a\"		     \n" \
+	    "	.balign 4					     \n" \
+	    "	.long " VMLINUX_SYMBOL_STR(__tracepoint_##name) " - .\n" \
+	    "	.previous					     \n")
+#else
+#define __TRACEPOINT_ENTRY(name)					 \
+	static struct tracepoint * const __tracepoint_ptr_##name __used	 \
+	__attribute__((section("__tracepoints_ptrs"))) =		 \
+		&__tracepoint_##name
+#endif
+
 /*
  * We have no guarantee that gcc and the linker won't up-align the tracepoint
  * structures, so we create an array of pointers that will be used for iteration
@@ -237,11 +250,9 @@ extern void syscall_unregfunc(void);
 	static const char __tpstrtab_##name[]				 \
 	__attribute__((section("__tracepoints_strings"))) = #name;	 \
 	struct tracepoint __tracepoint_##name				 \
-	__attribute__((section("__tracepoints"))) =			 \
+	__attribute__((section("__tracepoints"), used)) =		 \
 		{ __tpstrtab_##name, STATIC_KEY_INIT_FALSE, reg, unreg, NULL };\
-	static struct tracepoint * const __tracepoint_ptr_##name __used	 \
-	__attribute__((section("__tracepoints_ptrs"))) =		 \
-		&__tracepoint_##name;
+	__TRACEPOINT_ENTRY(name);
 
 #define DEFINE_TRACE(name)						\
 	DEFINE_TRACE_FN(name, NULL, NULL);
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 685c50ae6300..1c6689603764 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -28,8 +28,8 @@
 #include <linux/sched/task.h>
 #include <linux/static_key.h>
 
-extern struct tracepoint * const __start___tracepoints_ptrs[];
-extern struct tracepoint * const __stop___tracepoints_ptrs[];
+extern const unsigned char __start___tracepoints_ptrs[];
+extern const unsigned char __stop___tracepoints_ptrs[];
 
 /* Set to 1 to enable tracepoint debug output */
 static const int tracepoint_debug;
@@ -503,17 +503,26 @@ static __init int init_tracepoints(void)
 __initcall(init_tracepoints);
 #endif /* CONFIG_MODULES */
 
-static void for_each_tracepoint_range(struct tracepoint * const *begin,
-		struct tracepoint * const *end,
+static void for_each_tracepoint_range(const void *begin, const void *end,
 		void (*fct)(struct tracepoint *tp, void *priv),
 		void *priv)
 {
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	const signed int *iter;
+
+	if (!begin)
+		return;
+	for (iter = begin; iter < (signed int *)end; iter++) {
+		fct((struct tracepoint *)((unsigned long)iter + *iter), priv);
+	}
+#else
 	struct tracepoint * const *iter;
 
 	if (!begin)
 		return;
-	for (iter = begin; iter < end; iter++)
+	for (iter = begin; iter < (struct tracepoint * const *)end; iter++)
 		fct(*iter, priv);
+#endif
 }
 
 /**
-- 
2.11.0

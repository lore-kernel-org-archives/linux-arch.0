From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v9 4/5] irq: Make irqentry text section unconditional
Date: Thu,  3 Aug 2017 11:38:21 +0900
Message-ID: <150172789110.27216.3955739126693102122.stgit@devbox>
References: <150172762859.27216.16741726568669538542.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751188AbdHCCjL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Aug 2017 22:39:11 -0400
In-Reply-To: <150172762859.27216.16741726568669538542.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>, mathieu.desnoyers@efficios.com, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com, linux-arch@vger.kernel.org

Generate irqentry and softirqentry text sections without
any configs. This will add above extra sections, but
no performace impact.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Suggested-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/include/asm/traps.h      |    7 -------
 arch/arm64/include/asm/traps.h    |    7 -------
 arch/x86/entry/entry_64.S         |    9 ++-------
 arch/x86/kernel/unwind_frame.c    |    2 --
 include/asm-generic/sections.h    |    4 ++++
 include/asm-generic/vmlinux.lds.h |    8 --------
 include/linux/interrupt.h         |   14 +-------------
 7 files changed, 7 insertions(+), 44 deletions(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index f555bb3664dc..683d9230984a 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -18,7 +18,6 @@ struct undef_hook {
 void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static inline int __in_irqentry_text(unsigned long ptr)
 {
 	extern char __irqentry_text_start[];
@@ -27,12 +26,6 @@ static inline int __in_irqentry_text(unsigned long ptr)
 	return ptr >= (unsigned long)&__irqentry_text_start &&
 	       ptr < (unsigned long)&__irqentry_text_end;
 }
-#else
-static inline int __in_irqentry_text(unsigned long ptr)
-{
-	return 0;
-}
-#endif
 
 static inline int in_exception_text(unsigned long ptr)
 {
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 02e9035b0685..47a9066f7c86 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -37,18 +37,11 @@ void unregister_undef_hook(struct undef_hook *hook);
 
 void arm64_notify_segfault(struct pt_regs *regs, unsigned long addr);
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static inline int __in_irqentry_text(unsigned long ptr)
 {
 	return ptr >= (unsigned long)&__irqentry_text_start &&
 	       ptr < (unsigned long)&__irqentry_text_end;
 }
-#else
-static inline int __in_irqentry_text(unsigned long ptr)
-{
-	return 0;
-}
-#endif
 
 static inline int in_exception_text(unsigned long ptr)
 {
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index aa58155187c5..5e41396efbbf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -766,13 +766,8 @@ apicinterrupt3 \num trace(\sym) smp_trace(\sym)
 #endif
 
 /* Make sure APIC interrupt handlers end up in the irqentry section: */
-#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_KASAN)
-# define PUSH_SECTION_IRQENTRY	.pushsection .irqentry.text, "ax"
-# define POP_SECTION_IRQENTRY	.popsection
-#else
-# define PUSH_SECTION_IRQENTRY
-# define POP_SECTION_IRQENTRY
-#endif
+#define PUSH_SECTION_IRQENTRY	.pushsection .irqentry.text, "ax"
+#define POP_SECTION_IRQENTRY	.popsection
 
 .macro apicinterrupt num sym do_sym
 PUSH_SECTION_IRQENTRY
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 7574ef5f16ec..d145a0b1f529 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -84,10 +84,8 @@ static bool in_entry_code(unsigned long ip)
 	if (addr >= __entry_text_start && addr < __entry_text_end)
 		return true;
 
-#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_KASAN)
 	if (addr >= __irqentry_text_start && addr < __irqentry_text_end)
 		return true;
-#endif
 
 	return false;
 }
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 532372c6cf15..e5da44eddd2f 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -27,6 +27,8 @@
  *	__kprobes_text_start, __kprobes_text_end
  *	__entry_text_start, __entry_text_end
  *	__ctors_start, __ctors_end
+ *	__irqentry_text_start, __irqentry_text_end
+ *	__softirqentry_text_start, __softirqentry_text_end
  */
 extern char _text[], _stext[], _etext[];
 extern char _data[], _sdata[], _edata[];
@@ -39,6 +41,8 @@ extern char __per_cpu_load[], __per_cpu_start[], __per_cpu_end[];
 extern char __kprobes_text_start[], __kprobes_text_end[];
 extern char __entry_text_start[], __entry_text_end[];
 extern char __start_rodata[], __end_rodata[];
+extern char __irqentry_text_start[], __irqentry_text_end[];
+extern char __softirqentry_text_start[], __softirqentry_text_end[];
 
 /* Start and end of .ctors section - used for constructor calls. */
 extern char __ctors_start[], __ctors_end[];
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index fffc9bdae025..438b014c192f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -483,25 +483,17 @@
 		*(.entry.text)						\
 		VMLINUX_SYMBOL(__entry_text_end) = .;
 
-#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_KASAN)
 #define IRQENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__irqentry_text_start) = .;		\
 		*(.irqentry.text)					\
 		VMLINUX_SYMBOL(__irqentry_text_end) = .;
-#else
-#define IRQENTRY_TEXT
-#endif
 
-#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_KASAN)
 #define SOFTIRQENTRY_TEXT						\
 		ALIGN_FUNCTION();					\
 		VMLINUX_SYMBOL(__softirqentry_text_start) = .;		\
 		*(.softirqentry.text)					\
 		VMLINUX_SYMBOL(__softirqentry_text_end) = .;
-#else
-#define SOFTIRQENTRY_TEXT
-#endif
 
 /* Section used for early init (in .S files) */
 #define HEAD_TEXT  *(.head.text)
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a2fddddb0d60..59ba11661b6e 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -18,6 +18,7 @@
 #include <linux/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/irq.h>
+#include <asm/sections.h>
 
 /*
  * These correspond to the IORESOURCE_IRQ_* defines in
@@ -726,7 +727,6 @@ extern int early_irq_init(void);
 extern int arch_probe_nr_irqs(void);
 extern int arch_early_irq_init(void);
 
-#if defined(CONFIG_FUNCTION_GRAPH_TRACER) || defined(CONFIG_KASAN)
 /*
  * We want to know which function is an entrypoint of a hardirq or a softirq.
  */
@@ -734,16 +734,4 @@ extern int arch_early_irq_init(void);
 #define __softirq_entry  \
 	__attribute__((__section__(".softirqentry.text")))
 
-/* Limits of hardirq entrypoints */
-extern char __irqentry_text_start[];
-extern char __irqentry_text_end[];
-/* Limits of softirq entrypoints */
-extern char __softirqentry_text_start[];
-extern char __softirqentry_text_end[];
-
-#else
-#define __irq_entry
-#define __softirq_entry
-#endif
-
 #endif

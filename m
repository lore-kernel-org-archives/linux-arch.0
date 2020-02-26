From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
Date: Wed, 26 Feb 2020 11:25:09 +0100
Message-ID: <20200226102509.GU18400@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.328642621@infradead.org>
 <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
 <20200221202246.GA14897@hirez.programming.kicks-ass.net>
 <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
 <20200224112708.4f307ba3@gandalf.local.home>
 <20200224163409.GJ18400@hirez.programming.kicks-ass.net>
 <20200224114754.0fb798c1@gandalf.local.home>
 <20200224213139.GO11457@worktop.programming.kicks-ass.net>
 <20200224170231.3807931d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:41234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgBZKZq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 05:25:46 -0500
Content-Disposition: inline
In-Reply-To: <20200224170231.3807931d@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Tony Luck <tony.luck@intel.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

On Mon, Feb 24, 2020 at 05:02:31PM -0500, Steven Rostedt wrote:
> On Mon, 24 Feb 2020 22:31:39 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Just want to confirm that printk_nmi_enter(), lockdep_off(),
> > > and ftrace_nmi_enter() are all marked fully with NOKPROBE.  
> > 
> > *sigh*, right you are, I only looked at notrace, not nokprobe.
> > 
> > In particular the ftrace one is a bit off a mess, let me sort through
> > that.
> 
> ftrace_nmi_enter() has two purposes. One, for archs that need to deal with
> NMIs while they still use stop machine. Although, it appears sh is the only
> arch that does that. I can look to see if it can be ripped out.

Already done  :-)

---
Subject: sh/ftrace: Move arch_ftrace_nmi_{enter,exit} into nmi exception
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Feb 24 22:26:21 CET 2020

SuperH is the last remaining user of arch_ftrace_nmi_{enter,exit}(),
remove it from the generic code and into the SuperH code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/trace/ftrace-design.rst |    8 --------
 arch/sh/Kconfig                       |    1 -
 arch/sh/kernel/traps.c                |   12 ++++++++++++
 include/linux/ftrace_irq.h            |   11 -----------
 kernel/trace/Kconfig                  |   10 ----------
 5 files changed, 12 insertions(+), 30 deletions(-)

--- a/Documentation/trace/ftrace-design.rst
+++ b/Documentation/trace/ftrace-design.rst
@@ -229,14 +229,6 @@ Adding support for it is easy: just defi
 pass the return address pointer as the 'retp' argument to
 ftrace_push_return_trace().
 
-HAVE_FTRACE_NMI_ENTER
----------------------
-
-If you can't trace NMI functions, then skip this option.
-
-<details to be filled>
-
-
 HAVE_SYSCALL_TRACEPOINTS
 ------------------------
 
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -71,7 +71,6 @@ config SUPERH32
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
-	select HAVE_FTRACE_NMI_ENTER if DYNAMIC_FTRACE
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_ARCH_KGDB
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -170,11 +170,21 @@ BUILD_TRAP_HANDLER(bug)
 	force_sig(SIGTRAP);
 }
 
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE
+extern void arch_ftrace_nmi_enter(void);
+extern void arch_ftrace_nmi_exit(void);
+#else
+static inline void arch_ftrace_nmi_enter(void) { }
+static inline void arch_ftrace_nmi_exit(void) { }
+#endif
+
 BUILD_TRAP_HANDLER(nmi)
 {
 	unsigned int cpu = smp_processor_id();
 	TRAP_HANDLER_DECL;
 
+	arch_ftrace_nmi_enter();
+
 	nmi_enter();
 	nmi_count(cpu)++;
 
@@ -190,4 +200,6 @@ BUILD_TRAP_HANDLER(nmi)
 	}
 
 	nmi_exit();
+
+	arch_ftrace_nmi_exit();
 }
--- a/include/linux/ftrace_irq.h
+++ b/include/linux/ftrace_irq.h
@@ -2,15 +2,6 @@
 #ifndef _LINUX_FTRACE_IRQ_H
 #define _LINUX_FTRACE_IRQ_H
 
-
-#ifdef CONFIG_FTRACE_NMI_ENTER
-extern void arch_ftrace_nmi_enter(void);
-extern void arch_ftrace_nmi_exit(void);
-#else
-static inline void arch_ftrace_nmi_enter(void) { }
-static inline void arch_ftrace_nmi_exit(void) { }
-#endif
-
 #ifdef CONFIG_HWLAT_TRACER
 extern bool trace_hwlat_callback_enabled;
 extern void trace_hwlat_callback(bool enter);
@@ -22,12 +13,10 @@ static inline void ftrace_nmi_enter(void
 	if (trace_hwlat_callback_enabled)
 		trace_hwlat_callback(true);
 #endif
-	arch_ftrace_nmi_enter();
 }
 
 static inline void ftrace_nmi_exit(void)
 {
-	arch_ftrace_nmi_exit();
 #ifdef CONFIG_HWLAT_TRACER
 	if (trace_hwlat_callback_enabled)
 		trace_hwlat_callback(false);
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -10,11 +10,6 @@ config USER_STACKTRACE_SUPPORT
 config NOP_TRACER
 	bool
 
-config HAVE_FTRACE_NMI_ENTER
-	bool
-	help
-	  See Documentation/trace/ftrace-design.rst
-
 config HAVE_FUNCTION_TRACER
 	bool
 	help
@@ -72,11 +67,6 @@ config RING_BUFFER
 	select TRACE_CLOCK
 	select IRQ_WORK
 
-config FTRACE_NMI_ENTER
-       bool
-       depends on HAVE_FTRACE_NMI_ENTER
-       default y
-
 config EVENT_TRACING
 	select CONTEXT_SWITCH_TRACER
 	select GLOB

From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next powerpc allmodconfig
Date: Thu, 3 Jul 2008 09:22:00 +0200
Message-ID: <20080703072200.GA5648@elte.hu>
References: <20080702235122.7aca2f5a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:49229 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937000AbYGCHW0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 3 Jul 2008 03:22:26 -0400
Content-Disposition: inline
In-Reply-To: <20080702235122.7aca2f5a.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Arjan van de Ven <arjan@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org


* Andrew Morton <akpm@linux-foundation.org> wrote:

> ERROR: ".save_stack_trace" [tests/backtracetest.ko] undefined!

thanks. This will affect every architecture that implements stacktrace. 
The fix is below.

	Ingo

--------------------->
commit 7b4c9505f2fd82b117dd015b561f723b9a5dab79
Author: Ingo Molnar <mingo@elte.hu>
Date:   Thu Jul 3 09:17:55 2008 +0200

    stacktrace: export save_stack_trace[_tsk]
    
    Andrew Morton reported this against linux-next:
    
    ERROR: ".save_stack_trace" [tests/backtracetest.ko] undefined!
    
    Reported-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index ae31deb..6b3ffde 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -66,4 +66,5 @@ void save_stack_trace(struct stack_trace *trace)
 
 	walk_stackframe(fp, base, base + THREAD_SIZE, save_trace, &data);
 }
+EXPORT_SYMBOL_GPL(save_stack_trace);
 #endif
diff --git a/arch/avr32/kernel/stacktrace.c b/arch/avr32/kernel/stacktrace.c
index 9a68190..f4bdb44 100644
--- a/arch/avr32/kernel/stacktrace.c
+++ b/arch/avr32/kernel/stacktrace.c
@@ -51,3 +51,4 @@ void save_stack_trace(struct stack_trace *trace)
 		fp = frame->fp;
 	}
 }
+EXPORT_SYMBOL_GPL(save_stack_trace);
diff --git a/arch/mips/kernel/stacktrace.c b/arch/mips/kernel/stacktrace.c
index ebd9db8..5eb4681 100644
--- a/arch/mips/kernel/stacktrace.c
+++ b/arch/mips/kernel/stacktrace.c
@@ -73,3 +73,4 @@ void save_stack_trace(struct stack_trace *trace)
 	prepare_frametrace(regs);
 	save_context_stack(trace, regs);
 }
+EXPORT_SYMBOL_GPL(save_stack_trace);
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 9629440..9861f17 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -44,3 +44,4 @@ void save_stack_trace(struct stack_trace *trace)
 		sp = newsp;
 	}
 }
+EXPORT_SYMBOL_GPL(save_stack_trace);
diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 85e46a5..57571f1 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -81,6 +81,7 @@ void save_stack_trace(struct stack_trace *trace)
 			   S390_lowcore.thread_info,
 			   S390_lowcore.thread_info + THREAD_SIZE, 1);
 }
+EXPORT_SYMBOL_GPL(save_stack_trace);
 
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
@@ -93,3 +94,4 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
+EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
diff --git a/arch/sh/kernel/stacktrace.c b/arch/sh/kernel/stacktrace.c
index d41e561..1b2ae35 100644
--- a/arch/sh/kernel/stacktrace.c
+++ b/arch/sh/kernel/stacktrace.c
@@ -34,3 +34,4 @@ void save_stack_trace(struct stack_trace *trace)
 		}
 	}
 }
+EXPORT_SYMBOL_GPL(save_stack_trace);
diff --git a/arch/sparc64/kernel/stacktrace.c b/arch/sparc64/kernel/stacktrace.c
index c73ce3f..49656ed 100644
--- a/arch/sparc64/kernel/stacktrace.c
+++ b/arch/sparc64/kernel/stacktrace.c
@@ -47,3 +47,4 @@ void save_stack_trace(struct stack_trace *trace)
 			trace->entries[trace->nr_entries++] = pc;
 	} while (trace->nr_entries < trace->max_entries);
 }
+EXPORT_SYMBOL_GPL(save_stack_trace);

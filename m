Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:34540 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbfJVM5U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Oct 2019 08:57:20 -0400
Date: Tue, 22 Oct 2019 14:57:16 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH -v2] x86/ftrace: Get rid of function_hook
Message-ID: <20191022125716.GF31700@zn.tnic>
References: <20191018124800.0a7006bb@gandalf.local.home>
 <20191018124956.764ac42e@gandalf.local.home>
 <20191018171354.GB20368@zn.tnic>
 <20191018133735.77e90e36@gandalf.local.home>
 <20191018194856.GC20368@zn.tnic>
 <20191018163125.346e078d@gandalf.local.home>
 <20191019073424.GA27353@zn.tnic>
 <20191021141038.GC7014@zn.tnic>
 <f8dcb3dd-a8a6-5326-ea4a-bea2eb1c4651@suse.cz>
 <20191022125615.GE31700@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191022125615.GE31700@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: Steven Rostedt <rostedt@goodmis.org>, tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>, linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
Message-ID: <20191022125716.kVQkeCMNUKQpOZ_WXwMvcpZQuy9oN85xAor9bxSXYyw@z>

From: Borislav Petkov <bp@suse.de>

History lesson courtesy of Steve:

"When ftrace first was introduced to the kernel, it used gcc's
mcount profiling mechanism. The mcount mechanism would add a call to
"mcount" at the start of every function but after the stack frame was
set up. Later, in gcc 4.6, gcc introduced -mfentry, that would create a
call to "__fentry__" instead of "mcount", before the stack frame was
set up. In order to handle both cases, ftrace defined a macro
"function_hook" that would be either "mcount" or "__fentry__" depending
on which one was being used.

The Linux kernel no longer supports the "mcount" method, thus there's
no reason to keep the "function_hook" define around. Simply use
"__fentry__", as there is no ambiguity to the name anymore."

Drop it everywhere.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
---
 Documentation/asm-annotations.rst |  4 ++--
 arch/x86/kernel/ftrace_32.S       |  8 +++-----
 arch/x86/kernel/ftrace_64.S       | 13 ++++++-------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index 29ccd6e61fe5..f55c2bb74d00 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -117,9 +117,9 @@ This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
   So in most cases, developers should write something like in the following
   example, having some asm instructions in between the macros, of course::
 
-    SYM_FUNC_START(function_hook)
+    SYM_FUNC_START(memset)
         ... asm insns ...
-    SYM_FUNC_END(function_hook)
+    SYM_FUNC_END(memset)
 
   In fact, this kind of annotation corresponds to the now deprecated ``ENTRY``
   and ``ENDPROC`` macros.
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 8ed1f5d371f0..e8a9f8370112 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -12,18 +12,16 @@
 #include <asm/frame.h>
 #include <asm/asm-offsets.h>
 
-# define function_hook	__fentry__
-EXPORT_SYMBOL(__fentry__)
-
 #ifdef CONFIG_FRAME_POINTER
 # define MCOUNT_FRAME			1	/* using frame = true  */
 #else
 # define MCOUNT_FRAME			0	/* using frame = false */
 #endif
 
-SYM_FUNC_START(function_hook)
+SYM_FUNC_START(__fentry__)
 	ret
-SYM_FUNC_END(function_hook)
+SYM_FUNC_END(__fentry__)
+EXPORT_SYMBOL(__fentry__)
 
 SYM_CODE_START(ftrace_caller)
 
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 69c8d1b9119e..6e8961ca3605 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -14,9 +14,6 @@
 	.code64
 	.section .entry.text, "ax"
 
-# define function_hook	__fentry__
-EXPORT_SYMBOL(__fentry__)
-
 #ifdef CONFIG_FRAME_POINTER
 /* Save parent and function stack frames (rip and rbp) */
 #  define MCOUNT_FRAME_SIZE	(8+16*2)
@@ -132,9 +129,10 @@ EXPORT_SYMBOL(__fentry__)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-SYM_FUNC_START(function_hook)
+SYM_FUNC_START(__fentry__)
 	retq
-SYM_FUNC_END(function_hook)
+SYM_FUNC_END(__fentry__)
+EXPORT_SYMBOL(__fentry__)
 
 SYM_FUNC_START(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
@@ -248,7 +246,7 @@ SYM_FUNC_END(ftrace_regs_caller)
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
-SYM_FUNC_START(function_hook)
+SYM_FUNC_START(__fentry__)
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
 
@@ -279,7 +277,8 @@ trace:
 	restore_mcount_regs
 
 	jmp fgraph_trace
-SYM_FUNC_END(function_hook)
+SYM_FUNC_END(__fentry__)
+EXPORT_SYMBOL(__fentry__)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

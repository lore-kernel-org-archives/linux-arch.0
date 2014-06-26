From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFA][PATCH 17/27] tile: ftrace: Remove check of obsolete variable function_trace_stop
Date: Thu, 26 Jun 2014 12:52:38 -0400
Message-ID: <20140626165852.012558348@goodmis.org>
References: <20140626165221.736847419@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:61228 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758023AbaFZRAH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2014 13:00:07 -0400
Content-Disposition: inline; filename=0017-tile-ftrace-Remove-check-of-obsolete-variable-functi.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>, Chris Metcalf <cmetcalf@tilera.com>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Nothing sets function_trace_stop to disable function tracing anymore.
Remove the check for it in the arch code.

[ Please test this on your arch ]

Cc: Chris Metcalf <cmetcalf@tilera.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/tile/Kconfig            |  1 -
 arch/tile/kernel/mcount_64.S | 18 ------------------
 2 files changed, 19 deletions(-)

diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index 4f3006b600e3..7fcd492adbfc 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -128,7 +128,6 @@ config TILEGX
 	select SPARSE_IRQ
 	select GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
 	select HAVE_FUNCTION_TRACER
-	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
diff --git a/arch/tile/kernel/mcount_64.S b/arch/tile/kernel/mcount_64.S
index 70d7bb0c4d8f..3c2b8d5e1d1a 100644
--- a/arch/tile/kernel/mcount_64.S
+++ b/arch/tile/kernel/mcount_64.S
@@ -77,15 +77,6 @@ STD_ENDPROC(__mcount)
 
 	.align	64
 STD_ENTRY(ftrace_caller)
-	moveli	r11, hw2_last(function_trace_stop)
-	{ shl16insli	r11, r11, hw1(function_trace_stop); move r12, lr }
-	{ shl16insli	r11, r11, hw0(function_trace_stop); move lr, r10 }
-	ld	r11, r11
-	beqz	r11, 1f
-	jrp	r12
-
-1:
-	{ move	r10, lr; move	lr, r12 }
 	MCOUNT_SAVE_REGS
 
 	/* arg1: self return address */
@@ -119,15 +110,6 @@ STD_ENDPROC(ftrace_caller)
 
 	.align	64
 STD_ENTRY(__mcount)
-	moveli	r11, hw2_last(function_trace_stop)
-	{ shl16insli	r11, r11, hw1(function_trace_stop); move r12, lr }
-	{ shl16insli	r11, r11, hw0(function_trace_stop); move lr, r10 }
-	ld	r11, r11
-	beqz	r11, 1f
-	jrp	r12
-
-1:
-	{ move	r10, lr; move	lr, r12 }
 	{
 	 moveli	r11, hw2_last(ftrace_trace_function)
 	 moveli	r13, hw2_last(ftrace_stub)
-- 
2.0.0

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:46509 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758041AbaFZRGh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2014 13:06:37 -0400
Message-ID: <20140626165852.497955187@goodmis.org>
Date: Thu, 26 Jun 2014 12:52:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFA][PATCH 20/27] parisc: ftrace: Remove check of obsolete variable function_trace_stop
References: <20140626165221.736847419@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0020-parisc-ftrace-Remove-check-of-obsolete-variable-func.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>, Helge Deller <deller@gmx.de>, Kyle McMartin <kyle@mcmartin.ca>
Message-ID: <20140626165241.Zaxvv7M6ersnfCvTajp6gFnP-1tMKKrdbQapGS8dfUc@z>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

Nothing sets function_trace_stop to disable function tracing anymore.
Remove the check for it in the arch code.

Cc: Helge Deller <deller@gmx.de>
Cc: Kyle McMartin <kyle@mcmartin.ca>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/parisc/Kconfig         | 1 -
 arch/parisc/kernel/ftrace.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 108d48e652af..6e75e2030927 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -6,7 +6,6 @@ config PARISC
 	select HAVE_OPROFILE
 	select HAVE_FUNCTION_TRACER if 64BIT
 	select HAVE_FUNCTION_GRAPH_TRACER if 64BIT
-	select HAVE_FUNCTION_TRACE_MCOUNT_TEST if 64BIT
 	select ARCH_WANT_FRAME_POINTERS
 	select RTC_CLASS
 	select RTC_DRV_GENERIC
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 5512ab32c5e0..559d400f9385 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -155,9 +155,6 @@ void ftrace_function_trampoline(unsigned long parent,
 {
 	extern ftrace_func_t ftrace_trace_function;
 
-	if (function_trace_stop)
-		return;
-
 	if (ftrace_trace_function != ftrace_stub) {
 		ftrace_trace_function(parent, self_addr);
 		return;
-- 
2.0.0



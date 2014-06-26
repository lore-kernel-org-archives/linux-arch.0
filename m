Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:56938 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758022AbaFZRAH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2014 13:00:07 -0400
Message-ID: <20140626165851.208049368@goodmis.org>
Date: Thu, 26 Jun 2014 12:52:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFA][PATCH 14/27] ftrace: Remove function_trace_stop check from list func
References: <20140626165221.736847419@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0014-ftrace-Remove-function_trace_stop-check-from-list-fu.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>
Message-ID: <20140626165235.oJ31xlz0S6mKXbtp2VULXvkSCBXFdwtMnybQX0VemKM@z>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

function_trace_stop is no longer used to stop function tracing.
Remove the check from __ftrace_ops_list_func().

Also, call FTRACE_WARN_ON() instead of setting function_trace_stop
if a ops has no func to call.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1e4e9bbb8dfa..34994885bb1d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4692,9 +4692,6 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *op;
 	int bit;
 
-	if (function_trace_stop)
-		return;
-
 	bit = trace_test_and_set_recursion(TRACE_LIST_START, TRACE_LIST_MAX);
 	if (bit < 0)
 		return;
@@ -4706,9 +4703,8 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 	preempt_disable_notrace();
 	do_for_each_ftrace_op(op, ftrace_ops_list) {
 		if (ftrace_ops_test(op, ip, regs)) {
-			if (WARN_ON(!op->func)) {
-				function_trace_stop = 1;
-				printk("op=%p %pS\n", op, op);
+			if (FTRACE_WARN_ON(!op->func)) {
+				pr_warn("op=%p %pS\n", op, op);
 				goto out;
 			}
 			op->func(ip, parent_ip, op, regs);
-- 
2.0.0



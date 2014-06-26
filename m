From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFA][PATCH 05/27] ftrace/x86: Add call to ftrace_graph_is_dead() in function graph code
Date: Thu, 26 Jun 2014 12:52:26 -0400
Message-ID: <20140626165848.832117370@goodmis.org>
References: <20140626165221.736847419@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:46509 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757657AbaFZRGg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2014 13:06:36 -0400
Content-Disposition: inline; filename=0005-ftrace-x86-Add-call-to-ftrace_graph_is_dead-in-funct.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

ftrace_stop() is going away as it disables parts of function tracing
that affects users that should not be affected. But ftrace_graph_stop()
is built on ftrace_stop(). Here's another example of killing all of
function tracing because something went wrong with function graph
tracing.

Instead of disabling all users of function tracing on function graph
error, disable only function graph tracing. To do this, the arch code
must call ftrace_graph_is_dead() before it implements function graph.

Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index cbc4a91b131e..3386dc9aa333 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -703,6 +703,9 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	unsigned long return_hooker = (unsigned long)
 				&return_to_handler;
 
+	if (unlikely(ftrace_graph_is_dead()))
+		return;
+
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-- 
2.0.0

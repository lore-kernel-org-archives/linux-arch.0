From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFA][PATCH 09/27] powerpc/ftrace: Add call to ftrace_graph_is_dead() in function graph
 code
Date: Thu, 26 Jun 2014 12:52:30 -0400
Message-ID: <20140626165850.107467021@goodmis.org>
References: <20140626165221.736847419@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:30172 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757372AbaFZQ6w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2014 12:58:52 -0400
Content-Disposition: inline; filename=0009-powerpc-ftrace-Add-call-to-ftrace_graph_is_dead-in-f.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

ftrace_stop() is going away as it disables parts of function tracing
that affects users that should not be affected. But ftrace_graph_stop()
is built on ftrace_stop(). Here's another example of killing all of
function tracing because something went wrong with function graph
tracing.

Instead of disabling all users of function tracing on function graph
error, disable only function graph tracing. To do this, the arch code
must call ftrace_graph_is_dead() before it implements function graph.

Cc: Anton Blanchard <anton@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/kernel/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index f202d0731b06..f8c0ce5523a5 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -527,6 +527,9 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 
+	if (unlikely(ftrace_graph_is_dead()))
+		return;
+
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
-- 
2.0.0

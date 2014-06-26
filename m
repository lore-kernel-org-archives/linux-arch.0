From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFA][PATCH 11/27] ftrace-graph: Remove usage of ftrace_stop() in ftrace_graph_stop()
Date: Thu, 26 Jun 2014 12:52:32 -0400
Message-ID: <20140626165850.468278492@goodmis.org>
References: <20140626165221.736847419@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0011-ftrace-graph-Remove-usage-of-ftrace_stop-in-ftrace_g.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiri Kosina <jkosina@suse.cz>, Josh Poimboeuf <notifications@github.com>, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: linux-arch.vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

All archs now use ftrace_graph_is_dead() to stop function graph
tracing. Remove the usage of ftrace_stop() as that is no longer
needed.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 3604690be70b..2c944e6c4a9d 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -40,11 +40,6 @@ bool ftrace_graph_is_dead(void)
 void ftrace_graph_stop(void)
 {
 	kill_ftrace_graph = true;
-	/*
-	 * ftrace_stop() will be removed when all archs are updated to
-	 * use ftrace_graph_is_dead()
-	 */
-	ftrace_stop();
 }
 
 /* When set, irq functions will be ignored */
-- 
2.0.0

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [for-next][PATCH 3/7] ftrace: Reduce size of function graph entries
Date: Sat, 16 Jul 2016 03:16:20 -0400
Message-ID: <20160716071647.151605569@goodmis.org>
References: <20160716071617.711980454@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-ftrace-Reduce-size-of-function-graph-entries.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-arch.vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Currently ftrace_graph_ent{,_entry} and ftrace_graph_ret{,_entry} struct
can have padding bytes at the end due to alignment in 64-bit data type.
As these data are recorded so frequently, those paddings waste
non-negligible space.  As the ring buffer maintains alignment properly
for each architecture, just to remove the extra padding using 'packed'
attribute.

  ftrace_graph_ent_entry:  24 -> 20
  ftrace_graph_ret_entry:  48 -> 44

Also I moved the 'overrun' field in struct ftrace_graph_ret to minimize
the padding in the middle.

Tested on x86_64 only.

Link: http://lkml.kernel.org/r/1467197808-13578-1-git-send-email-namhyung@kernel.org

Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/ftrace.h       | 12 ++++++++----
 kernel/trace/trace.h         | 11 +++++++++++
 kernel/trace/trace_entries.h |  4 ++--
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 66a36a815f0a..7d565afe35d2 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -754,23 +754,27 @@ static inline void ftrace_init(void) { }
 
 /*
  * Structure that defines an entry function trace.
+ * It's already packed but the attribute "packed" is needed
+ * to remove extra padding at the end.
  */
 struct ftrace_graph_ent {
 	unsigned long func; /* Current function */
 	int depth;
-};
+} __packed;
 
 /*
  * Structure that defines a return function trace.
+ * It's already packed but the attribute "packed" is needed
+ * to remove extra padding at the end.
  */
 struct ftrace_graph_ret {
 	unsigned long func; /* Current function */
-	unsigned long long calltime;
-	unsigned long long rettime;
 	/* Number of functions that overran the depth limit for current task */
 	unsigned long overrun;
+	unsigned long long calltime;
+	unsigned long long rettime;
 	int depth;
-};
+} __packed;
 
 /* Type of the callback handlers for tracing function graph*/
 typedef void (*trace_func_graph_ret_t)(struct ftrace_graph_ret *); /* return */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c1de3f493cd3..f783df416726 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -80,6 +80,12 @@ enum trace_type {
 	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print), \
 		     filter)
 
+#undef FTRACE_ENTRY_PACKED
+#define FTRACE_ENTRY_PACKED(name, struct_name, id, tstruct, print,	\
+			    filter)					\
+	FTRACE_ENTRY(name, struct_name, id, PARAMS(tstruct), PARAMS(print), \
+		     filter) __packed
+
 #include "trace_entries.h"
 
 /*
@@ -1625,6 +1631,11 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
 #define FTRACE_ENTRY_DUP(call, struct_name, id, tstruct, print, filter)	\
 	FTRACE_ENTRY(call, struct_name, id, PARAMS(tstruct), PARAMS(print), \
 		     filter)
+#undef FTRACE_ENTRY_PACKED
+#define FTRACE_ENTRY_PACKED(call, struct_name, id, tstruct, print, filter) \
+	FTRACE_ENTRY(call, struct_name, id, PARAMS(tstruct), PARAMS(print), \
+		     filter)
+
 #include "trace_entries.h"
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_FUNCTION_TRACER)
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index ee7b94a4810a..5c30efcda5e6 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -72,7 +72,7 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
 );
 
 /* Function call entry */
-FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
+FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
 
 	TRACE_GRAPH_ENT,
 
@@ -88,7 +88,7 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 );
 
 /* Function return entry */
-FTRACE_ENTRY(funcgraph_exit, ftrace_graph_ret_entry,
+FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	TRACE_GRAPH_RET,
 
-- 
2.8.1

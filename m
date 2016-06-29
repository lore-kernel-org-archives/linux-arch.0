From: Namhyung Kim <namhyung@kernel.org>
Subject: [RFC/PATCH v3] ftrace: Reduce size of function graph entries
Date: Wed, 29 Jun 2016 19:56:48 +0900
Message-ID: <1467197808-13578-1-git-send-email-namhyung@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34461 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcF2K5f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2016 06:57:35 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

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

Cc: linux-arch@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/ftrace.h       | 12 ++++++++----
 kernel/trace/trace.h         | 11 +++++++++++
 kernel/trace/trace_entries.h |  4 ++--
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index dea12a6e413b..68f01226b7ca 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -753,23 +753,27 @@ static inline void ftrace_init(void) { }
 
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
index 5167c366d6b7..d0998494332e 100644
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
@@ -1600,6 +1606,11 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled);
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
2.8.0

From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 03/12] trace: rename struct module entry for trace enums
Date: Wed, 31 May 2017 16:56:44 -0500
Message-ID: <20170531215653.3240-4-jeremy.linton@arm.com>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531215653.3240-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org
List-Id: linux-arch.vger.kernel.org

Each module has a list of enum's its contributing to the
enum map, rename that entry to reflect its use by more than
enums.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/linux/module.h | 4 ++--
 kernel/module.c        | 6 +++---
 kernel/trace/trace.c   | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 46b4804..8eb9a1e 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -442,8 +442,8 @@ struct module {
 #ifdef CONFIG_EVENT_TRACING
 	struct trace_event_call **trace_events;
 	unsigned int num_trace_events;
-	struct trace_eval_map **trace_enums;
-	unsigned int num_trace_enums;
+	struct trace_eval_map **trace_evals;
+	unsigned int num_trace_evals;
 #endif
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 	unsigned int num_ftrace_callsites;
diff --git a/kernel/module.c b/kernel/module.c
index 9ec4713..df1c4a9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3077,9 +3077,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->trace_events = section_objs(info, "_ftrace_events",
 					 sizeof(*mod->trace_events),
 					 &mod->num_trace_events);
-	mod->trace_enums = section_objs(info, "_ftrace_eval_map",
-					sizeof(*mod->trace_enums),
-					&mod->num_trace_enums);
+	mod->trace_evals = section_objs(info, "_ftrace_eval_map",
+					sizeof(*mod->trace_evals),
+					&mod->num_trace_evals);
 #endif
 #ifdef CONFIG_TRACING
 	mod->trace_bprintk_fmt_start = section_objs(info, "__trace_printk_fmt",
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f82764b..85f0e3c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7718,7 +7718,7 @@ static void __init trace_enum_init(void)
 #ifdef CONFIG_MODULES
 static void trace_module_add_enums(struct module *mod)
 {
-	if (!mod->num_trace_enums)
+	if (!mod->num_trace_evals)
 		return;
 
 	/*
@@ -7728,7 +7728,7 @@ static void trace_module_add_enums(struct module *mod)
 	if (trace_module_has_bad_taint(mod))
 		return;
 
-	trace_insert_enum_map(mod, mod->trace_enums, mod->num_trace_enums);
+	trace_insert_enum_map(mod, mod->trace_evals, mod->num_trace_evals);
 }
 
 #ifdef CONFIG_TRACE_ENUM_MAP_FILE
@@ -7737,7 +7737,7 @@ static void trace_module_remove_enums(struct module *mod)
 	union trace_enum_map_item *map;
 	union trace_enum_map_item **last = &trace_enum_maps;
 
-	if (!mod->num_trace_enums)
+	if (!mod->num_trace_evals)
 		return;
 
 	mutex_lock(&trace_enum_mutex);
-- 
2.9.4

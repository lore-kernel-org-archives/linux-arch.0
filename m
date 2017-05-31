From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 07/12] trace: rename enum_map functions
Date: Wed, 31 May 2017 16:56:48 -0500
Message-ID: <20170531215653.3240-8-jeremy.linton@arm.com>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531215653.3240-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org
List-Id: linux-arch.vger.kernel.org

Rename the core trace enum routines to use eval, to
reflect their use by more than just enum to value mapping.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 kernel/trace/trace.c        | 74 ++++++++++++++++++++++-----------------------
 kernel/trace/trace.h        |  4 +--
 kernel/trace/trace_events.c |  2 +-
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5eda252..676c808 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -145,7 +145,7 @@ static DEFINE_MUTEX(trace_eval_mutex);
  * one at the beginning, and one at the end. The beginning item contains
  * the count of the saved maps (head.length), and the module they
  * belong to if not built in (head.mod). The ending item contains a
- * pointer to the next array of saved enum_map items.
+ * pointer to the next array of saved enum_eval/enum_map items.
  */
 union trace_eval_map_item {
 	struct trace_eval_map		map;
@@ -1141,9 +1141,9 @@ unsigned long nsecs_to_usecs(unsigned long nsecs)
 
 /*
  * TRACE_FLAGS is defined as a tuple matching bit masks with strings.
- * It uses C(a, b) where 'a' is the enum name and 'b' is the string that
+ * It uses C(a, b) where 'a' is the eval (enum) name and 'b' is the string that
  * matches it. By defining "C(a, b) b", TRACE_FLAGS becomes a list
- * of strings in the order that the enums were defined.
+ * of strings in the order that the evals (enum) were defined.
  */
 #undef C
 #define C(a, b) b
@@ -4719,7 +4719,7 @@ static const struct file_operations tracing_saved_cmdlines_size_fops = {
 
 #ifdef CONFIG_TRACE_ENUM_MAP_FILE
 static union trace_eval_map_item *
-update_enum_map(union trace_eval_map_item *ptr)
+update_eval_map(union trace_eval_map_item *ptr)
 {
 	if (!ptr->map.eval_string) {
 		if (ptr->tail.next) {
@@ -4732,7 +4732,7 @@ update_enum_map(union trace_eval_map_item *ptr)
 	return ptr;
 }
 
-static void *enum_map_next(struct seq_file *m, void *v, loff_t *pos)
+static void *eval_map_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	union trace_eval_map_item *ptr = v;
 
@@ -4740,7 +4740,7 @@ static void *enum_map_next(struct seq_file *m, void *v, loff_t *pos)
 	 * Paranoid! If ptr points to end, we don't want to increment past it.
 	 * This really should never happen.
 	 */
-	ptr = update_enum_map(ptr);
+	ptr = update_eval_map(ptr);
 	if (WARN_ON_ONCE(!ptr))
 		return NULL;
 
@@ -4748,12 +4748,12 @@ static void *enum_map_next(struct seq_file *m, void *v, loff_t *pos)
 
 	(*pos)++;
 
-	ptr = update_enum_map(ptr);
+	ptr = update_eval_map(ptr);
 
 	return ptr;
 }
 
-static void *enum_map_start(struct seq_file *m, loff_t *pos)
+static void *eval_map_start(struct seq_file *m, loff_t *pos)
 {
 	union trace_eval_map_item *v;
 	loff_t l = 0;
@@ -4765,18 +4765,18 @@ static void *enum_map_start(struct seq_file *m, loff_t *pos)
 		v++;
 
 	while (v && l < *pos) {
-		v = enum_map_next(m, v, &l);
+		v = eval_map_next(m, v, &l);
 	}
 
 	return v;
 }
 
-static void enum_map_stop(struct seq_file *m, void *v)
+static void eval_map_stop(struct seq_file *m, void *v)
 {
 	mutex_unlock(&trace_eval_mutex);
 }
 
-static int enum_map_show(struct seq_file *m, void *v)
+static int eval_map_show(struct seq_file *m, void *v)
 {
 	union trace_eval_map_item *ptr = v;
 
@@ -4787,23 +4787,23 @@ static int enum_map_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static const struct seq_operations tracing_enum_map_seq_ops = {
-	.start		= enum_map_start,
-	.next		= enum_map_next,
-	.stop		= enum_map_stop,
-	.show		= enum_map_show,
+static const struct seq_operations tracing_eval_map_seq_ops = {
+	.start		= eval_map_start,
+	.next		= eval_map_next,
+	.stop		= eval_map_stop,
+	.show		= eval_map_show,
 };
 
-static int tracing_enum_map_open(struct inode *inode, struct file *filp)
+static int tracing_eval_map_open(struct inode *inode, struct file *filp)
 {
 	if (tracing_disabled)
 		return -ENODEV;
 
-	return seq_open(filp, &tracing_enum_map_seq_ops);
+	return seq_open(filp, &tracing_eval_map_seq_ops);
 }
 
-static const struct file_operations tracing_enum_map_fops = {
-	.open		= tracing_enum_map_open,
+static const struct file_operations tracing_eval_map_fops = {
+	.open		= tracing_eval_map_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
@@ -4817,7 +4817,7 @@ trace_eval_jmp_to_tail(union trace_eval_map_item *ptr)
 }
 
 static void
-trace_insert_enum_map_file(struct module *mod, struct trace_eval_map **start,
+trace_insert_eval_map_file(struct module *mod, struct trace_eval_map **start,
 			   int len)
 {
 	struct trace_eval_map **stop;
@@ -4834,7 +4834,7 @@ trace_insert_enum_map_file(struct module *mod, struct trace_eval_map **start,
 	 */
 	map_array = kmalloc(sizeof(*map_array) * (len + 2), GFP_KERNEL);
 	if (!map_array) {
-		pr_warn("Unable to allocate trace enum mapping\n");
+		pr_warn("Unable to allocate trace eval mapping\n");
 		return;
 	}
 
@@ -4866,19 +4866,19 @@ trace_insert_enum_map_file(struct module *mod, struct trace_eval_map **start,
 	mutex_unlock(&trace_eval_mutex);
 }
 
-static void trace_create_enum_file(struct dentry *d_tracer)
+static void trace_create_eval_file(struct dentry *d_tracer)
 {
 	trace_create_file("enum_map", 0444, d_tracer,
-			  NULL, &tracing_enum_map_fops);
+			  NULL, &tracing_eval_map_fops);
 }
 
 #else /* CONFIG_TRACE_ENUM_MAP_FILE */
-static inline void trace_create_enum_file(struct dentry *d_tracer) { }
-static inline void trace_insert_enum_map_file(struct module *mod,
+static inline void trace_create_eval_file(struct dentry *d_tracer) { }
+static inline void trace_insert_eval_map_file(struct module *mod,
 			      struct trace_eval_map **start, int len) { }
 #endif /* !CONFIG_TRACE_ENUM_MAP_FILE */
 
-static void trace_insert_enum_map(struct module *mod,
+static void trace_insert_eval_map(struct module *mod,
 				  struct trace_eval_map **start, int len)
 {
 	struct trace_eval_map **map;
@@ -4888,9 +4888,9 @@ static void trace_insert_enum_map(struct module *mod,
 
 	map = start;
 
-	trace_event_enum_update(map, len);
+	trace_event_eval_update(map, len);
 
-	trace_insert_enum_map_file(mod, start, len);
+	trace_insert_eval_map_file(mod, start, len);
 }
 
 static ssize_t
@@ -7712,11 +7712,11 @@ static void __init trace_eval_init(void)
 	int len;
 
 	len = __stop_ftrace_eval_maps - __start_ftrace_eval_maps;
-	trace_insert_enum_map(NULL, __start_ftrace_eval_maps, len);
+	trace_insert_eval_map(NULL, __start_ftrace_eval_maps, len);
 }
 
 #ifdef CONFIG_MODULES
-static void trace_module_add_enums(struct module *mod)
+static void trace_module_add_evals(struct module *mod)
 {
 	if (!mod->num_trace_evals)
 		return;
@@ -7728,11 +7728,11 @@ static void trace_module_add_enums(struct module *mod)
 	if (trace_module_has_bad_taint(mod))
 		return;
 
-	trace_insert_enum_map(mod, mod->trace_evals, mod->num_trace_evals);
+	trace_insert_eval_map(mod, mod->trace_evals, mod->num_trace_evals);
 }
 
 #ifdef CONFIG_TRACE_ENUM_MAP_FILE
-static void trace_module_remove_enums(struct module *mod)
+static void trace_module_remove_evals(struct module *mod)
 {
 	union trace_eval_map_item *map;
 	union trace_eval_map_item **last = &trace_eval_maps;
@@ -7760,7 +7760,7 @@ static void trace_module_remove_enums(struct module *mod)
 	mutex_unlock(&trace_eval_mutex);
 }
 #else
-static inline void trace_module_remove_enums(struct module *mod) { }
+static inline void trace_module_remove_evals(struct module *mod) { }
 #endif /* CONFIG_TRACE_ENUM_MAP_FILE */
 
 static int trace_module_notify(struct notifier_block *self,
@@ -7770,10 +7770,10 @@ static int trace_module_notify(struct notifier_block *self,
 
 	switch (val) {
 	case MODULE_STATE_COMING:
-		trace_module_add_enums(mod);
+		trace_module_add_evals(mod);
 		break;
 	case MODULE_STATE_GOING:
-		trace_module_remove_enums(mod);
+		trace_module_remove_evals(mod);
 		break;
 	}
 
@@ -7813,7 +7813,7 @@ static __init int tracer_init_tracefs(void)
 
 	trace_eval_init();
 
-	trace_create_enum_file(d_tracer);
+	trace_create_eval_file(d_tracer);
 
 #ifdef CONFIG_MODULES
 	register_module_notifier(&trace_module_nb);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 75d5e27..5f451a6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1768,10 +1768,10 @@ static inline const char *get_syscall_name(int syscall)
 
 #ifdef CONFIG_EVENT_TRACING
 void trace_event_init(void);
-void trace_event_enum_update(struct trace_eval_map **map, int len);
+void trace_event_eval_update(struct trace_eval_map **map, int len);
 #else
 static inline void __init trace_event_init(void) { }
-static inline void trace_event_enum_update(struct trace_eval_map **map, int len) { }
+static inline void trace_event_eval_update(struct trace_eval_map **map, int len) { }
 #endif
 
 extern struct trace_iterator *tracepoint_print_iter;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index cf5b9aa..e6897b0 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2165,7 +2165,7 @@ static void update_event_printk(struct trace_event_call *call,
 	}
 }
 
-void trace_event_enum_update(struct trace_eval_map **map, int len)
+void trace_event_eval_update(struct trace_eval_map **map, int len)
 {
 	struct trace_event_call *call, *p;
 	const char *last_system = NULL;
-- 
2.9.4

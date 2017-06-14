From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 04/13] trace: rename trace enum data structures in trace.c
Date: Wed, 14 Jun 2017 17:27:20 -0500
Message-ID: <20170614222729.16521-5-jeremy.linton@arm.com>
References: <20170614222729.16521-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614222729.16521-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org, clemens@ladisch.de, perex@perex.cz
List-Id: linux-arch.vger.kernel.org

The enum map entries can be exported to userspace
via a sys enum_map file. Rename those functions
and structures to reflect the fact that we are using
them for more than enums.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 kernel/trace/trace.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 85f0e3c..af6ec07 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -122,38 +122,38 @@ int __disable_trace_on_warning;
 
 #ifdef CONFIG_TRACE_ENUM_MAP_FILE
 /* Map of enums to their values, for "enum_map" file */
-struct trace_enum_map_head {
+struct trace_eval_map_head {
 	struct module			*mod;
 	unsigned long			length;
 };
 
-union trace_enum_map_item;
+union trace_eval_map_item;
 
-struct trace_enum_map_tail {
+struct trace_eval_map_tail {
 	/*
 	 * "end" is first and points to NULL as it must be different
 	 * than "mod" or "eval_string"
 	 */
-	union trace_enum_map_item	*next;
+	union trace_eval_map_item	*next;
 	const char			*end;	/* points to NULL */
 };
 
 static DEFINE_MUTEX(trace_enum_mutex);
 
 /*
- * The trace_enum_maps are saved in an array with two extra elements,
+ * The trace_eval_maps are saved in an array with two extra elements,
  * one at the beginning, and one at the end. The beginning item contains
  * the count of the saved maps (head.length), and the module they
  * belong to if not built in (head.mod). The ending item contains a
  * pointer to the next array of saved enum_map items.
  */
-union trace_enum_map_item {
+union trace_eval_map_item {
 	struct trace_eval_map		map;
-	struct trace_enum_map_head	head;
-	struct trace_enum_map_tail	tail;
+	struct trace_eval_map_head	head;
+	struct trace_eval_map_tail	tail;
 };
 
-static union trace_enum_map_item *trace_enum_maps;
+static union trace_eval_map_item *trace_eval_maps;
 #endif /* CONFIG_TRACE_ENUM_MAP_FILE */
 
 static int tracing_set_tracer(struct trace_array *tr, const char *buf);
@@ -4718,8 +4718,8 @@ static const struct file_operations tracing_saved_cmdlines_size_fops = {
 };
 
 #ifdef CONFIG_TRACE_ENUM_MAP_FILE
-static union trace_enum_map_item *
-update_enum_map(union trace_enum_map_item *ptr)
+static union trace_eval_map_item *
+update_enum_map(union trace_eval_map_item *ptr)
 {
 	if (!ptr->map.eval_string) {
 		if (ptr->tail.next) {
@@ -4734,7 +4734,7 @@ update_enum_map(union trace_enum_map_item *ptr)
 
 static void *enum_map_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	union trace_enum_map_item *ptr = v;
+	union trace_eval_map_item *ptr = v;
 
 	/*
 	 * Paranoid! If ptr points to end, we don't want to increment past it.
@@ -4755,12 +4755,12 @@ static void *enum_map_next(struct seq_file *m, void *v, loff_t *pos)
 
 static void *enum_map_start(struct seq_file *m, loff_t *pos)
 {
-	union trace_enum_map_item *v;
+	union trace_eval_map_item *v;
 	loff_t l = 0;
 
 	mutex_lock(&trace_enum_mutex);
 
-	v = trace_enum_maps;
+	v = trace_eval_maps;
 	if (v)
 		v++;
 
@@ -4778,7 +4778,7 @@ static void enum_map_stop(struct seq_file *m, void *v)
 
 static int enum_map_show(struct seq_file *m, void *v)
 {
-	union trace_enum_map_item *ptr = v;
+	union trace_eval_map_item *ptr = v;
 
 	seq_printf(m, "%s %ld (%s)\n",
 		   ptr->map.eval_string, ptr->map.eval_value,
@@ -4809,8 +4809,8 @@ static const struct file_operations tracing_enum_map_fops = {
 	.release	= seq_release,
 };
 
-static inline union trace_enum_map_item *
-trace_enum_jmp_to_tail(union trace_enum_map_item *ptr)
+static inline union trace_eval_map_item *
+trace_enum_jmp_to_tail(union trace_eval_map_item *ptr)
 {
 	/* Return tail of array given the head */
 	return ptr + ptr->head.length + 1;
@@ -4822,13 +4822,13 @@ trace_insert_enum_map_file(struct module *mod, struct trace_eval_map **start,
 {
 	struct trace_eval_map **stop;
 	struct trace_eval_map **map;
-	union trace_enum_map_item *map_array;
-	union trace_enum_map_item *ptr;
+	union trace_eval_map_item *map_array;
+	union trace_eval_map_item *ptr;
 
 	stop = start + len;
 
 	/*
-	 * The trace_enum_maps contains the map plus a head and tail item,
+	 * The trace_eval_maps contains the map plus a head and tail item,
 	 * where the head holds the module and length of array, and the
 	 * tail holds a pointer to the next list.
 	 */
@@ -4840,10 +4840,10 @@ trace_insert_enum_map_file(struct module *mod, struct trace_eval_map **start,
 
 	mutex_lock(&trace_enum_mutex);
 
-	if (!trace_enum_maps)
-		trace_enum_maps = map_array;
+	if (!trace_eval_maps)
+		trace_eval_maps = map_array;
 	else {
-		ptr = trace_enum_maps;
+		ptr = trace_eval_maps;
 		for (;;) {
 			ptr = trace_enum_jmp_to_tail(ptr);
 			if (!ptr->tail.next)
@@ -7734,15 +7734,15 @@ static void trace_module_add_enums(struct module *mod)
 #ifdef CONFIG_TRACE_ENUM_MAP_FILE
 static void trace_module_remove_enums(struct module *mod)
 {
-	union trace_enum_map_item *map;
-	union trace_enum_map_item **last = &trace_enum_maps;
+	union trace_eval_map_item *map;
+	union trace_eval_map_item **last = &trace_eval_maps;
 
 	if (!mod->num_trace_evals)
 		return;
 
 	mutex_lock(&trace_enum_mutex);
 
-	map = trace_enum_maps;
+	map = trace_eval_maps;
 
 	while (map) {
 		if (map->head.mod == mod)
-- 
2.9.4

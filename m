From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 02/13] trace: rename trace_enum_map to trace_eval_map
Date: Wed, 14 Jun 2017 17:27:18 -0500
Message-ID: <20170614222729.16521-3-jeremy.linton@arm.com>
References: <20170614222729.16521-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614222729.16521-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org, clemens@ladisch.de, perex@perex.cz
List-Id: linux-arch.vger.kernel.org

Each enum is loaded into the trace_enum_map, as we
are now using this for more than enums rename it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/linux/module.h       |  2 +-
 include/linux/tracepoint.h   |  6 +++---
 include/trace/trace_events.h |  8 ++++----
 kernel/trace/trace.c         | 24 ++++++++++++------------
 kernel/trace/trace.h         |  4 ++--
 kernel/trace/trace_events.c  | 14 +++++++-------
 6 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 21f5639..46b4804 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -442,7 +442,7 @@ struct module {
 #ifdef CONFIG_EVENT_TRACING
 	struct trace_event_call **trace_events;
 	unsigned int num_trace_events;
-	struct trace_enum_map **trace_enums;
+	struct trace_eval_map **trace_enums;
 	unsigned int num_trace_enums;
 #endif
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index cc48cb2..f7b0f55 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -25,10 +25,10 @@ struct module;
 struct tracepoint;
 struct notifier_block;
 
-struct trace_enum_map {
+struct trace_eval_map {
 	const char		*system;
-	const char		*enum_string;
-	unsigned long		enum_value;
+	const char		*eval_string;
+	unsigned long		eval_value;
 };
 
 #define TRACEPOINT_DEFAULT_PRIO	10
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 4bdd840..49cce5f 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -35,14 +35,14 @@ TRACE_MAKE_SYSTEM_STR();
 
 #undef TRACE_DEFINE_ENUM
 #define TRACE_DEFINE_ENUM(a)				\
-	static struct trace_enum_map __used __initdata	\
+	static struct trace_eval_map __used __initdata	\
 	__##TRACE_SYSTEM##_##a =			\
 	{						\
 		.system = TRACE_SYSTEM_STRING,		\
-		.enum_string = #a,			\
-		.enum_value = a				\
+		.eval_string = #a,			\
+		.eval_value = a				\
 	};						\
-	static struct trace_enum_map __used		\
+	static struct trace_eval_map __used		\
 	__attribute__((section("_ftrace_eval_map")))	\
 	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ce564c2..f82764b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -132,7 +132,7 @@ union trace_enum_map_item;
 struct trace_enum_map_tail {
 	/*
 	 * "end" is first and points to NULL as it must be different
-	 * than "mod" or "enum_string"
+	 * than "mod" or "eval_string"
 	 */
 	union trace_enum_map_item	*next;
 	const char			*end;	/* points to NULL */
@@ -148,7 +148,7 @@ static DEFINE_MUTEX(trace_enum_mutex);
  * pointer to the next array of saved enum_map items.
  */
 union trace_enum_map_item {
-	struct trace_enum_map		map;
+	struct trace_eval_map		map;
 	struct trace_enum_map_head	head;
 	struct trace_enum_map_tail	tail;
 };
@@ -4721,7 +4721,7 @@ static const struct file_operations tracing_saved_cmdlines_size_fops = {
 static union trace_enum_map_item *
 update_enum_map(union trace_enum_map_item *ptr)
 {
-	if (!ptr->map.enum_string) {
+	if (!ptr->map.eval_string) {
 		if (ptr->tail.next) {
 			ptr = ptr->tail.next;
 			/* Set ptr to the next real item (skip head) */
@@ -4781,7 +4781,7 @@ static int enum_map_show(struct seq_file *m, void *v)
 	union trace_enum_map_item *ptr = v;
 
 	seq_printf(m, "%s %ld (%s)\n",
-		   ptr->map.enum_string, ptr->map.enum_value,
+		   ptr->map.eval_string, ptr->map.eval_value,
 		   ptr->map.system);
 
 	return 0;
@@ -4817,11 +4817,11 @@ trace_enum_jmp_to_tail(union trace_enum_map_item *ptr)
 }
 
 static void
-trace_insert_enum_map_file(struct module *mod, struct trace_enum_map **start,
+trace_insert_enum_map_file(struct module *mod, struct trace_eval_map **start,
 			   int len)
 {
-	struct trace_enum_map **stop;
-	struct trace_enum_map **map;
+	struct trace_eval_map **stop;
+	struct trace_eval_map **map;
 	union trace_enum_map_item *map_array;
 	union trace_enum_map_item *ptr;
 
@@ -4875,13 +4875,13 @@ static void trace_create_enum_file(struct dentry *d_tracer)
 #else /* CONFIG_TRACE_ENUM_MAP_FILE */
 static inline void trace_create_enum_file(struct dentry *d_tracer) { }
 static inline void trace_insert_enum_map_file(struct module *mod,
-			      struct trace_enum_map **start, int len) { }
+			      struct trace_eval_map **start, int len) { }
 #endif /* !CONFIG_TRACE_ENUM_MAP_FILE */
 
 static void trace_insert_enum_map(struct module *mod,
-				  struct trace_enum_map **start, int len)
+				  struct trace_eval_map **start, int len)
 {
-	struct trace_enum_map **map;
+	struct trace_eval_map **map;
 
 	if (len <= 0)
 		return;
@@ -7704,8 +7704,8 @@ struct dentry *tracing_init_dentry(void)
 	return NULL;
 }
 
-extern struct trace_enum_map *__start_ftrace_eval_maps[];
-extern struct trace_enum_map *__stop_ftrace_eval_maps[];
+extern struct trace_eval_map *__start_ftrace_eval_maps[];
+extern struct trace_eval_map *__stop_ftrace_eval_maps[];
 
 static void __init trace_enum_init(void)
 {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 291a1bc..75d5e27 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1768,10 +1768,10 @@ static inline const char *get_syscall_name(int syscall)
 
 #ifdef CONFIG_EVENT_TRACING
 void trace_event_init(void);
-void trace_event_enum_update(struct trace_enum_map **map, int len);
+void trace_event_enum_update(struct trace_eval_map **map, int len);
 #else
 static inline void __init trace_event_init(void) { }
-static inline void trace_event_enum_update(struct trace_enum_map **map, int len) { }
+static inline void trace_event_enum_update(struct trace_eval_map **map, int len) { }
 #endif
 
 extern struct trace_iterator *tracepoint_print_iter;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e7973e1..cf5b9aa 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2067,18 +2067,18 @@ __register_event(struct trace_event_call *call, struct module *mod)
 	return 0;
 }
 
-static char *enum_replace(char *ptr, struct trace_enum_map *map, int len)
+static char *enum_replace(char *ptr, struct trace_eval_map *map, int len)
 {
 	int rlen;
 	int elen;
 
 	/* Find the length of the enum value as a string */
-	elen = snprintf(ptr, 0, "%ld", map->enum_value);
+	elen = snprintf(ptr, 0, "%ld", map->eval_value);
 	/* Make sure there's enough room to replace the string with the value */
 	if (len < elen)
 		return NULL;
 
-	snprintf(ptr, elen + 1, "%ld", map->enum_value);
+	snprintf(ptr, elen + 1, "%ld", map->eval_value);
 
 	/* Get the rest of the string of ptr */
 	rlen = strlen(ptr + len);
@@ -2090,11 +2090,11 @@ static char *enum_replace(char *ptr, struct trace_enum_map *map, int len)
 }
 
 static void update_event_printk(struct trace_event_call *call,
-				struct trace_enum_map *map)
+				struct trace_eval_map *map)
 {
 	char *ptr;
 	int quote = 0;
-	int len = strlen(map->enum_string);
+	int len = strlen(map->eval_string);
 
 	for (ptr = call->print_fmt; *ptr; ptr++) {
 		if (*ptr == '\\') {
@@ -2125,7 +2125,7 @@ static void update_event_printk(struct trace_event_call *call,
 			continue;
 		}
 		if (isalpha(*ptr) || *ptr == '_') {
-			if (strncmp(map->enum_string, ptr, len) == 0 &&
+			if (strncmp(map->eval_string, ptr, len) == 0 &&
 			    !isalnum(ptr[len]) && ptr[len] != '_') {
 				ptr = enum_replace(ptr, map, len);
 				/* Hmm, enum string smaller than value */
@@ -2165,7 +2165,7 @@ static void update_event_printk(struct trace_event_call *call,
 	}
 }
 
-void trace_event_enum_update(struct trace_enum_map **map, int len)
+void trace_event_enum_update(struct trace_eval_map **map, int len)
 {
 	struct trace_event_call *call, *p;
 	const char *last_system = NULL;
-- 
2.9.4

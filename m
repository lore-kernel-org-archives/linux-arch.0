From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 06/13] trace: rename trace.c enum functions
Date: Wed, 14 Jun 2017 17:27:22 -0500
Message-ID: <20170614222729.16521-7-jeremy.linton@arm.com>
References: <20170614222729.16521-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614222729.16521-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org, clemens@ladisch.de, perex@perex.cz
List-Id: linux-arch.vger.kernel.org

Rename the init and trace_enum_jmp_to_tail() routines
to reflect their use by more than enumerated types.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 kernel/trace/trace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e1bc56c..5eda252 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4810,7 +4810,7 @@ static const struct file_operations tracing_enum_map_fops = {
 };
 
 static inline union trace_eval_map_item *
-trace_enum_jmp_to_tail(union trace_eval_map_item *ptr)
+trace_eval_jmp_to_tail(union trace_eval_map_item *ptr)
 {
 	/* Return tail of array given the head */
 	return ptr + ptr->head.length + 1;
@@ -4845,7 +4845,7 @@ trace_insert_enum_map_file(struct module *mod, struct trace_eval_map **start,
 	else {
 		ptr = trace_eval_maps;
 		for (;;) {
-			ptr = trace_enum_jmp_to_tail(ptr);
+			ptr = trace_eval_jmp_to_tail(ptr);
 			if (!ptr->tail.next)
 				break;
 			ptr = ptr->tail.next;
@@ -7707,7 +7707,7 @@ struct dentry *tracing_init_dentry(void)
 extern struct trace_eval_map *__start_ftrace_eval_maps[];
 extern struct trace_eval_map *__stop_ftrace_eval_maps[];
 
-static void __init trace_enum_init(void)
+static void __init trace_eval_init(void)
 {
 	int len;
 
@@ -7747,14 +7747,14 @@ static void trace_module_remove_enums(struct module *mod)
 	while (map) {
 		if (map->head.mod == mod)
 			break;
-		map = trace_enum_jmp_to_tail(map);
+		map = trace_eval_jmp_to_tail(map);
 		last = &map->tail.next;
 		map = map->tail.next;
 	}
 	if (!map)
 		goto out;
 
-	*last = trace_enum_jmp_to_tail(map)->tail.next;
+	*last = trace_eval_jmp_to_tail(map)->tail.next;
 	kfree(map);
  out:
 	mutex_unlock(&trace_eval_mutex);
@@ -7811,7 +7811,7 @@ static __init int tracer_init_tracefs(void)
 	trace_create_file("saved_cmdlines_size", 0644, d_tracer,
 			  NULL, &tracing_saved_cmdlines_size_fops);
 
-	trace_enum_init();
+	trace_eval_init();
 
 	trace_create_enum_file(d_tracer);
 
-- 
2.9.4

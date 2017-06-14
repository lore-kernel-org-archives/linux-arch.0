From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 05/13] trace: rename trace_enum_mutex to trace_eval_mutex
Date: Wed, 14 Jun 2017 17:27:21 -0500
Message-ID: <20170614222729.16521-6-jeremy.linton@arm.com>
References: <20170614222729.16521-1-jeremy.linton@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbdFNW1e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jun 2017 18:27:34 -0400
In-Reply-To: <20170614222729.16521-1-jeremy.linton@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org, clemens@ladisch.de, perex@perex.cz

There is a lock protecting the trace_enum_map, rename
it to reflect the use by more than enums.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 kernel/trace/trace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index af6ec07..e1bc56c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -138,7 +138,7 @@ struct trace_eval_map_tail {
 	const char			*end;	/* points to NULL */
 };
 
-static DEFINE_MUTEX(trace_enum_mutex);
+static DEFINE_MUTEX(trace_eval_mutex);
 
 /*
  * The trace_eval_maps are saved in an array with two extra elements,
@@ -4758,7 +4758,7 @@ static void *enum_map_start(struct seq_file *m, loff_t *pos)
 	union trace_eval_map_item *v;
 	loff_t l = 0;
 
-	mutex_lock(&trace_enum_mutex);
+	mutex_lock(&trace_eval_mutex);
 
 	v = trace_eval_maps;
 	if (v)
@@ -4773,7 +4773,7 @@ static void *enum_map_start(struct seq_file *m, loff_t *pos)
 
 static void enum_map_stop(struct seq_file *m, void *v)
 {
-	mutex_unlock(&trace_enum_mutex);
+	mutex_unlock(&trace_eval_mutex);
 }
 
 static int enum_map_show(struct seq_file *m, void *v)
@@ -4838,7 +4838,7 @@ trace_insert_enum_map_file(struct module *mod, struct trace_eval_map **start,
 		return;
 	}
 
-	mutex_lock(&trace_enum_mutex);
+	mutex_lock(&trace_eval_mutex);
 
 	if (!trace_eval_maps)
 		trace_eval_maps = map_array;
@@ -4863,7 +4863,7 @@ trace_insert_enum_map_file(struct module *mod, struct trace_eval_map **start,
 	}
 	memset(map_array, 0, sizeof(*map_array));
 
-	mutex_unlock(&trace_enum_mutex);
+	mutex_unlock(&trace_eval_mutex);
 }
 
 static void trace_create_enum_file(struct dentry *d_tracer)
@@ -7740,7 +7740,7 @@ static void trace_module_remove_enums(struct module *mod)
 	if (!mod->num_trace_evals)
 		return;
 
-	mutex_lock(&trace_enum_mutex);
+	mutex_lock(&trace_eval_mutex);
 
 	map = trace_eval_maps;
 
@@ -7757,7 +7757,7 @@ static void trace_module_remove_enums(struct module *mod)
 	*last = trace_enum_jmp_to_tail(map)->tail.next;
 	kfree(map);
  out:
-	mutex_unlock(&trace_enum_mutex);
+	mutex_unlock(&trace_eval_mutex);
 }
 #else
 static inline void trace_module_remove_enums(struct module *mod) { }
-- 
2.9.4

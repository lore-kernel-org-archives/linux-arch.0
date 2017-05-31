From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 01/12] trace: rename kernel enum section to eval
Date: Wed, 31 May 2017 16:56:42 -0500
Message-ID: <20170531215653.3240-2-jeremy.linton@arm.com>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531215653.3240-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org
List-Id: linux-arch.vger.kernel.org

The kernel and its modules have sections containing the enum
string to value conversions. Rename this section because we
intend to store more than enums in it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/asm-generic/vmlinux.lds.h | 6 +++---
 include/trace/trace_events.h      | 2 +-
 kernel/module.c                   | 2 +-
 kernel/trace/trace.c              | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 314a0b9..800f9f9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -125,9 +125,9 @@
 			VMLINUX_SYMBOL(__start_ftrace_events) = .;	\
 			KEEP(*(_ftrace_events))				\
 			VMLINUX_SYMBOL(__stop_ftrace_events) = .;	\
-			VMLINUX_SYMBOL(__start_ftrace_enum_maps) = .;	\
-			KEEP(*(_ftrace_enum_map))			\
-			VMLINUX_SYMBOL(__stop_ftrace_enum_maps) = .;
+			VMLINUX_SYMBOL(__start_ftrace_eval_maps) = .;	\
+			KEEP(*(_ftrace_eval_map))			\
+			VMLINUX_SYMBOL(__stop_ftrace_eval_maps) = .;
 #else
 #define FTRACE_EVENTS()
 #endif
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 00f6431..4bdd840 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -43,7 +43,7 @@ TRACE_MAKE_SYSTEM_STR();
 		.enum_value = a				\
 	};						\
 	static struct trace_enum_map __used		\
-	__attribute__((section("_ftrace_enum_map")))	\
+	__attribute__((section("_ftrace_eval_map")))	\
 	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
 
 /*
diff --git a/kernel/module.c b/kernel/module.c
index 4a3665f..9ec4713 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3077,7 +3077,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->trace_events = section_objs(info, "_ftrace_events",
 					 sizeof(*mod->trace_events),
 					 &mod->num_trace_events);
-	mod->trace_enums = section_objs(info, "_ftrace_enum_map",
+	mod->trace_enums = section_objs(info, "_ftrace_eval_map",
 					sizeof(*mod->trace_enums),
 					&mod->num_trace_enums);
 #endif
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c4536c4..ce564c2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7704,15 +7704,15 @@ struct dentry *tracing_init_dentry(void)
 	return NULL;
 }
 
-extern struct trace_enum_map *__start_ftrace_enum_maps[];
-extern struct trace_enum_map *__stop_ftrace_enum_maps[];
+extern struct trace_enum_map *__start_ftrace_eval_maps[];
+extern struct trace_enum_map *__stop_ftrace_eval_maps[];
 
 static void __init trace_enum_init(void)
 {
 	int len;
 
-	len = __stop_ftrace_enum_maps - __start_ftrace_enum_maps;
-	trace_insert_enum_map(NULL, __start_ftrace_enum_maps, len);
+	len = __stop_ftrace_eval_maps - __start_ftrace_eval_maps;
+	trace_insert_enum_map(NULL, __start_ftrace_eval_maps, len);
 }
 
 #ifdef CONFIG_MODULES
-- 
2.9.4

From: guoren@kernel.org
Subject: [PATCH] csky/ftrace: Fixup error when disable CONFIG_DYNAMIC_FTRACE
Date: Wed,  8 Apr 2020 17:55:46 +0800
Message-ID: <20200408095546.31763-1-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-csky@vger.kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, guoren@kernel.org, Guo Ren <guoren@linux.alibaba.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When CONFIG_DYNAMIC_FTRACE is enabled, static ftrace will fail to
boot up and compile. It's a carelessness when developing "dynamic
ftrace" and "ftrace with regs".

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/abiv2/mcount.S  | 2 ++
 arch/csky/kernel/ftrace.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/csky/abiv2/mcount.S b/arch/csky/abiv2/mcount.S
index 9331c7ed5958..911512bf480f 100644
--- a/arch/csky/abiv2/mcount.S
+++ b/arch/csky/abiv2/mcount.S
@@ -103,6 +103,8 @@ ENTRY(_mcount)
 	mov	a0, lr
 	subi	a0, 4
 	ldw	a1, (sp, 24)
+	lrw	a2, function_trace_op
+	ldw	a2, (a2, 0)
 
 	jsr	r26
 
diff --git a/arch/csky/kernel/ftrace.c b/arch/csky/kernel/ftrace.c
index 44628e3f7fa6..3c425b84e3be 100644
--- a/arch/csky/kernel/ftrace.c
+++ b/arch/csky/kernel/ftrace.c
@@ -202,6 +202,7 @@ int ftrace_disable_ftrace_graph_caller(void)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
+#ifdef CONFIG_DYNAMIC_FTRACE
 #ifndef CONFIG_CPU_HAS_ICACHE_INS
 struct ftrace_modify_param {
 	int command;
@@ -231,6 +232,7 @@ void arch_ftrace_update_code(int command)
 	stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
 }
 #endif
+#endif /* CONFIG_DYNAMIC_FTRACE */
 
 /* _mcount is defined in abi's mcount.S */
 EXPORT_SYMBOL(_mcount);
-- 
2.17.0

Return-Path: <SRS0=p5Ku=5Y=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgDHJz4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 05:55:56 -0400
From: guoren@kernel.org
Subject: [PATCH] csky/ftrace: Fixup error when disable CONFIG_DYNAMIC_FTRACE
Date: Wed,  8 Apr 2020 17:55:46 +0800
Message-ID: <20200408095546.31763-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-csky@vger.kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, guoren@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Message-ID: <20200408095546.N6dcxV5t5AbIlOJIyzP5YAfqaviXwDkPvS0AhhtgQGg@z>

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

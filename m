From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v2 11/25] smp, mips: kill redundant call of generic_smp_call_function_single_interrupt()
Date: Thu, 12 Sep 2013 00:07:15 +0800
Message-ID: <1378915649-16395-12-git-send-email-liuj97@gmail.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, Shaohua Li <shli@kernel.org>
Cc: liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Jiang Liu <jiang.liu@huawei.com>

Since commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use
logic similar to smp_call_function_single()",
generic_smp_call_function_single_interrupt() is an alias of
generic_smp_call_function_interrupt(), so kill the redundant call.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/mips/kernel/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 5c208ed..0a022ee 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -150,7 +150,6 @@ asmlinkage void start_secondary(void)
 void __irq_entry smp_call_function_interrupt(void)
 {
 	irq_enter();
-	generic_smp_call_function_single_interrupt();
 	generic_smp_call_function_interrupt();
 	irq_exit();
 }
-- 
1.8.1.2

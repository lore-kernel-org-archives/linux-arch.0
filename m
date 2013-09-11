From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v2 13/25] smp, mn10300: enable arch_send_call_function_ipi_mask()
Date: Thu, 12 Sep 2013 00:07:17 +0800
Message-ID: <1378915649-16395-14-git-send-email-liuj97@gmail.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Shaohua Li <shli@kernel.org>
Cc: liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Jiang Liu <jiang.liu@huawei.com>

Enable arch_send_call_function_ipi_mask() on mn10300 to support
smp_call_function_many().

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/mn10300/kernel/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mn10300/kernel/smp.c b/arch/mn10300/kernel/smp.c
index 7ae353d..b827b68 100644
--- a/arch/mn10300/kernel/smp.c
+++ b/arch/mn10300/kernel/smp.c
@@ -356,8 +356,7 @@ void send_IPI_allbutself(int irq)
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 {
-	BUG();
-	/*send_IPI_mask(mask, CALL_FUNCTION_IPI);*/
+	send_IPI_mask(mask, CALL_FUNC_IPI);
 }
 
 void arch_send_call_function_single_ipi(int cpu)
-- 
1.8.1.2

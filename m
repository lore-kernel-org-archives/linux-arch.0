From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v3 [resend] 01/18] Revert "kernel/smp.c: free related resources when failure occurs in hotplug_cfd()"
Date: Mon, 16 Dec 2013 00:36:23 +0800
Message-ID: <1387125400-28849-2-git-send-email-liuj97@gmail.com>
References: <1387125400-28849-1-git-send-email-liuj97@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:54483 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab3LOQjr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 15 Dec 2013 11:39:47 -0500
In-Reply-To: <1387125400-28849-1-git-send-email-liuj97@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shli@kernel.org>, Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>, Wang YanQing <udknight@gmail.com>, Jiang Liu <jiang.liu@huawei.com>, linux-kernel@vger.kernel.org
Cc: Jiang Liu <liuj97@gmail.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, linux-arch@vger.kernel.org

This reverts commit 60c323699bb308404dcb60e8808531e02651578a.

Commit 60c323699bb30840 fixes a bug introduced by f44310b98ddb7, and we
are going to revert f44310b98ddb7, so revert 60c323699bb30840 first.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 kernel/smp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index bd9f940..442d514 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -48,13 +48,10 @@ hotplug_cfd(struct notifier_block *nfb, unsigned long action, void *hcpu)
 				cpu_to_node(cpu)))
 			return notifier_from_errno(-ENOMEM);
 		if (!zalloc_cpumask_var_node(&cfd->cpumask_ipi, GFP_KERNEL,
-				cpu_to_node(cpu))) {
-			free_cpumask_var(cfd->cpumask);
+				cpu_to_node(cpu)))
 			return notifier_from_errno(-ENOMEM);
-		}
 		cfd->csd = alloc_percpu(struct call_single_data);
 		if (!cfd->csd) {
-			free_cpumask_var(cfd->cpumask_ipi);
 			free_cpumask_var(cfd->cpumask);
 			return notifier_from_errno(-ENOMEM);
 		}
-- 
1.8.1.2

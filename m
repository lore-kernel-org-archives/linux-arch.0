Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43947 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKDfI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2019 23:35:08 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 1/5] sched/core: allow the remote scheduler tick to be started on CPU0
Date: Thu, 11 Apr 2019 13:34:44 +1000
Message-ID: <20190411033448.20842-2-npiggin@gmail.com>
In-Reply-To: <20190411033448.20842-1-npiggin@gmail.com>
References: <20190411033448.20842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190411033444.rZ4NByQYXc9S0NsI-evqlkzE2dvUSTq3N5iqaLoWes8@z>

This has no effect yet because CPU0 will always be a housekeeping CPU
until a later change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..10e05ec049b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5918,7 +5918,7 @@ void __init sched_init_smp(void)
 
 static int __init migration_init(void)
 {
-	sched_rq_cpu_starting(smp_processor_id());
+	sched_cpu_starting(smp_processor_id());
 	return 0;
 }
 early_initcall(migration_init);
-- 
2.20.1

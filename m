From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 2/8] ARC: perf: cap the number of counters to hardware max of 32
Date: Tue, 9 Jun 2015 17:49:26 +0530
Message-ID: <1433852372-29494-3-git-send-email-vgupta@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:52271 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbFIMUI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:20:08 -0400
In-Reply-To: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>

The number of counters in PCT can never be more than 32 (while countable
conditions could be 100+) for both ARCompact and ARCv2

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/perf_event.h | 5 +++--
 arch/arc/kernel/perf_event.c      | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index ea43477f8a59..ca8c414738de 100644
--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -1,6 +1,7 @@
 /*
  * Linux performance counter support for ARC
  *
+ * Copyright (C) 2014-2015 Synopsys, Inc. (www.synopsys.com)
  * Copyright (C) 2011-2013 Synopsys, Inc. (www.synopsys.com)
  *
  * This program is free software; you can redistribute it and/or modify
@@ -12,8 +13,8 @@
 #ifndef __ASM_PERF_EVENT_H
 #define __ASM_PERF_EVENT_H
 
-/* real maximum varies per CPU, this is the maximum supported by the driver */
-#define ARC_PMU_MAX_HWEVENTS	64
+/* Max number of counters that PCT block may ever have */
+#define ARC_PERF_MAX_COUNTERS	32
 
 /* Max number of countable events that CPU may have */
 #define ARC_PERF_MAX_EVENTS	256
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 400965973bb0..18b074f63cb6 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -23,7 +23,7 @@ struct arc_pmu {
 	int		counter_size;	/* in bits */
 	int		n_counters;
 	int		n_events;
-	unsigned long	used_mask[BITS_TO_LONGS(ARC_PMU_MAX_HWEVENTS)];
+	unsigned long	used_mask[BITS_TO_LONGS(ARC_PERF_MAX_COUNTERS)];
 	int		ev_hw_idx[PERF_COUNT_ARC_HW_MAX];
 	u64             raw_events[ARC_PERF_MAX_EVENTS];
 };
@@ -333,7 +333,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 		pr_err("This core does not have performance counters!\n");
 		return -ENODEV;
 	}
-	BUG_ON(pct_bcr.c > ARC_PMU_MAX_HWEVENTS);
+	BUG_ON(pct_bcr.c > ARC_PERF_MAX_COUNTERS);
 
 	READ_BCR(ARC_REG_CC_BUILD, cc_bcr);
 	BUG_ON(!cc_bcr.v); /* Counters exist but No countable conditions ? */
-- 
1.9.1

From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v3 1/6] ARC: perf: cap the number of counters to hardware max of 32
Date: Mon, 24 Aug 2015 17:20:18 +0300
Message-ID: <1440426023-2792-2-git-send-email-abrodkin@synopsys.com>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:38064 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbbHXOUl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Aug 2015 10:20:41 -0400
In-Reply-To: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, peterz@infradead.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

From: Vineet Gupta <vgupta@synopsys.com>

The number of counters in PCT can never be more than 32 (while
countable conditions could be 100+) for both ARCompact and ARCv2

And while at it update copyright dates.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---

Compared to v2:
 [1] Updated copyright date in arch/arc/kernel/perf_event.c

No changes since v1.

 arch/arc/include/asm/perf_event.h | 5 +++--
 arch/arc/kernel/perf_event.c      | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index 2b8880e..e7b16c2 100644
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
 
 #define ARC_REG_CC_BUILD	0xF6
 #define ARC_REG_CC_INDEX	0x240
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 1287388..d7ee5b2 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -1,7 +1,7 @@
 /*
  * Linux performance counter support for ARC700 series
  *
- * Copyright (C) 2013 Synopsys, Inc. (www.synopsys.com)
+ * Copyright (C) 2013-2015 Synopsys, Inc. (www.synopsys.com)
  *
  * This code is inspired by the perf support of various other architectures.
  *
@@ -22,7 +22,7 @@ struct arc_pmu {
 	struct pmu	pmu;
 	int		counter_size;	/* in bits */
 	int		n_counters;
-	unsigned long	used_mask[BITS_TO_LONGS(ARC_PMU_MAX_HWEVENTS)];
+	unsigned long	used_mask[BITS_TO_LONGS(ARC_PERF_MAX_COUNTERS)];
 	int		ev_hw_idx[PERF_COUNT_ARC_HW_MAX];
 };
 
@@ -284,7 +284,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 		pr_err("This core does not have performance counters!\n");
 		return -ENODEV;
 	}
-	BUG_ON(pct_bcr.c > ARC_PMU_MAX_HWEVENTS);
+	BUG_ON(pct_bcr.c > ARC_PERF_MAX_COUNTERS);
 
 	READ_BCR(ARC_REG_CC_BUILD, cc_bcr);
 	BUG_ON(!cc_bcr.v); /* Counters exist but No countable conditions ? */
-- 
2.4.3

From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 5/8] ARCv2: perf: set usable max period as a half of real max period
Date: Tue, 9 Jun 2015 17:49:29 +0530
Message-ID: <1433852372-29494-6-git-send-email-vgupta@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33661 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753976AbbFIMYm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:24:42 -0400
In-Reply-To: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

From: Alexey Brodkin <abrodkin@synopsys.com>

Overflow interrupt happens when counter reaches a limit which we set as a
maximum value of the counter.

But for better precision counter continues registration of assigned events
even after reaching pre-defined limit. To not really overlap we leave half
of the counter values free.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 4e3211948467..a7b4e4826533 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -491,7 +491,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	arc_pmu->n_counters = pct_bcr.c;
 	counter_size = 32 + (pct_bcr.s << 4);
 
-	arc_pmu->max_period = (1ULL << counter_size) - 1ULL;
+	arc_pmu->max_period = (1ULL << counter_size) / 2 - 1ULL;
 
 	pr_info("ARC perf\t: %d counters (%d bits), %d conditions%s\n",
 		arc_pmu->n_counters, counter_size, cc_bcr.c,
-- 
1.9.1

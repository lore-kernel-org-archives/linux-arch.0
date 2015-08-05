Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:39876 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753033AbbHEPOT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2015 11:14:19 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v2 5/8] ARCv2: perf: set usable max period as a half of real max period
Date: Wed,  5 Aug 2015 18:13:31 +0300
Message-ID: <1438787614-14074-6-git-send-email-abrodkin@synopsys.com>
In-Reply-To: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, peterz@infradead.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Message-ID: <20150805151331.BD18h9YrRivQW9YmIYGKkqXMIfNnd1LH5K7xc6TmM6U@z>

Overflow interrupt happens when counter reaches a limit which we set as a
maximum value of the counter.

But for better precision counter continues registration of assigned events
even after reaching pre-defined limit. To not really overlap we leave half
of the counter values free.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---

No changes since v1.

 arch/arc/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 1a9f922..81847ef 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -459,7 +459,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	arc_pmu->n_counters = pct_bcr.c;
 	counter_size = 32 + (pct_bcr.s << 4);
 
-	arc_pmu->max_period = (1ULL << counter_size) - 1ULL;
+	arc_pmu->max_period = (1ULL << counter_size) / 2 - 1ULL;
 
 	pr_info("ARC perf\t: %d counters (%d bits), %d conditions%s\n",
 		arc_pmu->n_counters, counter_size, cc_bcr.c,
-- 
2.4.3


From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 6/8] ARCv2: perf: implement exclusion of event counting in user or kernel mode
Date: Tue, 9 Jun 2015 17:49:30 +0530
Message-ID: <1433852372-29494-7-git-send-email-vgupta@synopsys.com>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

From: Alexey Brodkin <abrodkin@synopsys.com>

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/perf_event.h |  3 +++
 arch/arc/kernel/perf_event.c      | 16 ++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index 33a6eb2998ac..e915c0d4b630 100644
--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -37,6 +37,9 @@
 #define ARC_REG_PCT_INT_CTRL	0x25E
 #define ARC_REG_PCT_INT_ACT	0x25F
 
+#define ARC_REG_PCT_CONFIG_USER	(1 << 18)	/* count in user mode */
+#define ARC_REG_PCT_CONFIG_KERN	(1 << 19)	/* count in kernel mode */
+
 #define ARC_REG_PCT_CONTROL_CC	(1 << 16)	/* clear counts */
 #define ARC_REG_PCT_CONTROL_SN	(1 << 17)	/* snapshot */
 
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index a7b4e4826533..01aa0ea16bae 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -192,13 +192,25 @@ static int arc_pmu_event_init(struct perf_event *event)
 		if (!arc_pmu->has_interrupts)
 			return -ENOENT;
 
+	hwc->config = 0;
+
+	if (is_isa_arcv2()) {
+		/* "exclude user" means "count only kernel" */
+		if (event->attr.exclude_user)
+			hwc->config |= ARC_REG_PCT_CONFIG_KERN;
+
+		/* "exclude kernel" means "count only user" */
+		if (event->attr.exclude_kernel)
+			hwc->config |= ARC_REG_PCT_CONFIG_USER;
+	}
+
 	switch (event->attr.type) {
 	case PERF_TYPE_HARDWARE:
 		if (event->attr.config >= PERF_COUNT_HW_MAX)
 			return -ENOENT;
 		if (arc_pmu->ev_hw_idx[event->attr.config] < 0)
 			return -ENOENT;
-		hwc->config = arc_pmu->ev_hw_idx[event->attr.config];
+		hwc->config |= arc_pmu->ev_hw_idx[event->attr.config];
 		pr_debug("init event %d with h/w %d \'%s\'\n",
 			 (int) event->attr.config, (int) hwc->config,
 			 arc_pmu_ev_hw_map[event->attr.config]);
@@ -207,7 +219,7 @@ static int arc_pmu_event_init(struct perf_event *event)
 		ret = arc_pmu_cache_event(event->attr.config);
 		if (ret < 0)
 			return ret;
-		hwc->config = arc_pmu->ev_hw_idx[ret];
+		hwc->config |= arc_pmu->ev_hw_idx[ret];
 		return 0;
 
 	case PERF_TYPE_RAW:
-- 
1.9.1

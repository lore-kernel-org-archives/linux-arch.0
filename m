From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v2 1/8] ARC: perf: support RAW events
Date: Wed,  5 Aug 2015 18:13:27 +0300
Message-ID: <1438787614-14074-2-git-send-email-abrodkin@synopsys.com>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:39855 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752497AbbHEPOD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2015 11:14:03 -0400
In-Reply-To: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com, arc-linux-dev@synopsys.com, arnd@arndb.de, peterz@infradead.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Arnaldo Carvalho de Melo <acme@kernel.org>

To run perf against raw event user may issue following command:
 -------------->-------------
 # perf stat -e r6372756e ls -la /proc > /dev/null

  Performance counter stats for 'ls -la /proc':

            7336905      r6372756e

        0.085494733 seconds time elapsed
 -------------->-------------

"-e rXXX" is indication of raw event to count.
XXX is 64-bit ASCII value.
0x6372756e = crun (in ASCII)

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---

Compared to v1:
 [1] Swapping of event names moved to probe routine so now we're closer to
     real raw event in terms of accepting exactly what user entered.
 [2] Added comment in sources that explains logic for swapping etc.
 [3] Cosmetics

 arch/arc/include/asm/perf_event.h |  3 ++
 arch/arc/kernel/perf_event.c      | 78 +++++++++++++++++++++++++++++++++------
 2 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index 2b8880e..ea43477 100644
--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -15,6 +15,9 @@
 /* real maximum varies per CPU, this is the maximum supported by the driver */
 #define ARC_PMU_MAX_HWEVENTS	64
 
+/* Max number of countable events that CPU may have */
+#define ARC_PERF_MAX_EVENTS	256
+
 #define ARC_REG_CC_BUILD	0xF6
 #define ARC_REG_CC_INDEX	0x240
 #define ARC_REG_CC_NAME0	0x241
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 1287388..ae4a921 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -22,8 +22,10 @@ struct arc_pmu {
 	struct pmu	pmu;
 	int		counter_size;	/* in bits */
 	int		n_counters;
+	int		n_events;
 	unsigned long	used_mask[BITS_TO_LONGS(ARC_PMU_MAX_HWEVENTS)];
 	int		ev_hw_idx[PERF_COUNT_ARC_HW_MAX];
+	u64             raw_events[ARC_PERF_MAX_EVENTS];
 };
 
 struct arc_callchain_trace {
@@ -136,6 +138,18 @@ static int arc_pmu_cache_event(u64 config)
 	return ret;
 }
 
+static int arc_pmu_raw_event(u64 config)
+{
+	int i;
+
+	for (i = 0; i < arc_pmu->n_events; i++) {
+		if (config == arc_pmu->raw_events[i])
+			return i;
+	}
+
+	return -ENOENT;
+}
+
 /* initializes hw_perf_event structure if event is supported */
 static int arc_pmu_event_init(struct perf_event *event)
 {
@@ -159,6 +173,14 @@ static int arc_pmu_event_init(struct perf_event *event)
 			return ret;
 		hwc->config = arc_pmu->ev_hw_idx[ret];
 		return 0;
+
+	case PERF_TYPE_RAW:
+		ret = arc_pmu_raw_event(event->attr.config);
+		if (ret < 0)
+			return ret;
+		hwc->config |= ret;
+		return 0;
+
 	default:
 		return -ENOENT;
 	}
@@ -270,15 +292,15 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	struct arc_reg_cc_build cc_bcr;
 	int i, j;
 
-	union cc_name {
-		struct {
-			uint32_t word0, word1;
-			char sentinel;
-		} indiv;
-		char str[9];
+	struct cc_name {
+		union {
+			uint32_t word[2];
+			u64	 dword;
+			char	 str[8];
+		} u;
+		char sentinel[8];
 	} cc_name;
 
-
 	READ_BCR(ARC_REG_PCT_BUILD, pct_bcr);
 	if (!pct_bcr.v) {
 		pr_err("This core does not have performance counters!\n");
@@ -288,6 +310,7 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 
 	READ_BCR(ARC_REG_CC_BUILD, cc_bcr);
 	BUG_ON(!cc_bcr.v); /* Counters exist but No countable conditions ? */
+	BUG_ON(cc_bcr.c > ARC_PERF_MAX_EVENTS);
 
 	arc_pmu = devm_kzalloc(&pdev->dev, sizeof(struct arc_pmu), GFP_KERNEL);
 	if (!arc_pmu)
@@ -299,23 +322,54 @@ static int arc_pmu_device_probe(struct platform_device *pdev)
 	pr_info("ARC perf\t: %d counters (%d bits), %d countable conditions\n",
 		arc_pmu->n_counters, arc_pmu->counter_size, cc_bcr.c);
 
-	cc_name.str[8] = 0;
+	arc_pmu->n_events = cc_bcr.c;
+
 	for (i = 0; i < PERF_COUNT_ARC_HW_MAX; i++)
 		arc_pmu->ev_hw_idx[i] = -1;
 
+	cc_name.sentinel[0] = '\0';
+
 	/* loop thru all available h/w condition indexes */
 	for (j = 0; j < cc_bcr.c; j++) {
+		u64 name;
+
 		write_aux_reg(ARC_REG_CC_INDEX, j);
-		cc_name.indiv.word0 = read_aux_reg(ARC_REG_CC_NAME0);
-		cc_name.indiv.word1 = read_aux_reg(ARC_REG_CC_NAME1);
+		cc_name.u.word[0] = read_aux_reg(ARC_REG_CC_NAME0);
+		cc_name.u.word[1] = read_aux_reg(ARC_REG_CC_NAME1);
+
+		/*
+		 * condition name caching for raw events
+		 *
+		 * In PCT register CC_NAME{0,1} event name string[] is saved
+		 * from LSB side:
+		 * e.g. cycles corresponds to "crun" and is saved as 0x6e757263
+		 *						       n u r c
+		 * However in perf cmdline they are specified in human order as
+		 * r6372756e
+		 *
+		 * Thus save a 64bit swapped value for quick cross check at the
+		 * time of raw event request, which will give in example above:
+		 * __swab64(0x000000006e757263) = 0x6372756e00000000.
+		 * And then to finally have 0x6372756e, trim the trailing zeroes
+		 */
+		name = __swab64(cc_name.u.dword);
+
+		/* Trim leading zeroes */
+		for (i = 0; i < sizeof(u64); i++)
+			if (!(name & 0xFF))
+				name = name >> 8;
+			else
+				break;
+
+		arc_pmu->raw_events[j] = name;
 
 		/* See if it has been mapped to a perf event_id */
 		for (i = 0; i < ARRAY_SIZE(arc_pmu_ev_hw_map); i++) {
 			if (arc_pmu_ev_hw_map[i] &&
-			    !strcmp(arc_pmu_ev_hw_map[i], cc_name.str) &&
+			    !strcmp(arc_pmu_ev_hw_map[i], cc_name.u.str) &&
 			    strlen(arc_pmu_ev_hw_map[i])) {
 				pr_debug("mapping perf event %2d to h/w event \'%8s\' (idx %d)\n",
-					 i, cc_name.str, j);
+					 i, cc_name.u.str, j);
 				arc_pmu->ev_hw_idx[i] = j;
 			}
 		}
-- 
2.4.3

From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 15/24] lmb: Add find_lmb_area_node()
Date: Fri, 26 Mar 2010 15:21:45 -0700
Message-ID: <1269642114-16588-16-git-send-email-yinghai@kernel.org>
References: <1269642114-16588-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1269642114-16588-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

It can be used to find NODE_DATA for numa.

Need to make sure early_node_map[] is filled before it is called

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/lmb.h |    1 +
 mm/lmb.c            |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/linux/lmb.h b/include/linux/lmb.h
index 143f97d..019520a 100644
--- a/include/linux/lmb.h
+++ b/include/linux/lmb.h
@@ -91,6 +91,7 @@ u64 __find_lmb_area(u64 ei_start, u64 ei_last, u64 start, u64 end,
 			 u64 size, u64 align);
 u64 find_lmb_area(u64 start, u64 end, u64 size, u64 align);
 u64 find_lmb_area_size(u64 start, u64 *sizep, u64 align);
+u64 find_lmb_area_node(int nid, u64 start, u64 end, u64 size, u64 align);
 u64 get_max_mapped(void);
 
 void lmb_to_bootmem(u64 start, u64 end);
diff --git a/mm/lmb.c b/mm/lmb.c
index 05d3244..6f794ed 100644
--- a/mm/lmb.c
+++ b/mm/lmb.c
@@ -913,6 +913,21 @@ u64 __init find_lmb_area_size(u64 start, u64 *sizep, u64 align)
 }
 
 /*
+ * Need to call this function after lmb_register_active_regions,
+ * so early_node_map[] is filled already.
+ */
+u64 __init find_lmb_area_node(int nid, u64 start, u64 end, u64 size, u64 align)
+{
+	u64 addr;
+	addr = find_memory_core_early(nid, size, align, start, end);
+	if (addr != -1ULL)
+		return addr;
+
+	/* Fallback, should already have start end within node range */
+	return find_lmb_area(start, end, size, align);
+}
+
+/*
  * Finds an active region in the address range from start_pfn to last_pfn and
  * returns its range in ei_startpfn and ei_endpfn for the lmb entry.
  */
-- 
1.6.4.2

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:38743 "EHLO
	rcsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab0C3Ldc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2010 07:33:32 -0400
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 12/29] lmb: Add lmb_find_area_node()
Date: Tue, 30 Mar 2010 04:19:46 -0700
Message-ID: <1269948003-17221-13-git-send-email-yinghai@kernel.org>
In-Reply-To: <1269948003-17221-1-git-send-email-yinghai@kernel.org>
References: <1269948003-17221-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20100330111946.xZfU6sOEeAFHrUXwlE8u4vjerPM1gPorFz9xshqfYUg@z>

It can be used to find NODE_DATA for numa.

Need to make sure early_node_map[] is filled before it is called

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/lmb.h |    1 +
 mm/lmb.c            |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/include/linux/lmb.h b/include/linux/lmb.h
index 5dbc4ef..4078825 100644
--- a/include/linux/lmb.h
+++ b/include/linux/lmb.h
@@ -91,6 +91,7 @@ void lmb_add_memory(u64 start, u64 end);
 u64 __lmb_find_area(u64 ei_start, u64 ei_last, u64 start, u64 end,
 			 u64 size, u64 align);
 u64 lmb_find_area(u64 start, u64 end, u64 size, u64 align);
+u64 lmb_find_area_node(int nid, u64 start, u64 end, u64 size, u64 align);
 
 void lmb_to_bootmem(u64 start, u64 end);
 struct range;
diff --git a/mm/lmb.c b/mm/lmb.c
index ea9d459..97e582d 100644
--- a/mm/lmb.c
+++ b/mm/lmb.c
@@ -792,6 +792,21 @@ u64 __init lmb_find_area(u64 start, u64 end, u64 size, u64 align)
 	return -1ULL;
 }
 /*
+ * Need to call this function after lmb_register_active_regions,
+ * so early_node_map[] is filled already.
+ */
+u64 __init lmb_find_area_node(int nid, u64 start, u64 end, u64 size, u64 align)
+{
+	u64 addr;
+	addr = find_memory_core_early(nid, size, align, start, end);
+	if (addr != -1ULL)
+		return addr;
+
+	/* Fallback, should already have start end within node range */
+	return lmb_find_area(start, end, size, align);
+}
+
+/*
  * Finds an active region in the address range from start_pfn to last_pfn and
  * returns its range in ei_startpfn and ei_endpfn for the lmb entry.
  */
-- 
1.6.4.2


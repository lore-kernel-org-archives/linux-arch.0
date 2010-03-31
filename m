From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 24/33] nobootmem: use lmb.default_alloc_limit in alloc_bootmem path
Date: Tue, 30 Mar 2010 19:17:09 -0700
Message-ID: <1270001838-15857-25-git-send-email-yinghai@kernel.org>
References: <1270001838-15857-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270001838-15857-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

Generic version __lmb_find_area() is going from high to low, and for 32bit
active_region for 32bit does include high pages

need to replace the limit with lmb.default_alloc_limit, aka get_max_mapped()

with this patch, x86 32bit could use generic version of __lmb_find_area()

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 mm/page_alloc.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -3445,6 +3445,9 @@ void * __init __alloc_memory_core_early(
 
 	u64 addr;
 
+	if (limit > lmb.default_alloc_limit)
+		limit = lmb.default_alloc_limit;
+
 	addr = find_memory_core_early(nid, size, align, goal, limit);
 
 	if (addr == -1ULL)
-- 
1.6.4.2

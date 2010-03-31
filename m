From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 05/33] lmb: Add lmb_find_area()
Date: Tue, 30 Mar 2010 19:16:50 -0700
Message-ID: <1270001838-15857-6-git-send-email-yinghai@kernel.org>
References: <1270001838-15857-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270001838-15857-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

It will try find area according with size/align in specified range (start, end).

lmb_find_area() will honor goal/limit.

also make it more easy for x86 to use lmb.
x86 early_res is using find/reserve pattern instead of alloc.

When we need temporaray buff for range array etc for range work, if We are using
lmb_alloc(), We will need to add some post fix code for buffer that is used
by range array, because it is in the lmb.reserved already. and have to call
extra lmb_free().

-v2: Change name to lmb_find_area() according to Michael Ellerman
-v3: Add generic weak version __lmb_find_area()

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/lmb.h |    4 ++++
 mm/lmb.c            |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/include/linux/lmb.h b/include/linux/lmb.h
index e14ea8d..4cf2f3b 100644
--- a/include/linux/lmb.h
+++ b/include/linux/lmb.h
@@ -83,6 +83,10 @@ lmb_end_pfn(struct lmb_region *type, unsigned long region_nr)
 	       lmb_size_pages(type, region_nr);
 }
 
+u64 __lmb_find_area(u64 ei_start, u64 ei_last, u64 start, u64 end,
+			 u64 size, u64 align);
+u64 lmb_find_area(u64 start, u64 end, u64 size, u64 align);
+
 #include <asm/lmb.h>
 
 #endif /* __KERNEL__ */
diff --git a/mm/lmb.c b/mm/lmb.c
index 392d805..6739e4f 100644
--- a/mm/lmb.c
+++ b/mm/lmb.c
@@ -11,9 +11,13 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/types.h>
 #include <linux/init.h>
 #include <linux/bitops.h>
 #include <linux/lmb.h>
+#include <linux/bootmem.h>
+#include <linux/mm.h>
+#include <linux/range.h>
 
 #define LMB_ALLOC_ANYWHERE	0
 
@@ -559,3 +563,48 @@ int lmb_find(struct lmb_property *res)
 	}
 	return -1;
 }
+
+u64 __init __weak __lmb_find_area(u64 ei_start, u64 ei_last, u64 start, u64 end,
+				 u64 size, u64 align)
+{
+	u64 final_start, final_end;
+	u64 mem;
+
+	final_start = max(ei_start, start);
+	final_end = min(ei_last, end);
+
+	if (final_start >= final_end)
+		return -1ULL;
+
+	mem = __lmb_find_base(size, align, final_end);
+
+	if (mem == -1ULL)
+		return -1ULL;
+
+	lmb_free(mem, size);
+	if (mem >= final_start)
+		return mem;
+
+	return -1ULL;
+}
+
+/*
+ * Find a free area with specified alignment in a specific range.
+ */
+u64 __init lmb_find_area(u64 start, u64 end, u64 size, u64 align)
+{
+	int i;
+
+	for (i = 0; i < lmb.memory.cnt; i++) {
+		u64 ei_start = lmb.memory.region[i].base;
+		u64 ei_last = ei_start + lmb.memory.region[i].size;
+		u64 addr;
+
+		addr = __lmb_find_area(ei_start, ei_last, start, end,
+					 size, align);
+
+		if (addr != -1ULL)
+			return addr;
+	}
+	return -1ULL;
+}
-- 
1.6.4.2

From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 18/37] x86, lmb: Use lmb_debug to control debug message print out
Date: Fri, 14 May 2010 12:45:44 -0700
Message-ID: <1273866363-14249-19-git-send-email-yinghai@kernel.org>
References: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

Also let lmb_reserve_area/lmb_free_area could print out name if lmb=debug is
specified

will also print ther name when reserve_lmb_area/free_lmb_area are called.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/mm/lmb.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/lmb.c b/arch/x86/mm/lmb.c
index 15fd3e4..5007dbf 100644
--- a/arch/x86/mm/lmb.c
+++ b/arch/x86/mm/lmb.c
@@ -121,11 +121,13 @@ static void __init subtract_lmb_reserved(struct range *range, int az)
 
 	count  = lmb.reserved.cnt;
 
-	pr_info("Subtract (%d early reservations)\n", count);
+	if (lmb_debug)
+		pr_info("Subtract (%d early reservations)\n", count);
 
 	for (i = 0; i < count; i++) {
 		struct lmb_region *r = &lmb.reserved.regions[i];
-		pr_info("  #%d [%010llx - %010llx]\n", i, (u64)r->base, (u64)r->base + r->size);
+		if (lmb_debug)
+			pr_info("  #%d [%010llx - %010llx]\n", i, (u64)r->base, (u64)r->base + r->size);
 		final_start = PFN_DOWN(r->base);
 		final_end = PFN_UP(r->base + r->size);
 		if (final_start >= final_end)
@@ -205,17 +207,21 @@ void __init lmb_to_bootmem(u64 start, u64 end)
 		lmb_free(__pa(lmb.reserved.regions), sizeof(struct lmb_region) * lmb.reserved.max);
 
 	count  = lmb.reserved.cnt;
-	pr_info("(%d early reservations) ==> bootmem [%010llx - %010llx]\n", count, start, end);
+	if (lmb_debug)
+		pr_info("(%d early reservations) ==> bootmem [%010llx - %010llx]\n", count, start, end);
 	for (i = 0; i < count; i++) {
 		struct lmb_region *r = &lmb.reserved.regions[i];
-		pr_info("  #%d [%010llx - %010llx] ", i, (u64)r->base, (u64)r->base + r->size);
+		if (lmb_debug)
+			pr_info("  #%d [%010llx - %010llx] ", i, (u64)r->base, (u64)r->base + r->size);
 		final_start = max(start, r->base);
 		final_end = min(end, r->base + r->size);
 		if (final_start >= final_end) {
-			pr_cont("\n");
+			if (lmb_debug)
+				pr_cont("\n");
 			continue;
 		}
-		pr_cont(" ==> [%010llx - %010llx]\n", final_start, final_end);
+		if (lmb_debug)
+			pr_cont(" ==> [%010llx - %010llx]\n", final_start, final_end);
 		reserve_bootmem_generic(final_start, final_end - final_start, BOOTMEM_DEFAULT);
 	}
 	/* Clear them to avoid misusing ? */
@@ -306,6 +312,9 @@ void __init lmb_reserve_area(u64 start, u64 end, char *name)
 	if (WARN_ONCE(start > end, "lmb_reserve_area: wrong range [%#llx, %#llx]\n", start, end))
 		return;
 
+	if (lmb_debug)
+		pr_info("    lmb_reserve_area: [%010llx, %010llx] %16s\n", start, end, name);
+
 	lmb_reserve(start, end - start);
 }
 
@@ -317,6 +326,9 @@ void __init lmb_free_area(u64 start, u64 end)
 	if (WARN_ONCE(start > end, "lmb_free_area: wrong range [%#llx, %#llx]\n", start, end))
 		return;
 
+	if (lmb_debug)
+		pr_info("       lmb_free_area: [%010llx, %010llx]\n", start, end);
+
 	lmb_free(start, end - start);
 }
 
-- 
1.6.4.2

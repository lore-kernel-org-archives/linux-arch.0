From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 18/23] x86, lmb: Use lmb_debug to control debug message print out
Date: Sat,  3 Jul 2010 23:56:22 -0700
Message-ID: <1278226587-31213-19-git-send-email-yinghai@kernel.org>
References: <1278226587-31213-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278226587-31213-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

Also let lmb_x86_reserve_range/lmb_x86_free_range could print out name if lmb=debug is
specified

will also print ther name when reserve_lmb_area/free_lmb_area are called.

-v2: according to Ingo, put " if (lmb_debug) " in one place

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/mm/lmb.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/lmb.c b/arch/x86/mm/lmb.c
index 2dfc523..952449c 100644
--- a/arch/x86/mm/lmb.c
+++ b/arch/x86/mm/lmb.c
@@ -122,10 +122,10 @@ static void __init lmb_x86_subtract_reserved(struct range *range, int az)
 
 	count  = lmb.reserved.cnt;
 
-	pr_info("Subtract (%d early reservations)\n", count);
+	lmb_dbg("Subtract (%d early reservations)\n", count);
 
 	for_each_lmb(reserved, r) {
-		pr_info("  [%010llx - %010llx]\n", (u64)r->base, (u64)r->base + r->size);
+		lmb_dbg("  [%#010llx - %#010llx]\n", (u64)r->base, (u64)r->base + r->size);
 		final_start = PFN_DOWN(r->base);
 		final_end = PFN_UP(r->base + r->size);
 		if (final_start >= final_end)
@@ -198,16 +198,16 @@ void __init lmb_x86_to_bootmem(u64 start, u64 end)
 		lmb_free(__pa(lmb.reserved.regions), sizeof(struct lmb_region) * lmb.reserved.max);
 
 	count  = lmb.reserved.cnt;
-	pr_info("(%d early reservations) ==> bootmem [%010llx - %010llx]\n", count, start, end);
+	lmb_dbg("(%d early reservations) ==> bootmem [%#010llx - %#010llx]\n", count, start, end);
 	for_each_lmb(reserved, r) {
-		pr_info("  [%010llx - %010llx] ", (u64)r->base, (u64)r->base + r->size);
+		lmb_dbg("  [%#010llx - %#010llx] ", (u64)r->base, (u64)r->base + r->size);
 		final_start = max(start, r->base);
 		final_end = min(end, r->base + r->size);
 		if (final_start >= final_end) {
-			pr_cont("\n");
+			lmb_dbg("\n");
 			continue;
 		}
-		pr_cont(" ==> [%010llx - %010llx]\n", final_start, final_end);
+		lmb_dbg(" ==> [%#010llx - %#010llx]\n", final_start, final_end);
 		reserve_bootmem_generic(final_start, final_end - final_start, BOOTMEM_DEFAULT);
 	}
 
@@ -286,9 +286,11 @@ void __init lmb_x86_reserve_range(u64 start, u64 end, char *name)
 	if (start == end)
 		return;
 
-	if (WARN_ONCE(start > end, "lmb_x86_reserve_range: wrong range [%#llx, %#llx]\n", start, end))
+	if (WARN_ONCE(start > end, "lmb_x86_reserve_range: wrong range [%#llx, %#llx)\n", start, end))
 		return;
 
+	lmb_dbg("    lmb_x86_reserve_range: [%#010llx - %#010llx] %16s\n", start, end, name);
+
 	lmb_reserve(start, end - start);
 }
 
@@ -297,9 +299,11 @@ void __init lmb_x86_free_range(u64 start, u64 end)
 	if (start == end)
 		return;
 
-	if (WARN_ONCE(start > end, "lmb_x86_free_range: wrong range [%#llx, %#llx]\n", start, end))
+	if (WARN_ONCE(start > end, "lmb_x86_free_range: wrong range [%#llx, %#llx)\n", start, end))
 		return;
 
+	lmb_dbg("       lmb_x86_free_range: [%#010llx - %#010llx]\n", start, end);
+
 	lmb_free(start, end - start);
 }
 
-- 
1.6.4.2

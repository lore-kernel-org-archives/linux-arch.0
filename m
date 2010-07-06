From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 44/49] x86, memblock: Use memblock_debug to control debug message print out
Date: Tue,  6 Jul 2010 15:39:37 -0700
Message-ID: <1278455982-24621-45-git-send-email-yinghai@kernel.org>
References: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

Also let memblock_x86_reserve_range/memblock_x86_free_range could print out name if memblock=debug is
specified

will also print ther name when reserve_memblock_area/free_memblock_area are called.

-v2: according to Ingo, put " if (memblock_debug) " in one place

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/mm/memblock.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/memblock.c b/arch/x86/mm/memblock.c
index b10258d..166d5bf 100644
--- a/arch/x86/mm/memblock.c
+++ b/arch/x86/mm/memblock.c
@@ -122,10 +122,10 @@ static void __init memblock_x86_subtract_reserved(struct range *range, int az)
 
 	count  = memblock.reserved.cnt;
 
-	pr_info("Subtract (%d early reservations)\n", count);
+	memblock_dbg("Subtract (%d early reservations)\n", count);
 
 	for_each_memblock(reserved, r) {
-		pr_info("  [%010llx - %010llx]\n", (u64)r->base, (u64)r->base + r->size);
+		memblock_dbg("  [%#010llx - %#010llx]\n", (u64)r->base, (u64)r->base + r->size);
 		final_start = PFN_DOWN(r->base);
 		final_end = PFN_UP(r->base + r->size);
 		if (final_start >= final_end)
@@ -198,16 +198,16 @@ void __init memblock_x86_to_bootmem(u64 start, u64 end)
 		memblock_free(__pa(memblock.reserved.regions), sizeof(struct memblock_region) * memblock.reserved.max);
 
 	count  = memblock.reserved.cnt;
-	pr_info("(%d early reservations) ==> bootmem [%010llx - %010llx]\n", count, start, end);
+	memblock_dbg("(%d early reservations) ==> bootmem [%#010llx - %#010llx]\n", count, start, end);
 	for_each_memblock(reserved, r) {
-		pr_info("  [%010llx - %010llx] ", (u64)r->base, (u64)r->base + r->size);
+		memblock_dbg("  [%#010llx - %#010llx] ", (u64)r->base, (u64)r->base + r->size);
 		final_start = max(start, r->base);
 		final_end = min(end, r->base + r->size);
 		if (final_start >= final_end) {
-			pr_cont("\n");
+			memblock_dbg("\n");
 			continue;
 		}
-		pr_cont(" ==> [%010llx - %010llx]\n", final_start, final_end);
+		memblock_dbg(" ==> [%#010llx - %#010llx]\n", final_start, final_end);
 		reserve_bootmem_generic(final_start, final_end - final_start, BOOTMEM_DEFAULT);
 	}
 
@@ -286,9 +286,11 @@ void __init memblock_x86_reserve_range(u64 start, u64 end, char *name)
 	if (start == end)
 		return;
 
-	if (WARN_ONCE(start > end, "memblock_x86_reserve_range: wrong range [%#llx, %#llx]\n", start, end))
+	if (WARN_ONCE(start > end, "memblock_x86_reserve_range: wrong range [%#llx, %#llx)\n", start, end))
 		return;
 
+	memblock_dbg("    memblock_x86_reserve_range: [%#010llx - %#010llx] %16s\n", start, end, name);
+
 	memblock_reserve(start, end - start);
 }
 
@@ -297,9 +299,11 @@ void __init memblock_x86_free_range(u64 start, u64 end)
 	if (start == end)
 		return;
 
-	if (WARN_ONCE(start > end, "memblock_x86_free_range: wrong range [%#llx, %#llx]\n", start, end))
+	if (WARN_ONCE(start > end, "memblock_x86_free_range: wrong range [%#llx, %#llx)\n", start, end))
 		return;
 
+	memblock_dbg("       memblock_x86_free_range: [%#010llx - %#010llx]\n", start, end);
+
 	memblock_free(start, end - start);
 }
 
-- 
1.6.4.2

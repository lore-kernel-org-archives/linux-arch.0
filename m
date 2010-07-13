From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 43/50] x86, memblock: Add memblock_x86_free_memory_in_range()
Date: Tue, 13 Jul 2010 00:10:37 -0700
Message-ID: <1279005044-24777-44-git-send-email-yinghai@kernel.org>
References: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

It will return free memory size in specified range.

We can not use memory_size - reserved_size here, because some reserved area
may not be in the scope of memblock.memory.region.

Use memblock.memory.region subtracting memblock.reserved.region to get free range array.
then count size of all free ranges.

-v2: Ben insist on using _in_range

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/include/asm/memblock.h |    1 +
 arch/x86/mm/memblock.c          |   48 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/memblock.h b/arch/x86/include/asm/memblock.h
index 3a86b10..fc3c230 100644
--- a/arch/x86/include/asm/memblock.h
+++ b/arch/x86/include/asm/memblock.h
@@ -15,5 +15,6 @@ void memblock_x86_register_active_regions(int nid, unsigned long start_pfn,
 					 unsigned long last_pfn);
 u64 memblock_x86_hole_size(u64 start, u64 end);
 u64 memblock_x86_find_in_range_node(int nid, u64 start, u64 end, u64 size, u64 align);
+u64 memblock_x86_free_memory_in_range(u64 addr, u64 limit);
 
 #endif
diff --git a/arch/x86/mm/memblock.c b/arch/x86/mm/memblock.c
index a3dece6..3882caa 100644
--- a/arch/x86/mm/memblock.c
+++ b/arch/x86/mm/memblock.c
@@ -217,6 +217,54 @@ void __init memblock_x86_to_bootmem(u64 start, u64 end)
 }
 #endif
 
+u64 __init memblock_x86_free_memory_in_range(u64 addr, u64 limit)
+{
+	int i, count;
+	struct range *range;
+	int nr_range;
+	u64 final_start, final_end;
+	u64 free_size;
+	struct memblock_region *r;
+
+	count = (memblock.reserved.cnt + memblock.memory.cnt) * 2;
+
+	range = find_range_array(count);
+	nr_range = 0;
+
+	addr = PFN_UP(addr);
+	limit = PFN_DOWN(limit);
+
+	for_each_memblock(memory, r) {
+		final_start = PFN_UP(r->base);
+		final_end = PFN_DOWN(r->base + r->size);
+		if (final_start >= final_end)
+			continue;
+		if (final_start >= limit || final_end <= addr)
+			continue;
+
+		nr_range = add_range(range, count, nr_range, final_start, final_end);
+	}
+	subtract_range(range, count, 0, addr);
+	subtract_range(range, count, limit, -1ULL);
+	for_each_memblock(reserved, r) {
+		final_start = PFN_DOWN(r->base);
+		final_end = PFN_UP(r->base + r->size);
+		if (final_start >= final_end)
+			continue;
+		if (final_start >= limit || final_end <= addr)
+			continue;
+
+		subtract_range(range, count, final_start, final_end);
+	}
+	nr_range = clean_sort_range(range, count);
+
+	free_size = 0;
+	for (i = 0; i < nr_range; i++)
+		free_size += range[i].end - range[i].start;
+
+	return free_size << PAGE_SHIFT;
+}
+
 void __init memblock_x86_reserve_range(u64 start, u64 end, char *name)
 {
 	if (start == end)
-- 
1.6.4.2

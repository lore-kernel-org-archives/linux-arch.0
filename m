From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 24/50] memblock: Add "start" argument to memblock_find_base()
Date: Tue, 13 Jul 2010 00:10:18 -0700
Message-ID: <1279005044-24777-25-git-send-email-yinghai@kernel.org>
References: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

To constraint the search of a region between two boundaries,
which will be used by the new NUMA aware allocator among others.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 mm/memblock.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index f793d9f..b4870cf 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -117,19 +117,18 @@ static phys_addr_t __init memblock_find_region(phys_addr_t start, phys_addr_t en
 	return MEMBLOCK_ERROR;
 }
 
-static phys_addr_t __init memblock_find_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
+static phys_addr_t __init memblock_find_base(phys_addr_t size, phys_addr_t align,
+					phys_addr_t start, phys_addr_t end)
 {
 	long i;
-	phys_addr_t base = 0;
-	phys_addr_t res_base;
 
 	BUG_ON(0 == size);
 
 	size = memblock_align_up(size, align);
 
 	/* Pump up max_addr */
-	if (max_addr == MEMBLOCK_ALLOC_ACCESSIBLE)
-		max_addr = memblock.current_limit;
+	if (end == MEMBLOCK_ALLOC_ACCESSIBLE)
+		end = memblock.current_limit;
 
 	/* We do a top-down search, this tends to limit memory
 	 * fragmentation by keeping early boot allocs near the
@@ -138,13 +137,19 @@ static phys_addr_t __init memblock_find_base(phys_addr_t size, phys_addr_t align
 	for (i = memblock.memory.cnt - 1; i >= 0; i--) {
 		phys_addr_t memblockbase = memblock.memory.regions[i].base;
 		phys_addr_t memblocksize = memblock.memory.regions[i].size;
+		phys_addr_t bottom, top, found;
 
 		if (memblocksize < size)
 			continue;
-		base = min(memblockbase + memblocksize, max_addr);
-		res_base = memblock_find_region(memblockbase, base, size, align);
-		if (res_base != MEMBLOCK_ERROR)
-			return res_base;
+		if ((memblockbase + memblocksize) <= start)
+			break;
+		bottom = max(memblockbase, start);
+		top = min(memblockbase + memblocksize, end);
+		if (bottom >= top)
+			continue;
+		found = memblock_find_region(bottom, top, size, align);
+		if (found != MEMBLOCK_ERROR)
+			return found;
 	}
 	return MEMBLOCK_ERROR;
 }
@@ -204,7 +209,7 @@ static int memblock_double_array(struct memblock_type *type)
 		new_array = kmalloc(new_size, GFP_KERNEL);
 		addr = new_array == NULL ? MEMBLOCK_ERROR : __pa(new_array);
 	} else
-		addr = memblock_find_base(new_size, sizeof(phys_addr_t), MEMBLOCK_ALLOC_ACCESSIBLE);
+		addr = memblock_find_base(new_size, sizeof(phys_addr_t), 0, MEMBLOCK_ALLOC_ACCESSIBLE);
 	if (addr == MEMBLOCK_ERROR) {
 		pr_err("memblock: Failed to double %s array from %ld to %ld entries !\n",
 		       memblock_type_name(type), type->max, type->max * 2);
@@ -416,7 +421,7 @@ phys_addr_t __init __memblock_alloc_base(phys_addr_t size, phys_addr_t align, ph
 	 */
 	size = memblock_align_up(size, align);
 
-	found = memblock_find_base(size, align, max_addr);
+	found = memblock_find_base(size, align, 0, max_addr);
 	if (found != MEMBLOCK_ERROR &&
 	    memblock_add_region(&memblock.reserved, found, size) >= 0)
 		return found;
-- 
1.6.4.2

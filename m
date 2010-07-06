From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 17/49] memblock: Move memblock_init() to the bottom of the file
Date: Tue,  6 Jul 2010 15:39:10 -0700
Message-ID: <1278455982-24621-18-git-send-email-yinghai@kernel.org>
References: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

It's a real PITA to have to search for it in the middle

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 mm/memblock.c |   54 +++++++++++++++++++++++++++---------------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 079d0de..c1dd9df 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -107,33 +107,6 @@ static void memblock_coalesce_regions(struct memblock_type *type,
 	memblock_remove_region(type, r2);
 }
 
-void __init memblock_init(void)
-{
-	/* Hookup the initial arrays */
-	memblock.memory.regions	= memblock_memory_init_regions;
-	memblock.memory.max		= INIT_MEMBLOCK_REGIONS;
-	memblock.reserved.regions	= memblock_reserved_init_regions;
-	memblock.reserved.max	= INIT_MEMBLOCK_REGIONS;
-
-	/* Write a marker in the unused last array entry */
-	memblock.memory.regions[INIT_MEMBLOCK_REGIONS].base = (phys_addr_t)RED_INACTIVE;
-	memblock.reserved.regions[INIT_MEMBLOCK_REGIONS].base = (phys_addr_t)RED_INACTIVE;
-
-	/* Create a dummy zero size MEMBLOCK which will get coalesced away later.
-	 * This simplifies the memblock_add() code below...
-	 */
-	memblock.memory.regions[0].base = 0;
-	memblock.memory.regions[0].size = 0;
-	memblock.memory.cnt = 1;
-
-	/* Ditto. */
-	memblock.reserved.regions[0].base = 0;
-	memblock.reserved.regions[0].size = 0;
-	memblock.reserved.cnt = 1;
-
-	memblock.current_limit = MEMBLOCK_ALLOC_ANYWHERE;
-}
-
 void __init memblock_analyze(void)
 {
 	int i;
@@ -517,3 +490,30 @@ void __init memblock_set_current_limit(phys_addr_t limit)
 	memblock.current_limit = limit;
 }
 
+void __init memblock_init(void)
+{
+	/* Hookup the initial arrays */
+	memblock.memory.regions	= memblock_memory_init_regions;
+	memblock.memory.max		= INIT_MEMBLOCK_REGIONS;
+	memblock.reserved.regions	= memblock_reserved_init_regions;
+	memblock.reserved.max	= INIT_MEMBLOCK_REGIONS;
+
+	/* Write a marker in the unused last array entry */
+	memblock.memory.regions[INIT_MEMBLOCK_REGIONS].base = (phys_addr_t)RED_INACTIVE;
+	memblock.reserved.regions[INIT_MEMBLOCK_REGIONS].base = (phys_addr_t)RED_INACTIVE;
+
+	/* Create a dummy zero size MEMBLOCK which will get coalesced away later.
+	 * This simplifies the memblock_add() code below...
+	 */
+	memblock.memory.regions[0].base = 0;
+	memblock.memory.regions[0].size = 0;
+	memblock.memory.cnt = 1;
+
+	/* Ditto. */
+	memblock.reserved.regions[0].base = 0;
+	memblock.reserved.regions[0].size = 0;
+	memblock.reserved.cnt = 1;
+
+	memblock.current_limit = MEMBLOCK_ALLOC_ANYWHERE;
+}
+
-- 
1.6.4.2

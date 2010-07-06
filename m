From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 18/49] memblock: split memblock_find_base() out of __memblock_alloc_base()
Date: Tue,  6 Jul 2010 15:39:11 -0700
Message-ID: <1278455982-24621-19-git-send-email-yinghai@kernel.org>
References: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This will be used by the array resize code and might prove useful
to some arch code as well at which point it can be made non-static.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 mm/memblock.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index c1dd9df..4318b52 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -366,20 +366,7 @@ phys_addr_t __init memblock_alloc(phys_addr_t size, phys_addr_t align)
 	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
 }
 
-phys_addr_t __init memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
-{
-	phys_addr_t alloc;
-
-	alloc = __memblock_alloc_base(size, align, max_addr);
-
-	if (alloc == 0)
-		panic("ERROR: Failed to allocate 0x%llx bytes below 0x%llx.\n",
-		      (unsigned long long) size, (unsigned long long) max_addr);
-
-	return alloc;
-}
-
-phys_addr_t __init __memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
+static phys_addr_t __init memblock_find_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
 {
 	long i;
 	phys_addr_t base = 0;
@@ -405,13 +392,37 @@ phys_addr_t __init __memblock_alloc_base(phys_addr_t size, phys_addr_t align, ph
 			continue;
 		base = min(memblockbase + memblocksize, max_addr);
 		res_base = memblock_find_region(memblockbase, base, size, align);
-		if (res_base != MEMBLOCK_ERROR &&
-		    memblock_add_region(&memblock.reserved, res_base, size) >= 0)
+		if (res_base != MEMBLOCK_ERROR)
 			return res_base;
 	}
 	return 0;
 }
 
+phys_addr_t __init __memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
+{
+	phys_addr_t found = memblock_find_base(size, align, max_addr);
+
+	if (found != MEMBLOCK_ERROR &&
+	    memblock_add_region(&memblock.reserved, found, size) >= 0)
+		return found;
+
+	return 0;
+}
+
+phys_addr_t __init memblock_alloc_base(phys_addr_t size, phys_addr_t align, phys_addr_t max_addr)
+{
+	phys_addr_t alloc;
+
+	alloc = __memblock_alloc_base(size, align, max_addr);
+
+	if (alloc == 0)
+		panic("ERROR: Failed to allocate 0x%llx bytes below 0x%llx.\n",
+		      (unsigned long long) size, (unsigned long long) max_addr);
+
+	return alloc;
+}
+
+
 /* You must call memblock_analyze() before this. */
 phys_addr_t __init memblock_phys_mem_size(void)
 {
-- 
1.6.4.2

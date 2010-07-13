From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 37/50] x86, memblock: Add memblock_x86_to_bootmem()
Date: Tue, 13 Jul 2010 00:10:31 -0700
Message-ID: <1279005044-24777-38-git-send-email-yinghai@kernel.org>
References: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:29233 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab0GMHQp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jul 2010 03:16:45 -0400
In-Reply-To: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

memblock_x86_to_bootmem() will reserve memblock.reserved.region in bootmem after bootmem is
set up.

We can use it to with all arches that support memblock later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/include/asm/memblock.h |    1 +
 arch/x86/mm/memblock.c          |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/memblock.h b/arch/x86/include/asm/memblock.h
index c14219a..69cf853 100644
--- a/arch/x86/include/asm/memblock.h
+++ b/arch/x86/include/asm/memblock.h
@@ -4,5 +4,6 @@
 #define ARCH_DISCARD_MEMBLOCK
 
 u64 memblock_x86_find_in_range_size(u64 start, u64 *sizep, u64 align);
+void memblock_x86_to_bootmem(u64 start, u64 end);
 
 #endif
diff --git a/arch/x86/mm/memblock.c b/arch/x86/mm/memblock.c
index c602afb..7986a12 100644
--- a/arch/x86/mm/memblock.c
+++ b/arch/x86/mm/memblock.c
@@ -86,3 +86,33 @@ u64 __init memblock_x86_find_in_range_size(u64 start, u64 *sizep, u64 align)
 	return MEMBLOCK_ERROR;
 }
 
+#ifndef CONFIG_NO_BOOTMEM
+void __init memblock_x86_to_bootmem(u64 start, u64 end)
+{
+	int count;
+	u64 final_start, final_end;
+	struct memblock_region *r;
+
+	/* Take out region array itself */
+	if (memblock.reserved.regions != memblock_reserved_init_regions)
+		memblock_free(__pa(memblock.reserved.regions), sizeof(struct memblock_region) * memblock.reserved.max);
+
+	count  = memblock.reserved.cnt;
+	pr_info("(%d early reservations) ==> bootmem [%010llx-%010llx]\n", count, start, end - 1);
+	for_each_memblock(reserved, r) {
+		pr_info("  [%010llx-%010llx] ", (u64)r->base, (u64)r->base + r->size - 1);
+		final_start = max(start, r->base);
+		final_end = min(end, r->base + r->size);
+		if (final_start >= final_end) {
+			pr_cont("\n");
+			continue;
+		}
+		pr_cont(" ==> [%010llx-%010llx]\n", final_start, final_end - 1);
+		reserve_bootmem_generic(final_start, final_end - final_start, BOOTMEM_DEFAULT);
+	}
+
+	/* Put region array back ? */
+	if (memblock.reserved.regions != memblock_reserved_init_regions)
+		memblock_reserve(__pa(memblock.reserved.regions), sizeof(struct memblock_region) * memblock.reserved.max);
+}
+#endif
-- 
1.6.4.2

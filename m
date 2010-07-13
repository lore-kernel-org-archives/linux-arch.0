From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 30/50] memblock: Print new doubled array location info
Date: Tue, 13 Jul 2010 00:10:24 -0700
Message-ID: <1279005044-24777-31-git-send-email-yinghai@kernel.org>
References: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

so will have more idea where it is,  use memblock_debug to controll it

-v2: use memblock_dbg instead of " if (memblock_debug) "

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 mm/memblock.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index c16d4c6..796ef8c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -192,8 +192,6 @@ static int memblock_double_array(struct memblock_type *type)
 	if (!memblock_can_resize)
 		return -1;
 
-	pr_debug("memblock: %s array full, doubling...", memblock_type_name(type));
-
 	/* Calculate new doubled size */
 	old_size = type->max * sizeof(struct memblock_region);
 	new_size = old_size << 1;
@@ -221,6 +219,9 @@ static int memblock_double_array(struct memblock_type *type)
 	}
 	new_array = __va(addr);
 
+	memblock_dbg("memblock: %s array is doubled to %ld at [%#010llx-%#010llx]",
+		 memblock_type_name(type), type->max * 2, (u64)addr, (u64)addr + new_size - 1);
+
 	/* Found space, we now need to move the array over before
 	 * we add the reserved region since it may be our reserved
 	 * array itself that is full.
@@ -646,7 +647,7 @@ static void memblock_dump(struct memblock_type *region, char *name)
 		base = region->regions[i].base;
 		size = region->regions[i].size;
 
-		pr_info(" %s[0x%x]\t0x%016llx - 0x%016llx, 0x%llx bytes\n",
+		pr_info(" %s[%#x]\t[%#016llx-%#016llx], %#llx bytes\n",
 		    name, i, base, base + size - 1, size);
 	}
 }
-- 
1.6.4.2

From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 29/49] memblock: Print new doubled array location info
Date: Tue,  6 Jul 2010 15:39:22 -0700
Message-ID: <1278455982-24621-30-git-send-email-yinghai@kernel.org>
References: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

so will have more idea where it is,  use memblock_debug to controll it

-v2: use memblock_dbg instead of " if (memblock_debug) "

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 mm/memblock.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index f1f85c3..74143d9 100644
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
 
+	memblock_dbg("memblock: %s array is doubled to %ld at [%#010llx - %#010llx]",
+		 memblock_type_name(type), type->max * 2, (u64)addr, (u64)addr + new_size);
+
 	/* Found space, we now need to move the array over before
 	 * we add the reserved region since it may be our reserved
 	 * array itself that is full.
@@ -637,8 +638,8 @@ static void memblock_dump(struct memblock_type *region, char *name)
 		base = region->regions[i].base;
 		size = region->regions[i].size;
 
-		pr_info(" %s[0x%x]\t0x%016llx - 0x%016llx, 0x%llx bytes\n",
-		    name, i, base, base + size - 1, size);
+		pr_info(" %s[%#x]\t[%#016llx - %#016llx], %#llx bytes\n",
+		    name, i, base, base + size, size);
 	}
 }
 
-- 
1.6.4.2

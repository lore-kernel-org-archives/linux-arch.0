From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 04/49] memblock: No reason to include asm/memblock.h late
Date: Mon, 19 Jul 2010 16:56:13 -0700
Message-ID: <1279583818-14249-5-git-send-email-yinghai@kernel.org>
References: <1279583818-14249-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279583818-14249-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 include/linux/memblock.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 86e7daf..4b69313 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -16,6 +16,8 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 
+#include <asm/memblock.h>
+
 #define MAX_MEMBLOCK_REGIONS 128
 
 struct memblock_region {
@@ -82,8 +84,6 @@ memblock_end_pfn(struct memblock_type *type, unsigned long region_nr)
 	       memblock_size_pages(type, region_nr);
 }
 
-#include <asm/memblock.h>
-
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_MEMBLOCK_H */
-- 
1.6.4.2

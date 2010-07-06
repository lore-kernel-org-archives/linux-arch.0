From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 28/49] memblock: Prepare x86 to use memblock to replace early_res
Date: Tue,  6 Jul 2010 15:39:21 -0700
Message-ID: <1278455982-24621-29-git-send-email-yinghai@kernel.org>
References: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-arch.vger.kernel.org

1. expose memblock_debug
2. expose memblock_reserved_init_regions

-v2: drop memblock_add_region() and MEMBLOCK_ERROR export
-v3: seperate wrong return of memblock_fin_base to another patch
-v4: expose memblock_can_resize to handle x86 EFI that could have more than
      128 entries
-v5: add memblock_dbg, so we can spare some if (memblock_debug) suggested by Ingo.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/memblock.h |    6 ++++++
 mm/memblock.c            |    5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 08a12cf..70bc467 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -39,6 +39,12 @@ struct memblock {
 };
 
 extern struct memblock memblock;
+extern int memblock_debug;
+extern int memblock_can_resize;
+extern struct memblock_region memblock_reserved_init_regions[];
+
+#define memblock_dbg(fmt, ...) \
+	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
 
 extern void __init memblock_init(void);
 extern void __init memblock_analyze(void);
diff --git a/mm/memblock.c b/mm/memblock.c
index 8ed7901..f1f85c3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -22,9 +22,10 @@
 
 struct memblock memblock;
 
-static int memblock_debug, memblock_can_resize;
+int memblock_debug;
+int memblock_can_resize;
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS + 1];
-static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS + 1];
+struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_REGIONS + 1];
 
 #define MEMBLOCK_ERROR	(~(phys_addr_t)0)
 
-- 
1.6.4.2

From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 06/31] memblock: Expose MEMBLOCK_ALLOC_ANYWHERE
Date: Thu, 22 Jul 2010 11:20:39 -0700
Message-ID: <1279822864-17154-7-git-send-email-yinghai@kernel.org>
References: <1279822864-17154-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279822864-17154-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/hash_utils_64.c |    2 +-
 include/linux/memblock.h        |    1 +
 mm/memblock.c                   |    2 --
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2b0a807..c630b4f 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -625,7 +625,7 @@ static void __init htab_initialize(void)
 		if (machine_is(cell))
 			limit = 0x80000000;
 		else
-			limit = 0;
+			limit = MEMBLOCK_ALLOC_ANYWHERE;
 
 		table = memblock_alloc_base(htab_size_bytes, htab_size_bytes, limit);
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 3e4a52f..5853752 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -50,6 +50,7 @@ extern u64 __init memblock_alloc_nid(u64 size, u64 align, int nid);
 extern u64 __init memblock_alloc(u64 size, u64 align);
 extern u64 __init memblock_alloc_base(u64 size,
 		u64, u64 max_addr);
+#define MEMBLOCK_ALLOC_ANYWHERE	0
 extern u64 __init __memblock_alloc_base(u64 size,
 		u64 align, u64 max_addr);
 extern u64 __init memblock_phys_mem_size(void);
diff --git a/mm/memblock.c b/mm/memblock.c
index 9b71de0..0ad7626 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -15,8 +15,6 @@
 #include <linux/bitops.h>
 #include <linux/memblock.h>
 
-#define MEMBLOCK_ALLOC_ANYWHERE	0
-
 struct memblock memblock;
 
 static int memblock_debug;
-- 
1.6.4.2

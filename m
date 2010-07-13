From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 13/50] memblock: Remove unused memblock.debug struct member
Date: Tue, 13 Jul 2010 00:10:07 -0700
Message-ID: <1279005044-24777-14-git-send-email-yinghai@kernel.org>
References: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 include/linux/memblock.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 3b41f61..5abb06b 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -32,7 +32,6 @@ struct memblock_type {
 };
 
 struct memblock {
-	unsigned long debug;
 	phys_addr_t current_limit;
 	struct memblock_type memory;
 	struct memblock_type reserved;
@@ -55,9 +54,11 @@ extern phys_addr_t __init memblock_alloc(phys_addr_t size, phys_addr_t align);
 #define MEMBLOCK_ALLOC_ACCESSIBLE	0
 
 extern phys_addr_t __init memblock_alloc_base(phys_addr_t size,
-		phys_addr_t, phys_addr_t max_addr);
+					 phys_addr_t align,
+					 phys_addr_t max_addr);
 extern phys_addr_t __init __memblock_alloc_base(phys_addr_t size,
-		phys_addr_t align, phys_addr_t max_addr);
+					   phys_addr_t align,
+					   phys_addr_t max_addr);
 extern phys_addr_t __init memblock_phys_mem_size(void);
 extern phys_addr_t memblock_end_of_DRAM(void);
 extern void __init memblock_enforce_memory_limit(phys_addr_t memory_limit);
-- 
1.6.4.2

From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 27/50] memblock: Make memblock_alloc_try_nid() fallback to MEMBLOCK_ALLOC_ANYWHERE
Date: Tue, 13 Jul 2010 00:10:21 -0700
Message-ID: <1279005044-24777-28-git-send-email-yinghai@kernel.org>
References: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

memblock_alloc_nid() used to fallback to allocating anywhere by using
memblock_alloc() as a fallback.

However, some of my previous patches limit memblock_alloc() to the region
covered by MEMBLOCK_ALLOC_ACCESSIBLE which is not quite what we want
for memblock_alloc_try_nid().

So we fix it by explicitely using MEMBLOCK_ALLOC_ANYWHERE.

Not that so far only sparc uses memblock_alloc_nid() and it hasn't been updated
to clamp the accessible zone yet. Thus the temporary "breakage" should have
no effect.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 mm/memblock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index c3c499e..424ca11 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -546,7 +546,7 @@ phys_addr_t __init memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, i
 
 	if (res)
 		return res;
-	return memblock_alloc(size, align);
+	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE);
 }
 
 
-- 
1.6.4.2

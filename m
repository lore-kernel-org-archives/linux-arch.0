From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 29/31] memblock: Prepare to include linux/memblock.h in core file
Date: Thu, 22 Jul 2010 11:21:02 -0700
Message-ID: <1279822864-17154-30-git-send-email-yinghai@kernel.org>
References: <1279822864-17154-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:42179 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab0GVSW1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jul 2010 14:22:27 -0400
In-Reply-To: <1279822864-17154-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

Need to add protection in linux/memblock.h, to prepare to include it in
 mm/page_alloc.c and mm/bootmem.c etc.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/memblock.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 89749c4..4aaaf0d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -2,6 +2,7 @@
 #define _LINUX_MEMBLOCK_H
 #ifdef __KERNEL__
 
+#ifdef CONFIG_HAVE_MEMBLOCK
 /*
  * Logical memory blocks.
  *
@@ -147,6 +148,8 @@ static inline unsigned long memblock_region_pages(const struct memblock_region *
 	     region++)
 
 
+#endif /* CONFIG_HAVE_MEMBLOCK */
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_MEMBLOCK_H */
-- 
1.6.4.2

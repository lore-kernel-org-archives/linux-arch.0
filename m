Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:29227 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526Ab0GMHQp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jul 2010 03:16:45 -0400
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 32/50] memblock: Prepare to include linux/memblock.h in core file
Date: Tue, 13 Jul 2010 00:10:26 -0700
Message-ID: <1279005044-24777-33-git-send-email-yinghai@kernel.org>
In-Reply-To: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
References: <1279005044-24777-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20100713071026.XnQV9YNSHaSjJKzAJXgzQtlBbq0Cri7TtiyxGw2evL4@z>

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


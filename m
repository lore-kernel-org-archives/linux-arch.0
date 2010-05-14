From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 05/37] lmb: Prepare to include linux/lmb.h in core file
Date: Fri, 14 May 2010 12:45:31 -0700
Message-ID: <1273866363-14249-6-git-send-email-yinghai@kernel.org>
References: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:59488 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab0ENTr6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2010 15:47:58 -0400
In-Reply-To: <1273866363-14249-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Be
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

Need to add protection in linux/lmb.h, to prepare to include it in
 mm/page_alloc.c and mm/bootmem.c etc.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/lmb.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/lmb.h b/include/linux/lmb.h
index d959d23..4c9c84a 100644
--- a/include/linux/lmb.h
+++ b/include/linux/lmb.h
@@ -2,6 +2,7 @@
 #define _LINUX_LMB_H
 #ifdef __KERNEL__
 
+#ifdef CONFIG_HAVE_LMB
 /*
  * Logical memory blocks.
  *
@@ -143,6 +144,8 @@ static inline unsigned long lmb_region_pages(const struct lmb_region *reg)
 	     region++)
 
 
+#endif /* CONFIG_HAVE_LMB */
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_LMB_H */
-- 
1.6.4.2

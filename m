Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:27641 "EHLO
	rcsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab0DIGHH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2010 02:07:07 -0400
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 13/39] lmb: Prepare to include linux/lmb.h in core file
Date: Thu,  8 Apr 2010 23:03:42 -0700
Message-ID: <1270793048-23796-14-git-send-email-yinghai@kernel.org>
In-Reply-To: <1270793048-23796-1-git-send-email-yinghai@kernel.org>
References: <1270793048-23796-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Message-ID: <20100409060342.ThOKfpA7huIoTdt4f6CiLVQppV0tvDVYqHZN2GA5g2M@z>

Need to add protection in linux/lmb.h, to prepare to include it in
 mm/page_alloc.c and mm/bootmem.c etc.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/lmb.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/lmb.h b/include/linux/lmb.h
index cf8f7ca..5dbc4ef 100644
--- a/include/linux/lmb.h
+++ b/include/linux/lmb.h
@@ -2,6 +2,7 @@
 #define _LINUX_LMB_H
 #ifdef __KERNEL__
 
+#ifdef CONFIG_HAVE_LMB
 /*
  * Logical memory blocks.
  *
@@ -101,6 +102,8 @@ u64 lmb_hole_size(u64 start, u64 end);
 
 #include <asm/lmb.h>
 
+#endif /* CONFIG_HAVE_LMB */
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_LMB_H */
-- 
1.6.4.2


Return-Path: <James.Bottomley@steeleye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:2750 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266762AbUFYP10 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Jun 2004 11:27:26 -0400
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/linuxconf) with ESMTP id i5PFRPi20729
	for <linux-arch@vger.kernel.org>; Fri, 25 Jun 2004 11:27:25 -0400
Subject: [PATCH] dma_get_required_mask()
From: James Bottomley <James.Bottomley@steeleye.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 25 Jun 2004 10:27:29 -0500
Message-Id: <1088177249.2217.29.camel@mulgrave>
Mime-Version: 1.0
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

[copy of email sent to linux-kernel and linux-scsi for notice only,
please discuss on the public thread]

Following the discussion, this is a patch implementing
dma_get_required_mask().  The default implementation simply works out
the largest mask covering all of memory and returns the and of that with
the current dma_mask.  If this looks OK, I'll send out another patch
including the documentation updates as well.

I've put the implementation in linux/dma-mapping.h with a
ARCH_HAS_DMA_GET_REQUIRED_MASK override for those architectures that
would like to do something different.

Any opinions on whether I should also make linux/dma-mapping.h include
linux/bitops.h now since it requires fls() from there?

James

===== include/linux/dma-mapping.h 1.3 vs edited =====
--- 1.3/include/linux/dma-mapping.h	2004-03-30 20:53:54 -05:00
+++ edited/include/linux/dma-mapping.h	2004-06-25 11:12:30 -04:00
@@ -19,6 +19,29 @@
 #define dma_sync_single		dma_sync_single_for_cpu
 #define dma_sync_sg		dma_sync_sg_for_cpu
 
+#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
+static inline u64 dma_get_required_mask(struct device *dev)
+{
+	extern unsigned long max_pfn; /* defined in bootmem.h but may
+					 not be included */
+	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
+	u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));
+	u64 mask;
+
+	if (!high_totalram) {
+		/* convert to mask just covering totalram */
+		low_totalram = (1 << (fls(low_totalram) - 1));
+		low_totalram += low_totalram - 1;
+		mask = low_totalram;
+	} else {
+		high_totalram = (1 << (fls(high_totalram) - 1));
+		high_totalram += high_totalram - 1;
+		mask = (((u64)high_totalram) << 32) + 0xffffffff;
+	}
+	return mask & *dev->dma_mask;
+}
+#endif
+		
 #endif
 

From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 01/37] parisc: use get/put_endian helpers
Date: Thu, 29 May 2008 13:17:51 -0700
Message-ID: <1212092271.28403.103.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43327 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYE2URz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:17:55 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392252yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:17:54 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Kyle McMartin <kyle@mcmartin.ca>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 arch/parisc/lib/iomap.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/lib/iomap.c b/arch/parisc/lib/iomap.c
index 9abed07..8ef05be 100644
--- a/arch/parisc/lib/iomap.c
+++ b/arch/parisc/lib/iomap.c
@@ -278,7 +278,7 @@ unsigned int ioread16(void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr)))
 		return iomap_ops[ADDR_TO_REGION(addr)]->read16(addr);
-	return le16_to_cpup((u16 *)addr);
+	return get_le16((__le16 *)addr);
 }
 
 unsigned int ioread16be(void __iomem *addr)
@@ -292,7 +292,7 @@ unsigned int ioread32(void __iomem *addr)
 {
 	if (unlikely(INDIRECT_ADDR(addr)))
 		return iomap_ops[ADDR_TO_REGION(addr)]->read32(addr);
-	return le32_to_cpup((u32 *)addr);
+	return get_le32((__le32 *)addr);
 }
 
 unsigned int ioread32be(void __iomem *addr)
@@ -316,7 +316,7 @@ void iowrite16(u16 datum, void __iomem *addr)
 	if (unlikely(INDIRECT_ADDR(addr))) {
 		iomap_ops[ADDR_TO_REGION(addr)]->write16(datum, addr);
 	} else {
-		*((u16 *)addr) = cpu_to_le16(datum);
+		put_le16(datum, (__le16 *)addr);
 	}
 }
 
@@ -334,7 +334,7 @@ void iowrite32(u32 datum, void __iomem *addr)
 	if (unlikely(INDIRECT_ADDR(addr))) {
 		iomap_ops[ADDR_TO_REGION(addr)]->write32(datum, addr);
 	} else {
-		*((u32 *)addr) = cpu_to_le32(datum);
+		put_le32(datum, (__le32 *)addr);
 	}
 }
 
-- 
1.5.6.rc0.277.g804cf

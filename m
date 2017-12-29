Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57995 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932879AbdL2IXP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Dec 2017 03:23:15 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 51/67] set_memory.h: provide set_memory_{en,de}crypted stubs
Date: Fri, 29 Dec 2017 09:18:55 +0100
Message-ID: <20171229081911.2802-52-hch@lst.de>
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20171229081855.w-S_z8gdh-wKciDYguq6wGIRiuMdeyk4w0TJBwn14oc@z>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/set_memory.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index e5140648f638..da5178216da5 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -17,4 +17,16 @@ static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+#ifndef CONFIG_ARCH_HAS_MEM_ENCRYPT
+static inline int set_memory_encrypted(unsigned long addr, int numpages)
+{
+	return 0;
+}
+
+static inline int set_memory_decrypted(unsigned long addr, int numpages)
+{
+	return 0;
+}
+#endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
+
 #endif /* _LINUX_SET_MEMORY_H_ */
-- 
2.14.2

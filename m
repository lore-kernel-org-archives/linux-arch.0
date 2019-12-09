Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:51342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfLIN62 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 08:58:28 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] MIPS: define ioremap_nocache to ioremap
Date: Mon,  9 Dec 2019 14:58:21 +0100
Message-ID: <20191209135823.28465-2-hch@lst.de>
In-Reply-To: <20191209135823.28465-1-hch@lst.de>
References: <20191209135823.28465-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20191209135821.aAMSZxSdQstzKqGKoO6IDkS1JfXHTVIODskbIG5NpiU@z>

They are both defined the same way, but this makes it easier to validate
the scripted ioremap_nocache removal following soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/io.h | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 3f6ce74335b4..d9caa811a2fa 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -227,29 +227,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
  */
 #define ioremap(offset, size)						\
 	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
-
-/*
- * ioremap_nocache     -   map bus memory into CPU space
- * @offset:    bus address of the memory
- * @size:      size of the resource to map
- *
- * ioremap_nocache performs a platform specific sequence of operations to
- * make bus memory CPU accessible via the readb/readw/readl/writeb/
- * writew/writel functions and the other mmio helpers. The returned
- * address is not guaranteed to be usable directly as a virtual
- * address.
- *
- * This version of ioremap ensures that the memory is marked uncachable
- * on the CPU as well as honouring existing caching rules from things like
- * the PCI bus. Note that there are other caches and buffers on many
- * busses. In particular driver authors should read up on PCI writes
- *
- * It's useful if some control registers are in such an area and
- * write combining or read caching is not desirable:
- */
-#define ioremap_nocache(offset, size)					\
-	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
-#define ioremap_uc ioremap_nocache
+#define ioremap_nocache		ioremap
+#define ioremap_uc		ioremap
 
 /*
  * ioremap_cache -	map bus memory into CPU space
-- 
2.20.1

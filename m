Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44089 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754304AbeALImt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jan 2018 03:42:49 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/34] m32r: remove unused flush_write_buffers definition
Date: Fri, 12 Jan 2018 09:42:01 +0100
Message-ID: <20180112084232.2857-4-hch@lst.de>
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180112084201.NoQkSBmkbdcrNiD2Df001wCNPKyKGQn6_chbqmVOLBM@z>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m32r/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
index 1b653bb16f9a..a4272d8f0d9c 100644
--- a/arch/m32r/include/asm/io.h
+++ b/arch/m32r/include/asm/io.h
@@ -191,8 +191,6 @@ static inline void _writel(unsigned long l, unsigned long addr)
 
 #define mmiowb()
 
-#define flush_write_buffers() do { } while (0)  /* M32R_FIXME */
-
 static inline void
 memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
-- 
2.14.2

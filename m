From: akpm@linux-foundation.org
Subject: [patch 157/177] dma-mapping: parisc: set ARCH_DMA_MINALIGN
Date: Tue, 10 Aug 2010 18:03:23 -0700
Message-ID: <201008110103.o7B13NF1027480@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34953 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932314Ab0HKBYu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Aug 2010 21:24:50 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, fujita.tomonori@lab.ntt.co.jp, deller@gmx.de, jejb@parisc-linux.org, kyle@mcmartin.ca, linux-arch@vger.kernel.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Architectures that handle DMA-non-coherent memory need to set
ARCH_DMA_MINALIGN to make sure that kmalloc'ed buffer is DMA-safe: the
buffer doesn't share a cache with the others.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/parisc/include/asm/cache.h |    2 ++
 1 file changed, 2 insertions(+)

diff -puN arch/parisc/include/asm/cache.h~dma-mapping-parisc-set-arch_dma_minalign arch/parisc/include/asm/cache.h
--- a/arch/parisc/include/asm/cache.h~dma-mapping-parisc-set-arch_dma_minalign
+++ a/arch/parisc/include/asm/cache.h
@@ -28,6 +28,8 @@
 
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
 
+#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
+
 #define __read_mostly __attribute__((__section__(".data..read_mostly")))
 
 void parisc_cache_init(void);	/* initializes cache-flushing */
_

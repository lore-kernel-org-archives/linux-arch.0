From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 2/3] block: kill ISA_DMA_THRESHOLD usage
Date: Mon, 31 May 2010 15:59:03 +0900
Message-ID: <1275289144-28782-3-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1275289144-28782-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1275289144-28782-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jens.axboe@oracle.com, James.Bottomley@suse.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
List-Id: linux-arch.vger.kernel.org

block uses ISA_DMA_THRESHOLD for BLK_BOUNCE_ISA. Only SCSI uses
ISA_DMA_THRESHOLD for ancient drivers with non-zero
unchecked_isa_dma. Nowadays drivers (and subsystems) use dma_mask
properly instead of ISA_DMA_THRESHOLD.

Documentation/scsi/scsi_mid_low_api.txt says:

unchecked_isa_dma - 1=>only use bottom 16 MB of ram (ISA DMA addressing
                   restriction), 0=>can use full 32 bit (or better) DMA
                   address space

So block simply uses DMA_BIT_MASK(24) for BLK_BOUNCE_ISA for SCSI.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 include/linux/blkdev.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8b7f5e0..f95bdd1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -709,7 +709,7 @@ extern unsigned long blk_max_low_pfn, blk_max_pfn;
 #define BLK_BOUNCE_HIGH		-1ULL
 #endif
 #define BLK_BOUNCE_ANY		(-1ULL)
-#define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
+#define BLK_BOUNCE_ISA		(DMA_BIT_MASK(24))
 
 /*
  * default timeout for SG_IO if none specified
-- 
1.6.5

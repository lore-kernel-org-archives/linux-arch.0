From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 1/2] scsi: remove dma_is_consistent usage in 53c700
Date: Sun, 27 Jun 2010 19:10:22 +0900
Message-ID: <1277633423-5700-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: grundler@parisc-linux.org, lethal@linux-sh.org, JBottomley@novell.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp
List-Id: linux-arch.vger.kernel.org

53c700 is the only user of dma_is_consistent():

BUG_ON(!dma_is_consistent(hostdata->dev, pScript) && L1_CACHE_BYTES < dma_get_cache_alignment());

The above code tries to see if the system can allocate coherent memory
or not. It's for some old systems that can't allocate coherent memory
at all (e.g some parisc systems).

I think that we can safely remove the above usage:

- such old systems haven't triger the above checking for long.

- the above condition is important for systems that can't allocate
  coherent memory if these systems do DMA. So probably it would be
  better to have such checking in arch's DMA initialization code
  instead of a driver.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 drivers/scsi/53c700.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 80dc3ac..89fc1c8 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -309,9 +309,6 @@ NCR_700_detect(struct scsi_host_template *tpnt,
 	hostdata->msgin = memory + MSGIN_OFFSET;
 	hostdata->msgout = memory + MSGOUT_OFFSET;
 	hostdata->status = memory + STATUS_OFFSET;
-	/* all of these offsets are L1_CACHE_BYTES separated.  It is fatal
-	 * if this isn't sufficient separation to avoid dma flushing issues */
-	BUG_ON(!dma_is_consistent(hostdata->dev, pScript) && L1_CACHE_BYTES < dma_get_cache_alignment());
 	hostdata->slots = (struct NCR_700_command_slot *)(memory + SLOTS_OFFSET);
 	hostdata->dev = dev;
 
-- 
1.6.5

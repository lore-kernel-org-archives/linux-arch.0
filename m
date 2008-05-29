From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 05/37] ata: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:02 -0700
Message-ID: <1212092282.28403.107.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Sender: linux-ide-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide <linux-ide@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/ata/pdc_adma.c   |   12 ++++++------
 drivers/ata/sata_qstor.c |   12 +++++-------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index be53545..162eecb 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -284,11 +284,11 @@ static int adma_fill_sg(struct ata_queued_cmd *qc)
 		u32 len;
 
 		addr = (u32)sg_dma_address(sg);
-		*(__le32 *)(buf + i) = cpu_to_le32(addr);
+		put_le32(addr, (__le32 *)(buf + i));
 		i += 4;
 
 		len = sg_dma_len(sg) >> 3;
-		*(__le32 *)(buf + i) = cpu_to_le32(len);
+		put_le32(len, (__le32 *)(buf + i));
 		i += 4;
 
 		last_buf = &buf[i];
@@ -297,8 +297,8 @@ static int adma_fill_sg(struct ata_queued_cmd *qc)
 		buf[i++] = 0;	/* pPKLW */
 		buf[i++] = 0;	/* reserved */
 
-		*(__le32 *)(buf + i) =
-			(pFLAGS & pEND) ? 0 : cpu_to_le32(pp->pkt_dma + i + 4);
+		put_le32((pFLAGS & pEND) ? 0 : pp->pkt_dma + i + 4,
+			 (__le32 *)(buf + i));
 		i += 4;
 
 		VPRINTK("PRD[%u] = (0x%lX, 0x%X)\n", i/4,
@@ -331,7 +331,7 @@ static void adma_qc_prep(struct ata_queued_cmd *qc)
 	buf[i++] = cVLD | cDAT | cIEN;
 	i++;		/* cLEN, gets filled in below */
 
-	*(__le32 *)(buf+i) = cpu_to_le32(pkt_dma);	/* cNCPB */
+	put_le32(pkt_dma, (__le32 *)(buf + i));	/* cNCPB */
 	i += 4;		/* cNCPB */
 	i += 4;		/* cPRD, gets filled in below */
 
@@ -369,7 +369,7 @@ static void adma_qc_prep(struct ata_queued_cmd *qc)
 	buf[i++] = ADMA_REGS_COMMAND | rEND;
 
 	buf[3] = (i >> 3) - 2;				/* cLEN */
-	*(__le32 *)(buf+8) = cpu_to_le32(pkt_dma + i);	/* cPRD */
+	put_le32(pkt_dma + i, (__le32 *)(buf + 8));	/* cPRD */
 
 	i = adma_fill_sg(qc);
 	wmb();	/* flush PRDs and pkt to memory */
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 1600107..7e3c4d5 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -277,11 +277,11 @@ static unsigned int qs_fill_sg(struct ata_queued_cmd *qc)
 		u32 len;
 
 		addr = sg_dma_address(sg);
-		*(__le64 *)prd = cpu_to_le64(addr);
+		put_le64(addr, (__le64 *)prd);
 		prd += sizeof(u64);
 
 		len = sg_dma_len(sg);
-		*(__le32 *)prd = cpu_to_le32(len);
+		put_le32(len, (__le32 *)prd);
 		prd += sizeof(u64);
 
 		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", si,
@@ -296,7 +296,6 @@ static void qs_qc_prep(struct ata_queued_cmd *qc)
 	struct qs_port_priv *pp = qc->ap->private_data;
 	u8 dflags = QS_DF_PORD, *buf = pp->pkt;
 	u8 hflags = QS_HF_DAT | QS_HF_IEN | QS_HF_VLD;
-	u64 addr;
 	unsigned int nelem;
 
 	VPRINTK("ENTER\n");
@@ -317,10 +316,9 @@ static void qs_qc_prep(struct ata_queued_cmd *qc)
 	/* host control block (HCB) */
 	buf[ 0] = QS_HCB_HDR;
 	buf[ 1] = hflags;
-	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nbytes);
-	*(__le32 *)(&buf[ 8]) = cpu_to_le32(nelem);
-	addr = ((u64)pp->pkt_dma) + QS_CPB_BYTES;
-	*(__le64 *)(&buf[16]) = cpu_to_le64(addr);
+	put_le32(qc->nbytes, (__le32 *)&buf[4]);
+	put_le32(nelem, (__le32 *)&buf[8]);
+	put_le64((u64)pp->pkt_dma + QS_CPB_BYTES, (__le64 *)&buf[16]);
 
 	/* device control block (DCB) */
 	buf[24] = QS_DCB_HDR;
-- 
1.5.6.rc0.277.g804cf



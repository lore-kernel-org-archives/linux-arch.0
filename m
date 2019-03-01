Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36062 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387822AbfCAOEz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Mar 2019 09:04:55 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 15/20] drivers: Remove useless trailing comments from mmiowb() invocations
Date: Fri,  1 Mar 2019 14:03:43 +0000
Message-ID: <20190301140348.25175-16-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-1-will.deacon@arm.com>
References: <20190301140348.25175-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190301140343._wL3gykYybXSeAHRboD96eGz1vEo8vheZS643Bzy4Og@z>

In preparation for using coccinelle to remove all mmiowb() instances
from drivers, remove all trailing comments since they won't be picked up
by spatch later on and will end up being preserved in the code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/infiniband/hw/hfi1/chip.c                | 2 +-
 drivers/infiniband/hw/qedr/verbs.c               | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h  | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c                   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index b443642eac02..955bad21a519 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -8352,7 +8352,7 @@ static inline void clear_recv_intr(struct hfi1_ctxtdata *rcd)
 	struct hfi1_devdata *dd = rcd->dd;
 	u32 addr = CCE_INT_CLEAR + (8 * rcd->ireg);
 
-	mmiowb();	/* make sure everything before is written */
+	mmiowb();
 	write_csr(dd, addr, rcd->imask);
 	/* force the above write on the chip and get a value back */
 	(void)read_csr(dd, addr);
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index e1ccf32b1c3d..23353e0e4bd4 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -3744,7 +3744,7 @@ int qedr_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 
 		if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
 			writel(qp->rq.iwarp_db2_data.raw, qp->rq.iwarp_db2);
-			mmiowb();	/* for second doorbell */
+			mmiowb();
 		}
 
 		wr = wr->next;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index 2462e7aa0c5d..1ed068509337 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -527,7 +527,7 @@ static inline void bnx2x_update_rx_prod(struct bnx2x *bp,
 		REG_WR_RELAXED(bp, fp->ustorm_rx_prods_offset + i * 4,
 			       ((u32 *)&rx_prods)[i]);
 
-	mmiowb(); /* keep prod updates ordered */
+	mmiowb();
 
 	DP(NETIF_MSG_RX_STATUS,
 	   "queue[%d]:  wrote  bd_prod %u  cqe_prod %u  sge_prod %u\n",
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 3b5b47e98c73..64bc6d6fcd65 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -5244,7 +5244,7 @@ static void bnx2x_update_eq_prod(struct bnx2x *bp, u16 prod)
 {
 	/* No memory barriers */
 	storm_memset_eq_prod(bp, prod, BP_FUNC(bp));
-	mmiowb(); /* keep prod updates ordered */
+	mmiowb();
 }
 
 static int  bnx2x_cnic_handle_cfc_del(struct bnx2x *bp, u32 cid,
diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c
index fae6f71e677d..d56a78f411cd 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -280,7 +280,7 @@ static void bnx2i_ring_sq_dbell(struct bnx2i_conn *bnx2i_conn, int count)
 	} else
 		writew(count, ep->qp.ctx_base + CNIC_SEND_DOORBELL);
 
-	mmiowb(); /* flush posted PCI writes */
+	mmiowb();
 }
 
 
-- 
2.11.0

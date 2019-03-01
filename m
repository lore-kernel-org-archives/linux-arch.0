Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36142 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387833AbfCAOFC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Mar 2019 09:05:02 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 17/20] scsi/qla1280: Remove stale comment about mmiowb()
Date: Fri,  1 Mar 2019 14:03:45 +0000
Message-ID: <20190301140348.25175-18-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-1-will.deacon@arm.com>
References: <20190301140348.25175-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190301140345.KBVpN98yrOdRb_VSuF926ONeyZP1ArFCgOWmrO745G8@z>

All mmiowb() invocations have been removed, so there's no need to keep
banging on about it.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/scsi/qla1280.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 93acbc5094f0..327eff67a1ee 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -3363,16 +3363,6 @@ qla1280_isp_cmd(struct scsi_qla_host *ha)
 
 	/*
 	 * Update request index to mailbox4 (Request Queue In).
-	 * The mmiowb() ensures that this write is ordered with writes by other
-	 * CPUs.  Without the mmiowb(), it is possible for the following:
-	 *    CPUA posts write of index 5 to mailbox4
-	 *    CPUA releases host lock
-	 *    CPUB acquires host lock
-	 *    CPUB posts write of index 6 to mailbox4
-	 *    On PCI bus, order reverses and write of 6 posts, then index 5,
-	 *       causing chip to issue full queue of stale commands
-	 * The mmiowb() prevents future writes from crossing the barrier.
-	 * See Documentation/driver-api/device-io.rst for more information.
 	 */
 	WRT_REG_WORD(&reg->mailbox4, ha->req_ring_index);
 
-- 
2.11.0

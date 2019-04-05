Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbfDEOBF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Apr 2019 10:01:05 -0400
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 19/21] i40iw: Redefine i40iw_mmiowb() to do nothing
Date: Fri,  5 Apr 2019 14:59:34 +0100
Message-ID: <20190405135936.7266-20-will.deacon@arm.com>
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190405135934.SjuJ0EKQNUv2pF0sN76fKbLnOPyXhbN1LpeTEh9dpf4@z>

mmiowb() is now implicit in spin_unlock(), so there's no reason to call
it from driver code. Redefine i40iw_mmiowb() to do nothing instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/infiniband/hw/i40iw/i40iw_osdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_osdep.h b/drivers/infiniband/hw/i40iw/i40iw_osdep.h
index f27be3e7830b..d474aad62a81 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_osdep.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_osdep.h
@@ -211,7 +211,7 @@ enum i40iw_status_code i40iw_hw_manage_vf_pble_bp(struct i40iw_device *iwdev,
 struct i40iw_sc_vsi;
 void i40iw_hw_stats_start_timer(struct i40iw_sc_vsi *vsi);
 void i40iw_hw_stats_stop_timer(struct i40iw_sc_vsi *vsi);
-#define i40iw_mmiowb() mmiowb()
+#define i40iw_mmiowb() do { } while (0)
 void i40iw_wr32(struct i40iw_hw *hw, u32 reg, u32 value);
 u32  i40iw_rd32(struct i40iw_hw *hw, u32 reg);
 #endif				/* _I40IW_OSDEP_H_ */
-- 
2.11.0

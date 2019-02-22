Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39734 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfBVSvj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:51:39 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 18/20] i40iw: Redefine i40iw_mmiowb() to do nothing
Date: Fri, 22 Feb 2019 18:50:24 +0000
Message-ID: <20190222185026.10973-19-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190222185024.OH3Qz7TO5XkJ3_V551uAbeNlby-0vyyZ9VzW-0JirY8@z>

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

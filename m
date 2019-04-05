Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbfDEOBJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Apr 2019 10:01:09 -0400
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 20/21] net/ethernet/silan/sc92031: Remove stale comment about mmiowb()
Date: Fri,  5 Apr 2019 14:59:35 +0100
Message-ID: <20190405135936.7266-21-will.deacon@arm.com>
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190405135935.4C_tuCF9t8gCyImyajemxEWwp7wjt5XSHz2VWJmeuao@z>

mmiowb() is no more. It has ceased to be. It is an ex-barrier. So remove
all references to it from comments.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/net/ethernet/silan/sc92031.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/silan/sc92031.c b/drivers/net/ethernet/silan/sc92031.c
index db5dc8ce0aff..02b3962b0e63 100644
--- a/drivers/net/ethernet/silan/sc92031.c
+++ b/drivers/net/ethernet/silan/sc92031.c
@@ -251,7 +251,6 @@ enum PMConfigBits {
  * use of mdelay() at _sc92031_reset.
  * Functions prefixed with _sc92031_ must be called with the lock held;
  * functions prefixed with sc92031_ must be called without the lock held.
- * Use mmiowb() before unlocking if the hardware was written to.
  */
 
 /* Locking rules for the interrupt:
-- 
2.11.0

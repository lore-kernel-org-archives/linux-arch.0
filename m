Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35708 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388442AbfCAOEX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Mar 2019 09:04:23 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 06/20] x86/io: Remove useless definition of mmiowb()
Date: Fri,  1 Mar 2019 14:03:34 +0000
Message-ID: <20190301140348.25175-7-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-1-will.deacon@arm.com>
References: <20190301140348.25175-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190301140334.hzRkndE2R93rBKXUUZpRSUBdg7YAUaL_JU-qnVsRl6E@z>

x86 maps mmiowb() to barrier(), but this is superfluous because a
compiler barrier is already implied by spin_unlock(). Since x86 also
includes asm-generic/io.h in its asm/io.h file, we can remove the
definition entirely and pick up the dummy definition from core code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/x86/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 686247db3106..a06a9f8294ea 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -90,8 +90,6 @@ build_mmio_write(__writel, "l", unsigned int, "r", )
 #define __raw_writew __writew
 #define __raw_writel __writel
 
-#define mmiowb() barrier()
-
 #ifdef CONFIG_X86_64
 
 build_mmio_read(readq, "q", u64, "=r", :"memory")
-- 
2.11.0

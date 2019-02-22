Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVSu7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:50:59 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 07/20] nds32: io: Remove useless definition of mmiowb()
Date: Fri, 22 Feb 2019 18:50:13 +0000
Message-ID: <20190222185026.10973-8-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190222185013.s_jHOmKtMG-fgxiL-TydwLZeSpSxwOELCrNoXYENaUs@z>

mmiowb() only makes sense for SMP platforms, so we can remove it
entirely for nds32.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/nds32/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
index 71cd226d6863..5ef8ae5ba833 100644
--- a/arch/nds32/include/asm/io.h
+++ b/arch/nds32/include/asm/io.h
@@ -55,8 +55,6 @@ static inline u32 __raw_readl(const volatile void __iomem *addr)
 #define __iormb()               rmb()
 #define __iowmb()               wmb()
 
-#define mmiowb()        __asm__ __volatile__ ("msync all" : : : "memory");
-
 /*
  * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
  * are not guaranteed to provide ordering against spinlocks or memory
-- 
2.11.0

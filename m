From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 05/20] arm64: io: Remove useless definition of mmiowb()
Date: Fri, 22 Feb 2019 18:50:11 +0000
Message-ID: <20190222185026.10973-6-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

arm64 includes asm-generic/io.h, which provides a dummy definition of
mmiowb() if one isn't already provided by the architecture.

Remove the useless definition.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 8bb7210ac286..b807cb9b517d 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -124,8 +124,6 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define __io_par(v)		__iormb(v)
 #define __iowmb()		wmb()
 
-#define mmiowb()		do { } while (0)
-
 /*
  * Relaxed I/O memory access primitives. These follow the Device memory
  * ordering rules but do not guarantee any ordering relative to Normal memory
-- 
2.11.0

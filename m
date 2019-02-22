Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfBVSvq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:51:46 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 20/20] arch: Remove dummy mmiowb() definitions from arch code
Date: Fri, 22 Feb 2019 18:50:26 +0000
Message-ID: <20190222185026.10973-21-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190222185026.VFFZiYLJcDeQDrI3BifCJyWg7DEBpauQRLudhUnW4-0@z>

Now that no driver code is using mmiowb() directly, we can remove the
dummy definitions from the architectures that don't make use of
asm-generic/io.h

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/alpha/include/asm/io.h    | 2 --
 arch/hexagon/include/asm/io.h  | 2 --
 arch/parisc/include/asm/io.h   | 2 --
 arch/sparc/include/asm/io_64.h | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 4c533fc94d62..ccf9d65166bb 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -513,8 +513,6 @@ extern inline void writeq(u64 b, volatile void __iomem *addr)
 #define writel_relaxed(b, addr)	__raw_writel(b, addr)
 #define writeq_relaxed(b, addr)	__raw_writeq(b, addr)
 
-#define mmiowb()
-
 /*
  * String version of IO memory access ops:
  */
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index e17262ad125e..3d0ae09c2b8e 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -184,8 +184,6 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define writew_relaxed __raw_writew
 #define writel_relaxed __raw_writel
 
-#define mmiowb()
-
 /*
  * Need an mtype somewhere in here, for cache type deals?
  * This is probably too long for an inline.
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index afe493b23d04..b163043d49db 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -229,8 +229,6 @@ static inline void writeq(unsigned long long q, volatile void __iomem *addr)
 #define writel_relaxed(l, addr)	writel(l, addr)
 #define writeq_relaxed(q, addr)	writeq(q, addr)
 
-#define mmiowb() do { } while (0)
-
 void memset_io(volatile void __iomem *addr, unsigned char val, int count);
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index b162c23ae8c2..688911051b44 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -396,8 +396,6 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
 	}
 }
 
-#define mmiowb()
-
 #ifdef __KERNEL__
 
 /* On sparc64 we have the whole physical IO address space accessible
-- 
2.11.0

From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 09/21] m68k/io: Remove useless definition of mmiowb()
Date: Fri,  5 Apr 2019 14:59:24 +0100
Message-ID: <20190405135936.7266-10-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatoc>
List-Id: linux-arch.vger.kernel.org

m68k includes asm-generic/io.h, which provides a dummy definition of
mmiowb() if one isn't already provided by the architecture.

Remove the useless definition.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/m68k/include/asm/io_mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index 782b78f8a048..6c03ca5bc436 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -377,8 +377,6 @@ static inline void isa_delay(void)
 #define writesw(port, buf, nr)    raw_outsw((port), (u16 *)(buf), (nr))
 #define writesl(port, buf, nr)    raw_outsl((port), (u32 *)(buf), (nr))
 
-#define mmiowb()
-
 #ifndef CONFIG_SUN3
 #define IO_SPACE_LIMIT 0xffff
 #else
-- 
2.11.0

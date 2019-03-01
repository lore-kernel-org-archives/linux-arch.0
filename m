Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35626 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733126AbfCAOEQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Mar 2019 09:04:16 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 04/20] ARM/io: Remove useless definition of mmiowb()
Date: Fri,  1 Mar 2019 14:03:32 +0000
Message-ID: <20190301140348.25175-5-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-1-will.deacon@arm.com>
References: <20190301140348.25175-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190301140332.WJrp_k0GSRJN96V5f5KUcCzxdM3wCiRnXEskIPEalII@z>

ARM includes asm-generic/io.h, which provides a dummy definition of
mmiowb() if one isn't already provided by the architecture.

Remove the useless definition.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 6b51826ab3d1..7e22c81398c4 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -281,8 +281,6 @@ extern void _memcpy_fromio(void *, const volatile void __iomem *, size_t);
 extern void _memcpy_toio(volatile void __iomem *, const void *, size_t);
 extern void _memset_io(volatile void __iomem *, int, size_t);
 
-#define mmiowb()
-
 /*
  *  Memory access primitives
  *  ------------------------
-- 
2.11.0

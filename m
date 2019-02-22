From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 3/3] arm64: io: Hook up __io_par() for inX() ordering
Date: Fri, 22 Feb 2019 18:04:54 +0000
Message-ID: <20190222180454.5992-4-will.deacon@arm.com>
References: <20190222180454.5992-1-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222180454.5992-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de, catalin.marinas@arm.com, geert@linux-m68k.org, palmer@sifive.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

Ensure that inX() provides the same ordering guarantees as readX()
by hooking up __io_par() so that it maps directly to __iormb().

Reported-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index ee723835c1f4..8bb7210ac286 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -121,6 +121,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 		     : "memory");					\
 })
 
+#define __io_par(v)		__iormb(v)
 #define __iowmb()		wmb()
 
 #define mmiowb()		do { } while (0)
-- 
2.11.0

From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 12/18] parisc: io: implement dummy relaxed accessor macros for writes
Date: Thu, 17 Apr 2014 14:44:15 +0100
Message-ID: <1397742261-15621-13-git-send-email-will.deacon@arm.com>
References: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, monstr@monstr.eu, dhowells@redhat.com, broonie@linaro.org, benh@kernel.crashing.org, peterz@infradead.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>, Helge Deller <deller@gmx.de>
List-Id: linux-arch.vger.kernel.org

write{b,w,l,q}_relaxed are implemented by some architectures in order to
permit memory-mapped I/O accesses with weaker barrier semantics than the
non-relaxed variants.

This patch adds dummy macros for the write accessors to parisc, in the
same vein as the dummy definitions for the relaxed read accessors.

Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/parisc/include/asm/io.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 1f6d2ae7aba5..8cd0abf28ffb 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -217,10 +217,14 @@ static inline void writeq(unsigned long long q, volatile void __iomem *addr)
 #define writel	writel
 #define writeq	writeq
 
-#define readb_relaxed(addr) readb(addr)
-#define readw_relaxed(addr) readw(addr)
-#define readl_relaxed(addr) readl(addr)
-#define readq_relaxed(addr) readq(addr)
+#define readb_relaxed(addr)	readb(addr)
+#define readw_relaxed(addr)	readw(addr)
+#define readl_relaxed(addr)	readl(addr)
+#define readq_relaxed(addr)	readq(addr)
+#define writeb_relaxed(b, addr)	writeb(b, addr)
+#define writew_relaxed(w, addr)	writew(w, addr)
+#define writel_relaxed(l, addr)	writel(l, addr)
+#define writeq_relaxed(q, addr)	writeq(q, addr)
 
 #define mmiowb() do { } while (0)
 
-- 
1.9.1

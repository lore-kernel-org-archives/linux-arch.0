From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 07/18] cris: io: implement dummy relaxed accessor macros for writes
Date: Thu, 17 Apr 2014 14:44:10 +0100
Message-ID: <1397742261-15621-8-git-send-email-will.deacon@arm.com>
References: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, monstr@monstr.eu, dhowells@redhat.com, broonie@linaro.org, benh@kernel.crashing.org, peterz@infradead.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-arch.vger.kernel.org

write{b,w,l}_relaxed are implemented by some architectures in order to
permit memory-mapped I/O accesses with weaker barrier semantics than the
non-relaxed variants.

This patch adds dummy macros for the write accessors to Cris, in the same
vein as the dummy definitions for the relaxed read accessors.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/cris/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/cris/include/asm/io.h b/arch/cris/include/asm/io.h
index e59dba12ce94..752a3f45df60 100644
--- a/arch/cris/include/asm/io.h
+++ b/arch/cris/include/asm/io.h
@@ -112,6 +112,9 @@ static inline void writel(unsigned int b, volatile void __iomem *addr)
 	else
 		*(volatile unsigned int __force *) addr = b;
 }
+#define writeb_relaxed(b, addr) writeb(b, addr)
+#define writew_relaxed(b, addr) writew(b, addr)
+#define writel_relaxed(b, addr) writel(b, addr)
 #define __raw_writeb writeb
 #define __raw_writew writew
 #define __raw_writel writel
-- 
1.9.1

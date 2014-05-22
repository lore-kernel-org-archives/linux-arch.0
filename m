From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 15/18] tile: io: implement dummy relaxed accessor macros for writes
Date: Thu, 22 May 2014 17:47:27 +0100
Message-ID: <1400777250-17335-16-git-send-email-will.deacon@arm.com>
References: <1400777250-17335-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400777250-17335-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, monstr@monstr.eu, dhowells@redhat.com, broonie@linaro.org, benh@kernel.crashing.org, peterz@infradead.org, paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

write{b,w,l,q}_relaxed are implemented by some architectures in order to
permit memory-mapped I/O accesses with weaker barrier semantics than the
non-relaxed variants.

This patch adds dummy macros for the write accessors to tile, in the
same vein as the dummy definitions for the relaxed read accessors.

Acked-by: Chris Metcalf <cmetcalf@tilera.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/tile/include/asm/io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/tile/include/asm/io.h b/arch/tile/include/asm/io.h
index 9fe434969fab..d372641054d9 100644
--- a/arch/tile/include/asm/io.h
+++ b/arch/tile/include/asm/io.h
@@ -241,6 +241,10 @@ static inline void writeq(u64 val, unsigned long addr)
 #define readw_relaxed readw
 #define readl_relaxed readl
 #define readq_relaxed readq
+#define writeb_relaxed writeb
+#define writew_relaxed writew
+#define writel_relaxed writel
+#define writeq_relaxed writeq
 
 #define ioread8 readb
 #define ioread16 readw
-- 
1.9.2

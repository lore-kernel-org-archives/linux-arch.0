From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH v2 1/2] io: prevent compiler reordering on the default writeX() implementation
Date: Fri, 30 Mar 2018 11:58:12 -0400
Message-ID: <1522425494-2916-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The default implementation of mapping writeX() to __raw_writeX() is wrong.
writeX() has stronger ordering semantics. Compiler is allowed to reorder
__raw_writeX().

In the abscence of a write barrier or when using a strongly ordered
architecture, writeX() should at least have a compiler barrier in
it to prevent commpiler from clobbering the execution order.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index b4531e3..e8c2078 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -144,6 +144,7 @@ static inline u64 readq(const volatile void __iomem *addr)
 #define writeb writeb
 static inline void writeb(u8 value, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writeb(value, addr);
 }
 #endif
@@ -152,6 +153,7 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 #define writew writew
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writew(cpu_to_le16(value), addr);
 }
 #endif
@@ -160,6 +162,7 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 #define writel writel
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writel(__cpu_to_le32(value), addr);
 }
 #endif
@@ -169,6 +172,7 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define writeq writeq
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
+	barrier();
 	__raw_writeq(__cpu_to_le64(value), addr);
 }
 #endif
-- 
2.7.4

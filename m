From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH v2 2/2] io: prevent compiler reordering on the default readX() implementation
Date: Fri, 30 Mar 2018 11:58:13 -0400
Message-ID: <1522425494-2916-2-git-send-email-okaya@codeaurora.org>
References: <1522425494-2916-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522425494-2916-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The default implementation of mapping readX() to __raw_readX() is wrong.
readX() has stronger ordering semantics. Compiler is allowed to reorder
__raw_readX().

In the abscence of a read barrier or when using a strongly ordered
architecture, readX() should at least have a compiler barrier in
it to prevent commpiler from clobbering the execution order.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index e8c2078..2554f15 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -110,7 +110,12 @@ static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
 #define readb readb
 static inline u8 readb(const volatile void __iomem *addr)
 {
-	return __raw_readb(addr);
+	u8 val;
+
+	val = __raw_readb(addr);
+	barrier();
+
+	return val;
 }
 #endif
 
@@ -118,7 +123,12 @@ static inline u8 readb(const volatile void __iomem *addr)
 #define readw readw
 static inline u16 readw(const volatile void __iomem *addr)
 {
-	return __le16_to_cpu(__raw_readw(addr));
+	u16 val;
+
+	val = __le16_to_cpu(__raw_readw(addr));
+	barrier();
+
+	return val;
 }
 #endif
 
@@ -126,7 +136,12 @@ static inline u16 readw(const volatile void __iomem *addr)
 #define readl readl
 static inline u32 readl(const volatile void __iomem *addr)
 {
-	return __le32_to_cpu(__raw_readl(addr));
+	u32 val;
+
+	val = __le32_to_cpu(__raw_readl(addr));
+	barrier();
+
+	return val;
 }
 #endif
 
@@ -135,7 +150,12 @@ static inline u32 readl(const volatile void __iomem *addr)
 #define readq readq
 static inline u64 readq(const volatile void __iomem *addr)
 {
-	return __le64_to_cpu(__raw_readq(addr));
+	u64 val;
+
+	val = __le64_to_cpu(__raw_readq(addr));
+	barrier();
+
+	return val;
 }
 #endif
 #endif /* CONFIG_64BIT */
-- 
2.7.4

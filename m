From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH v4 2/5] io: define stronger ordering for the default readX() implementation
Date: Thu,  5 Apr 2018 09:09:10 -0400
Message-ID: <1522933753-19589-2-git-send-email-okaya@codeaurora.org>
References: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The default implementation of mapping readX() to __raw_readX() is wrong.
readX() has stronger ordering semantics. Compiler is allowed to reorder
__raw_readX() against the memory accesses following register read.

Use the previously defined __io_ar() and __io_br() macros to harden
code generation according to architecture support.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 570433b..d27e8af 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -154,7 +154,12 @@ static inline void __raw_writeq(u64 value, volatile void __iomem *addr)
 #define readb readb
 static inline u8 readb(const volatile void __iomem *addr)
 {
-	return __raw_readb(addr);
+	u8 val;
+
+	__io_br();
+	val = __raw_readb(addr);
+	__io_ar();
+	return val;
 }
 #endif
 
@@ -162,7 +167,12 @@ static inline u8 readb(const volatile void __iomem *addr)
 #define readw readw
 static inline u16 readw(const volatile void __iomem *addr)
 {
-	return __le16_to_cpu(__raw_readw(addr));
+	u16 val;
+
+	__io_br();
+	val = __le16_to_cpu(__raw_readw(addr));
+	__io_ar();
+	return val;
 }
 #endif
 
@@ -170,7 +180,12 @@ static inline u16 readw(const volatile void __iomem *addr)
 #define readl readl
 static inline u32 readl(const volatile void __iomem *addr)
 {
-	return __le32_to_cpu(__raw_readl(addr));
+	u32 val;
+
+	__io_br();
+	val = __le32_to_cpu(__raw_readl(addr));
+	__io_ar();
+	return val;
 }
 #endif
 
@@ -179,7 +194,12 @@ static inline u32 readl(const volatile void __iomem *addr)
 #define readq readq
 static inline u64 readq(const volatile void __iomem *addr)
 {
-	return __le64_to_cpu(__raw_readq(addr));
+	u64 val;
+
+	__io_br();
+	val = __le64_to_cpu(__raw_readq(addr));
+	__io_ar();
+	return val;
 }
 #endif
 #endif /* CONFIG_64BIT */
-- 
2.7.4

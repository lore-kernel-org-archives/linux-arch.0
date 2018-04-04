From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH v3 3/5] io: define stronger ordering for the default writeX() implementation
Date: Wed,  4 Apr 2018 19:58:18 -0400
Message-ID: <1522886301-25955-3-git-send-email-okaya@codeaurora.org>
References: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The default implementation of mapping writeX() to __raw_writeX() is wrong.
writeX() has stronger ordering semantics. Compiler is allowed to reorder
memory writes against __raw_writeX().

Use the previously defined __io_aw() and __io_bw() macros to harden
code generation according to architecture support.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index fc554af..ca268d9 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -207,7 +207,9 @@ static inline u64 readq(const volatile void __iomem *addr)
 #define writeb writeb
 static inline void writeb(u8 value, volatile void __iomem *addr)
 {
+	__io_bw();
 	__raw_writeb(value, addr);
+	__io_aw();
 }
 #endif
 
@@ -215,7 +217,9 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 #define writew writew
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
+	__io_bw();
 	__raw_writew(cpu_to_le16(value), addr);
+	__io_aw();
 }
 #endif
 
@@ -223,7 +227,9 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 #define writel writel
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
+	__io_bw();
 	__raw_writel(__cpu_to_le32(value), addr);
+	__io_aw();
 }
 #endif
 
@@ -232,7 +238,9 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define writeq writeq
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
+	__io_bw();
 	__raw_writeq(__cpu_to_le64(value), addr);
+	__io_aw();
 }
 #endif
 #endif /* CONFIG_64BIT */
-- 
2.7.4

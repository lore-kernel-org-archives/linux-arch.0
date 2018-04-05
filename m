From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH v4 5/5] io: change inX() to have their own IO barrier overrides
Date: Thu,  5 Apr 2018 09:09:13 -0400
Message-ID: <1522933753-19589-5-git-send-email-okaya@codeaurora.org>
References: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Open code readX() inside inX() so that inX() variants have their own
overrideable Port IO barrier combinations as __io_pbr() and __io_par() for
actions to be taken before port IO and after port IO read.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 53226d9..578b688 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -433,7 +433,12 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 #define inb inb
 static inline u8 inb(unsigned long addr)
 {
-	return readb(PCI_IOBASE + addr);
+	u8 val;
+
+	__io_pbr();
+	val = __raw_readb(PCI_IOBASE + addr);
+	__io_par();
+	return val;
 }
 #endif
 
@@ -441,7 +446,12 @@ static inline u8 inb(unsigned long addr)
 #define inw inw
 static inline u16 inw(unsigned long addr)
 {
-	return readw(PCI_IOBASE + addr);
+	u16 val;
+
+	__io_pbr();
+	val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
+	__io_par();
+	return val;
 }
 #endif
 
@@ -449,7 +459,12 @@ static inline u16 inw(unsigned long addr)
 #define inl inl
 static inline u32 inl(unsigned long addr)
 {
-	return readl(PCI_IOBASE + addr);
+	u32 val;
+
+	__io_pbr();
+	val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
+	__io_par();
+	return val;
 }
 #endif
 
-- 
2.7.4

From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH v3 4/5] io: change outX() to have their own IO barrier overrides
Date: Wed,  4 Apr 2018 19:58:19 -0400
Message-ID: <1522886301-25955-4-git-send-email-okaya@codeaurora.org>
References: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Open code writeX() inside outX() so that outX() variants have their own
overrideable Port IO barrier combinations as __io_pbw() and __io_paw() for
actions to be taken before port IO and after port IO write.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index ca268d9..38a96d1 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -456,7 +456,9 @@ static inline u32 inl(unsigned long addr)
 #define outb outb
 static inline void outb(u8 value, unsigned long addr)
 {
-	writeb(value, PCI_IOBASE + addr);
+	__io_pbw();
+	__raw_writeb(value, PCI_IOBASE + addr);
+	__io_paw();
 }
 #endif
 
@@ -464,7 +466,9 @@ static inline void outb(u8 value, unsigned long addr)
 #define outw outw
 static inline void outw(u16 value, unsigned long addr)
 {
-	writew(value, PCI_IOBASE + addr);
+	__io_pbw();
+	__raw_writew(cpu_to_le16(value), PCI_IOBASE + addr);
+	__io_paw();
 }
 #endif
 
@@ -472,7 +476,9 @@ static inline void outw(u16 value, unsigned long addr)
 #define outl outl
 static inline void outl(u32 value, unsigned long addr)
 {
-	writel(value, PCI_IOBASE + addr);
+	__io_pbw();
+	__raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);
+	__io_paw();
 }
 #endif
 
-- 
2.7.4

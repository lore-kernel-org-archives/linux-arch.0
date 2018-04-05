Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38394 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeDENJX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Apr 2018 09:09:23 -0400
From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH v4 4/5] io: change outX() to have their own IO barrier overrides
Date: Thu,  5 Apr 2018 09:09:12 -0400
Message-ID: <1522933753-19589-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
References: <1522933753-19589-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180405130912.nIExnX8Aa2RVlm6H8sP6cgHaOVke-Ju75mt5MoIOYEE@z>

Open code writeX() inside outX() so that outX() variants have their own
overrideable Port IO barrier combinations as __io_pbw() and __io_paw() for
actions to be taken before port IO and after port IO write.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 include/asm-generic/io.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 964725e..53226d9 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -457,7 +457,9 @@ static inline u32 inl(unsigned long addr)
 #define outb outb
 static inline void outb(u8 value, unsigned long addr)
 {
-	writeb(value, PCI_IOBASE + addr);
+	__io_pbw();
+	__raw_writeb(value, PCI_IOBASE + addr);
+	__io_paw();
 }
 #endif
 
@@ -465,7 +467,9 @@ static inline void outb(u8 value, unsigned long addr)
 #define outw outw
 static inline void outw(u16 value, unsigned long addr)
 {
-	writew(value, PCI_IOBASE + addr);
+	__io_pbw();
+	__raw_writew(cpu_to_le16(value), PCI_IOBASE + addr);
+	__io_paw();
 }
 #endif
 
@@ -473,7 +477,9 @@ static inline void outw(u16 value, unsigned long addr)
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

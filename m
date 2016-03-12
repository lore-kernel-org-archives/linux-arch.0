From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Sat, 12 Mar 2016 09:50:01 +0530
Message-ID: <56E398F1.7090500@synopsys.com>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8F1A0@us01wembx1.internal.synopsys.com>
 <1457636268.457.34.camel@synopsys.com> <201603102023.59425.arnd@arndb.de>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8F790@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:54149 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbcCLEUS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 23:20:18 -0500
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E8F790@us01wembx1.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Lada Trimasova <Lada.Trimasova@synopsys.com>, "noamc@ezchip.com" <noamc@ezchip.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

On Friday 11 March 2016 06:14 PM, Vineet Gupta wrote:
> @Lada I will fix up the changelog to add some of the background behind this
> change, and mark this for stable backport as well.

This is what I'm planning to add.
Noam please give this a spin - you might have to revert those native-endian DT
bindings from UART DT.

----->
From f778cc65717687a3d3f26dd21bef62cd059f1b8b Mon Sep 17 00:00:00 2001
From: Lada Trimasova <ltrimas@synopsys.com>
Date: Wed, 9 Mar 2016 20:21:04 +0300
Subject: [PATCH] ARC: [BE] readl()/writel() to work in Big Endian CPU
 configuration

read{l,w}() write{l,w}() primitives should use le{16,32}_to_cpu() and
cpu_to_le{16,32}() respectively to ensure device registers are read
correctly in Big Endian CPU configuration.

Per Arnd Bergmann
| Most drivers using readl() or readl_relaxed() expect those to perform byte
| swaps on big-endian architectures, as the registers tend to be fixed endian

This was needed for getting UART to work correctly on a Big Endian ARC.

The ARC accessors originally were fine, and the bug got introduced
inadventently by commit b8a033023994 ("ARCv2: barriers")

Fixes: b8a033023994 ("ARCv2: barriers")
Link: http://lkml.kernel.org/r/201603100845.30602.arnd@arndb.de
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: stable@vger.kernel.org  [4.2+]
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lada Trimasova <ltrimas@synopsys.com>
[vgupta: beefed up changelog, added Fixes/stable tags]
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/io.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index 694ece8a0243..27b17adea50d 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -129,15 +129,23 @@ static inline void __raw_writel(u32 w, volatile void __iomem
*addr)
 #define writel(v,c)		({ __iowmb(); writel_relaxed(v,c); })

 /*
- * Relaxed API for drivers which can handle any ordering themselves
+ * Relaxed API for drivers which can handle barrier ordering themselves
+ *
+ * Also these are defined to perform little endian accesses.
+ * To provide the typical device register semantics of fixed endian,
+ * swap the byte order for Big Endian
+ *
+ * http://lkml.kernel.org/r/201603100845.30602.arnd@arndb.de
  */
 #define readb_relaxed(c)	__raw_readb(c)
-#define readw_relaxed(c)	__raw_readw(c)
-#define readl_relaxed(c)	__raw_readl(c)
+#define readw_relaxed(c) ({ u16 __r = le16_to_cpu((__force __le16) \
+					__raw_readw(c)); __r; })
+#define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
+					__raw_readl(c)); __r; })

 #define writeb_relaxed(v,c)	__raw_writeb(v,c)
-#define writew_relaxed(v,c)	__raw_writew(v,c)
-#define writel_relaxed(v,c)	__raw_writel(v,c)
+#define writew_relaxed(v,c)	__raw_writew((__force u16) cpu_to_le16(v),c)
+#define writel_relaxed(v,c)	__raw_writel((__force u32) cpu_to_le32(v),c)

 #include <asm-generic/io.h>

-- 
2.5.0

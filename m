From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v6 03/36] sparc: io: To use the define of ioremap_[nocache|wc|wb] in asm-generic/io.h
Date: Mon, 15 Jan 2018 13:53:11 +0800
Message-ID: <790e05e9b9675b3f6ef41693a794d1f09795c151.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39742 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932228AbeAOFyU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 00:54:20 -0500
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com

From: Greentime Hu <greentime@andestech.com>

It will be built failed if commit id: d25ea659 is selected. This patch
can fix this build error.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/sparc/include/asm/io_32.h |    5 -----
 arch/sparc/kernel/ioport.c     |    4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index cd51a89..df2dc17 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -127,12 +127,7 @@ static inline void sbus_memcpy_toio(volatile void __iomem *dst,
  * Bus number may be embedded in the higher bits of the physical address.
  * This is why we have no bus number argument to ioremap().
  */
-void __iomem *ioremap(unsigned long offset, unsigned long size);
-#define ioremap_nocache(X,Y)	ioremap((X),(Y))
-#define ioremap_wc(X,Y)		ioremap((X),(Y))
-#define ioremap_wt(X,Y)		ioremap((X),(Y))
 void iounmap(volatile void __iomem *addr);
-
 /* Create a virtual mapping cookie for an IO port range */
 void __iomem *ioport_map(unsigned long port, unsigned int nr);
 void ioport_unmap(void __iomem *);
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 7eeef80..3bcef9c 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -122,12 +122,12 @@ static void xres_free(struct xresource *xrp) {
  *
  * Bus type is always zero on IIep.
  */
-void __iomem *ioremap(unsigned long offset, unsigned long size)
+void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
 	char name[14];
 
 	sprintf(name, "phys_%08x", (u32)offset);
-	return _sparc_alloc_io(0, offset, size, name);
+	return _sparc_alloc_io(0, (unsigned long)offset, size, name);
 }
 EXPORT_SYMBOL(ioremap);
 
-- 
1.7.9.5

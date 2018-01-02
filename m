From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 03/39] sparc: io: To use the define of ioremap_[nocache|wc|wb] in asm-generic/io.h
Date: Tue,  2 Jan 2018 16:24:35 +0800
Message-ID: <790e05e9b9675b3f6ef41693a794d1f09795c151.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1514874857.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1514874857.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1514874857.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org, stefan.kristiansson-MbMCFXIvDHJFcC0YU169RA@public.gmane.org, shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>

It will be built failed if commit id: d25ea659 is selected. This patch
can fix this build error.

Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

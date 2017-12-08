From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 13/33] nds32: Device specific operations
Date: Fri,  8 Dec 2017 17:11:56 +0800
Message-ID: <014d45f905b26052e908a1eed5b9f6a975e6016c.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1512723245.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1512723245.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1512723245.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
Cc: green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>

This patch introduces ioremap implementations.

Signed-off-by: Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
---
 arch/nds32/include/asm/io.h |   96 +++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/mm/ioremap.c     |   75 +++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 arch/nds32/include/asm/io.h
 create mode 100644 arch/nds32/mm/ioremap.c

diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
new file mode 100644
index 0000000..16ff6a5
--- /dev/null
+++ b/arch/nds32/include/asm/io.h
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_NDS32_IO_H
+#define __ASM_NDS32_IO_H
+
+extern void iounmap(void __iomem *addr);
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
+{
+	asm volatile("sbi %0, [%1]" : : "r" (val), "r" (addr));
+}
+
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 val, volatile void __iomem *addr)
+{
+	asm volatile("shi %0, [%1]" : : "r" (val), "r" (addr));
+}
+
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 val, volatile void __iomem *addr)
+{
+	asm volatile("swi %0, [%1]" : : "r" (val), "r" (addr));
+}
+
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	u8 val;
+
+	asm volatile("lbi %0, [%1]" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	u16 val;
+
+	asm volatile("lhi %0, [%1]" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#define __raw_readl __raw_readl
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	u32 val;
+
+	asm volatile("lwi %0, [%1]" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+#define __iormb()               rmb()
+#define __iowmb()               wmb()
+
+#define mmiowb()        __asm__ __volatile__ ("msync all" : : : "memory");
+
+/*
+ * {read,write}{b,w,l,q}_relaxed() are like the regular version, but
+ * are not guaranteed to provide ordering against spinlocks or memory
+ * accesses.
+ */
+
+#define readb_relaxed(c)	({ u8  __v = __raw_readb(c); __v; })
+#define readw_relaxed(c)	({ u16 __v = le16_to_cpu((__force __le16)__raw_readw(c)); __v; })
+#define readl_relaxed(c)	({ u32 __v = le32_to_cpu((__force __le32)__raw_readl(c)); __v; })
+#define writeb_relaxed(v,c)	((void)__raw_writeb((v),(c)))
+#define writew_relaxed(v,c)	((void)__raw_writew((__force u16)cpu_to_le16(v),(c)))
+#define writel_relaxed(v,c)	((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
+
+/*
+ * {read,write}{b,w,l,q}() access little endian memory and return result in
+ * native endianness.
+ */
+#define readb(c)	({ u8  __v = readb_relaxed(c); __iormb(); __v; })
+#define readw(c)	({ u16 __v = readw_relaxed(c); __iormb(); __v; })
+#define readl(c)	({ u32 __v = readl_relaxed(c); __iormb(); __v; })
+
+#define writeb(v,c)	({ __iowmb(); writeb_relaxed((v),(c)); })
+#define writew(v,c)	({ __iowmb(); writew_relaxed((v),(c)); })
+#define writel(v,c)	({ __iowmb(); writel_relaxed((v),(c)); })
+#include <asm-generic/io.h>
+#endif /* __ASM_NDS32_IO_H */
diff --git a/arch/nds32/mm/ioremap.c b/arch/nds32/mm/ioremap.c
new file mode 100644
index 0000000..9b404eb
--- /dev/null
+++ b/arch/nds32/mm/ioremap.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright (C) 2005-2017 Andes Technology Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <asm/pgtable.h>
+
+void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
+
+static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
+				      void *caller)
+{
+	struct vm_struct *area;
+	unsigned long addr, offset, last_addr;
+	pgprot_t prot;
+
+	/* Don't allow wraparound or zero size */
+	last_addr = phys_addr + size - 1;
+	if (!size || last_addr < phys_addr)
+		return NULL;
+
+	/*
+	 * Mappings have to be page-aligned
+	 */
+	offset = phys_addr & ~PAGE_MASK;
+	phys_addr &= PAGE_MASK;
+	size = PAGE_ALIGN(last_addr + 1) - phys_addr;
+
+	/*
+	 * Ok, go for it..
+	 */
+	area = get_vm_area_caller(size, VM_IOREMAP, caller);
+	if (!area)
+		return NULL;
+
+	area->phys_addr = phys_addr;
+	addr = (unsigned long)area->addr;
+	prot = __pgprot(_PAGE_V | _PAGE_M_KRW | _PAGE_D |
+			_PAGE_G | _PAGE_C_DEV);
+	if (ioremap_page_range(addr, addr + size, phys_addr, prot)) {
+		vunmap((void *)addr);
+		return NULL;
+	}
+	return (__force void __iomem *)(offset + (char *)addr);
+
+}
+
+void __iomem *ioremap(phys_addr_t phys_addr, size_t size)
+{
+	return __ioremap_caller(phys_addr, size,
+				__builtin_return_address(0));
+}
+
+EXPORT_SYMBOL(ioremap);
+
+void iounmap(void __iomem * addr)
+{
+	vunmap((void *)(PAGE_MASK & (unsigned long)addr));
+}
+
+EXPORT_SYMBOL(iounmap);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

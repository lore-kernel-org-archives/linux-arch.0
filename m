From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 16/37] nds32: Device specific operations
Date: Tue, 13 Feb 2018 17:09:20 +0800
Message-ID: <7e158934acdeac150645a303de21b7ed9c75e4ff.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

This patch introduces ioremap implementations.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/io.h | 83 +++++++++++++++++++++++++++++++++++++++++++++
 arch/nds32/mm/ioremap.c     | 62 +++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 arch/nds32/include/asm/io.h
 create mode 100644 arch/nds32/mm/ioremap.c

diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
new file mode 100644
index 000000000000..966e71b3c960
--- /dev/null
+++ b/arch/nds32/include/asm/io.h
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#ifndef __ASM_NDS32_IO_H
+#define __ASM_NDS32_IO_H
+
+extern void iounmap(volatile void __iomem *addr);
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
index 000000000000..690140bb23a2
--- /dev/null
+++ b/arch/nds32/mm/ioremap.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
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
+void iounmap(volatile void __iomem * addr)
+{
+	vunmap((void *)(PAGE_MASK & (unsigned long)addr));
+}
+
+EXPORT_SYMBOL(iounmap);
-- 
2.16.1

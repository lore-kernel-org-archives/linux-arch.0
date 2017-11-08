From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH 12/31] nds32: Device specific operations
Date: Wed,  8 Nov 2017 13:55:00 +0800
Message-ID: <4e9acf2ec55fb26ddb290ca2d955eeea628e0a77.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
In-Reply-To: <cover.1510118606.git.green.hu@gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/include/asm/io.h |   33 +++++++++++++++++++++
 arch/nds32/mm/ioremap.c     |   67 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 arch/nds32/include/asm/io.h
 create mode 100644 arch/nds32/mm/ioremap.c

diff --git a/arch/nds32/include/asm/io.h b/arch/nds32/include/asm/io.h
new file mode 100644
index 0000000..98b3ae9
--- /dev/null
+++ b/arch/nds32/include/asm/io.h
@@ -0,0 +1,33 @@
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
+#ifdef __KERNEL__
+
+#include <asm-generic/iomap.h>
+extern void __iomem *__ioremap(unsigned long, size_t, unsigned long,
+			       unsigned long);
+extern void __iounmap(void __iomem * addr);
+
+#define ioremap(cookie,size)		__ioremap(cookie,size,0,1)
+#define ioremap_nocache(cookie,size)	__ioremap(cookie,size,0,1)
+#define iounmap(cookie)			__iounmap(cookie)
+#include <asm-generic/io.h>
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_NDS32_IO_H */
diff --git a/arch/nds32/mm/ioremap.c b/arch/nds32/mm/ioremap.c
new file mode 100644
index 0000000..532e6cf
--- /dev/null
+++ b/arch/nds32/mm/ioremap.c
@@ -0,0 +1,67 @@
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
+void __iomem *__ioremap(unsigned long phys_addr, size_t size,
+			unsigned long flags, unsigned long align)
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
+	area = get_vm_area(size, VM_IOREMAP);
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
+EXPORT_SYMBOL(__ioremap);
+
+void __iounmap(void __iomem * addr)
+{
+	vunmap((void *)(PAGE_MASK & (unsigned long)addr));
+}
+
+EXPORT_SYMBOL(__iounmap);
-- 
1.7.9.5

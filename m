Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55143 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834Ab2HNRxI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:08 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 13/31] arm64: Device specific operations
Date: Tue, 14 Aug 2012 18:52:14 +0100
Message-ID: <1344966752-16102-14-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175214.uox1yJXQ-9su01-b9dWtmfi2ZuIWtwJft1q_weGtSHA@z>

This patch adds several definitions for device communication, including
I/O accessors and ioremap(). The __raw_* accessors are implemented as
inline asm to avoid compiler generation of post-indexed accesses (less
efficient to emulate in a virtualised environment).

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/device.h |   26 ++++
 arch/arm64/include/asm/fb.h     |   34 +++++
 arch/arm64/include/asm/io.h     |  263 +++++++++++++++++++++++++++++++++++=
++++
 arch/arm64/kernel/io.c          |   64 ++++++++++
 arch/arm64/mm/ioremap.c         |   84 +++++++++++++
 5 files changed, 471 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/device.h
 create mode 100644 arch/arm64/include/asm/fb.h
 create mode 100644 arch/arm64/include/asm/io.h
 create mode 100644 arch/arm64/kernel/io.c
 create mode 100644 arch/arm64/mm/ioremap.c

diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/devic=
e.h
new file mode 100644
index 0000000..0d8453c
--- /dev/null
+++ b/arch/arm64/include/asm/device.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef __ASM_DEVICE_H
+#define __ASM_DEVICE_H
+
+struct dev_archdata {
+=09struct dma_map_ops *dma_ops;
+};
+
+struct pdev_archdata {
+};
+
+#endif
diff --git a/arch/arm64/include/asm/fb.h b/arch/arm64/include/asm/fb.h
new file mode 100644
index 0000000..adb88a6
--- /dev/null
+++ b/arch/arm64/include/asm/fb.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef __ASM_FB_H_
+#define __ASM_FB_H_
+
+#include <linux/fb.h>
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *=
vma,
+=09=09=09=09unsigned long off)
+{
+=09vma->vm_page_prot =3D pgprot_writecombine(vma->vm_page_prot);
+}
+
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+=09return 0;
+}
+
+#endif /* __ASM_FB_H_ */
diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
new file mode 100644
index 0000000..48fa83f
--- /dev/null
+++ b/arch/arm64/include/asm/io.h
@@ -0,0 +1,263 @@
+/*
+ * Based on arch/arm/include/asm/io.h
+ *
+ * Copyright (C) 1996-2000 Russell King
+ * Copyright (C) 2012 ARM Ltd.
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
+#ifndef __ASM_IO_H
+#define __ASM_IO_H
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+#include <asm/barrier.h>
+#include <asm/pgtable.h>
+
+/*
+ * Generic IO read/write.  These perform native-endian accesses.
+ */
+static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
+{
+=09asm volatile("strb %w0, [%1]" : : "r" (val), "r" (addr));
+}
+
+static inline void __raw_writew(u16 val, volatile void __iomem *addr)
+{
+=09asm volatile("strh %w0, [%1]" : : "r" (val), "r" (addr));
+}
+
+static inline void __raw_writel(u32 val, volatile void __iomem *addr)
+{
+=09asm volatile("str %w0, [%1]" : : "r" (val), "r" (addr));
+}
+
+static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
+{
+=09asm volatile("str %0, [%1]" : : "r" (val), "r" (addr));
+}
+
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+=09u8 val;
+=09asm volatile("ldrb %w0, [%1]" : "=3Dr" (val) : "r" (addr));
+=09return val;
+}
+
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+=09u16 val;
+=09asm volatile("ldrh %w0, [%1]" : "=3Dr" (val) : "r" (addr));
+=09return val;
+}
+
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+=09u32 val;
+=09asm volatile("ldr %w0, [%1]" : "=3Dr" (val) : "r" (addr));
+=09return val;
+}
+
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+=09u64 val;
+=09asm volatile("ldr %0, [%1]" : "=3Dr" (val) : "r" (addr));
+=09return val;
+}
+
+/* IO barriers */
+#define __iormb()=09=09rmb()
+#define __iowmb()=09=09wmb()
+
+#define mmiowb()=09=09do { } while (0)
+
+/*
+ * Relaxed I/O memory access primitives. These follow the Device memory
+ * ordering rules but do not guarantee any ordering relative to Normal mem=
ory
+ * accesses.
+ */
+#define readb_relaxed(c)=09({ u8  __v =3D __raw_readb(c); __v; })
+#define readw_relaxed(c)=09({ u16 __v =3D le16_to_cpu((__force __le16)__ra=
w_readw(c)); __v; })
+#define readl_relaxed(c)=09({ u32 __v =3D le32_to_cpu((__force __le32)__ra=
w_readl(c)); __v; })
+
+#define writeb_relaxed(v,c)=09((void)__raw_writeb((v),(c)))
+#define writew_relaxed(v,c)=09((void)__raw_writew((__force u16)cpu_to_le16=
(v),(c)))
+#define writel_relaxed(v,c)=09((void)__raw_writel((__force u32)cpu_to_le32=
(v),(c)))
+
+/*
+ * I/O memory access primitives. Reads are ordered relative to any
+ * following Normal memory access. Writes are ordered relative to any prio=
r
+ * Normal memory access.
+ */
+#define readb(c)=09=09({ u8  __v =3D readb_relaxed(c); __iormb(); __v; })
+#define readw(c)=09=09({ u16 __v =3D readw_relaxed(c); __iormb(); __v; })
+#define readl(c)=09=09({ u32 __v =3D readl_relaxed(c); __iormb(); __v; })
+
+#define writeb(v,c)=09=09({ __iowmb(); writeb_relaxed((v),(c)); })
+#define writew(v,c)=09=09({ __iowmb(); writew_relaxed((v),(c)); })
+#define writel(v,c)=09=09({ __iowmb(); writel_relaxed((v),(c)); })
+
+/*
+ *  I/O port access primitives.
+ */
+#define IO_SPACE_LIMIT=09=090xffff
+
+/*
+ * We currently don't have any platform with PCI support, so just leave th=
is
+ * defined to 0 until needed.
+ */
+#define PCI_IOBASE=09=09((void __iomem *)0)
+
+static inline u8 inb(unsigned long addr)
+{
+=09return readb(addr + PCI_IOBASE);
+}
+
+static inline u16 inw(unsigned long addr)
+{
+=09return readw(addr + PCI_IOBASE);
+}
+
+static inline u32 inl(unsigned long addr)
+{
+=09return readl(addr + PCI_IOBASE);
+}
+
+static inline void outb(u8 b, unsigned long addr)
+{
+=09writeb(b, addr + PCI_IOBASE);
+}
+
+static inline void outw(u16 b, unsigned long addr)
+{
+=09writew(b, addr + PCI_IOBASE);
+}
+
+static inline void outl(u32 b, unsigned long addr)
+{
+=09writel(b, addr + PCI_IOBASE);
+}
+
+#define inb_p(addr)=09inb(addr)
+#define inw_p(addr)=09inw(addr)
+#define inl_p(addr)=09inl(addr)
+
+#define outb_p(x, addr)=09outb((x), (addr))
+#define outw_p(x, addr)=09outw((x), (addr))
+#define outl_p(x, addr)=09outl((x), (addr))
+
+static inline void insb(unsigned long addr, void *buffer, int count)
+{
+=09u8 *buf =3D buffer;
+=09while (count--)
+=09=09*buf++ =3D __raw_readb(addr + PCI_IOBASE);
+}
+
+static inline void insw(unsigned long addr, void *buffer, int count)
+{
+=09u16 *buf =3D buffer;
+=09while (count--)
+=09=09*buf++ =3D __raw_readw(addr + PCI_IOBASE);
+}
+
+static inline void insl(unsigned long addr, void *buffer, int count)
+{
+=09u32 *buf =3D buffer;
+=09while (count--)
+=09=09*buf++ =3D __raw_readl(addr + PCI_IOBASE);
+}
+
+static inline void outsb(unsigned long addr, const void *buffer, int count=
)
+{
+=09const u8 *buf =3D buffer;
+=09while (count--)
+=09=09__raw_writeb(*buf++, addr + PCI_IOBASE);
+}
+
+static inline void outsw(unsigned long addr, const void *buffer, int count=
)
+{
+=09const u16 *buf =3D buffer;
+=09while (count--)
+=09=09__raw_writew(*buf++, addr + PCI_IOBASE);
+}
+
+static inline void outsl(unsigned long addr, const void *buffer, int count=
)
+{
+=09const u32 *buf =3D buffer;
+=09while (count--)
+=09=09__raw_writel(*buf++, addr + PCI_IOBASE);
+}
+
+#define insb_p(port,to,len)=09insb(port,to,len)
+#define insw_p(port,to,len)=09insw(port,to,len)
+#define insl_p(port,to,len)=09insl(port,to,len)
+
+#define outsb_p(port,from,len)=09outsb(port,from,len)
+#define outsw_p(port,from,len)=09outsw(port,from,len)
+#define outsl_p(port,from,len)=09outsl(port,from,len)
+
+/*
+ * String version of I/O memory access operations.
+ */
+extern void __memcpy_fromio(void *, const volatile void __iomem *, size_t)=
;
+extern void __memcpy_toio(volatile void __iomem *, const void *, size_t);
+extern void __memset_io(volatile void __iomem *, int, size_t);
+
+#define memset_io(c,v,l)=09__memset_io((c),(v),(l))
+#define memcpy_fromio(a,c,l)=09__memcpy_fromio((a),(c),(l))
+#define memcpy_toio(c,a,l)=09__memcpy_toio((c),(a),(l))
+
+/*
+ * I/O memory mapping functions.
+ */
+extern void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_=
t prot);
+extern void __iounmap(volatile void __iomem *addr);
+
+#define PROT_DEFAULT=09=09(PTE_TYPE_PAGE | PTE_AF | PTE_DIRTY)
+#define PROT_DEVICE_nGnRE=09(PROT_DEFAULT | PTE_XN | PTE_ATTRINDX(MT_DEVIC=
E_nGnRE))
+#define PROT_NORMAL_NC=09=09(PROT_DEFAULT | PTE_ATTRINDX(MT_NORMAL_NC))
+
+#define ioremap(addr, size)=09=09__ioremap((addr), (size), PROT_DEVICE_nGn=
RE)
+#define ioremap_nocache(addr, size)=09__ioremap((addr), (size), PROT_DEVIC=
E_nGnRE)
+#define ioremap_wc(addr, size)=09=09__ioremap((addr), (size), PROT_NORMAL_=
NC)
+#define iounmap=09=09=09=09__iounmap
+
+#define ARCH_HAS_IOREMAP_WC
+#include <asm-generic/iomap.h>
+
+/*
+ * More restrictive address range checking than the default implementation
+ * (PHYS_OFFSET and PHYS_MASK taken into account).
+ */
+#define ARCH_HAS_VALID_PHYS_ADDR_RANGE
+extern int valid_phys_addr_range(unsigned long addr, size_t size);
+extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
+
+extern int devmem_is_allowed(unsigned long pfn);
+
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)=09__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)=09p
+
+#endif=09/* __KERNEL__ */
+#endif=09/* __ASM_IO_H */
diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
new file mode 100644
index 0000000..7d37ead
--- /dev/null
+++ b/arch/arm64/kernel/io.c
@@ -0,0 +1,64 @@
+/*
+ * Based on arch/arm/kernel/io.c
+ *
+ * Copyright (C) 2012 ARM Ltd.
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
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+/*
+ * Copy data from IO memory space to "real" memory space.
+ */
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t c=
ount)
+{
+=09unsigned char *t =3D to;
+=09while (count) {
+=09=09count--;
+=09=09*t =3D readb(from);
+=09=09t++;
+=09=09from++;
+=09}
+}
+EXPORT_SYMBOL(__memcpy_fromio);
+
+/*
+ * Copy data from "real" memory space to IO memory space.
+ */
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t cou=
nt)
+{
+=09const unsigned char *f =3D from;
+=09while (count) {
+=09=09count--;
+=09=09writeb(*f, to);
+=09=09f++;
+=09=09to++;
+=09}
+}
+EXPORT_SYMBOL(__memcpy_toio);
+
+/*
+ * "memset" on IO memory space.
+ */
+void __memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+=09while (count) {
+=09=09count--;
+=09=09writeb(c, dst);
+=09=09dst++;
+=09}
+}
+EXPORT_SYMBOL(__memset_io);
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
new file mode 100644
index 0000000..1725cd6
--- /dev/null
+++ b/arch/arm64/mm/ioremap.c
@@ -0,0 +1,84 @@
+/*
+ * Based on arch/arm/mm/ioremap.c
+ *
+ * (C) Copyright 1995 1996 Linus Torvalds
+ * Hacked for ARM by Phil Blundell <philb@gnu.org>
+ * Hacked to allow all architectures to build, and various cleanups
+ * by Russell King
+ * Copyright (C) 2012 ARM Ltd.
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
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/io.h>
+
+static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
+=09=09=09=09      pgprot_t prot, void *caller)
+{
+=09unsigned long last_addr;
+=09unsigned long offset =3D phys_addr & ~PAGE_MASK;
+=09int err;
+=09unsigned long addr;
+=09struct vm_struct *area;
+
+=09/*
+=09 * Page align the mapping address and size, taking account of any
+=09 * offset.
+=09 */
+=09phys_addr &=3D PAGE_MASK;
+=09size =3D PAGE_ALIGN(size + offset);
+
+=09/*
+=09 * Don't allow wraparound, zero size or outside PHYS_MASK.
+=09 */
+=09last_addr =3D phys_addr + size - 1;
+=09if (!size || last_addr < phys_addr || (last_addr & ~PHYS_MASK))
+=09=09return NULL;
+
+=09/*
+=09 * Don't allow RAM to be mapped.
+=09 */
+=09if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
+=09=09return NULL;
+
+=09area =3D get_vm_area_caller(size, VM_IOREMAP, caller);
+=09if (!area)
+=09=09return NULL;
+=09addr =3D (unsigned long)area->addr;
+
+=09err =3D ioremap_page_range(addr, addr + size, phys_addr, prot);
+=09if (err) {
+=09=09vunmap((void *)addr);
+=09=09return NULL;
+=09}
+
+=09return (void __iomem *)(offset + addr);
+}
+
+void __iomem *__ioremap(phys_addr_t phys_addr, size_t size, pgprot_t prot)
+{
+=09return __ioremap_caller(phys_addr, size, prot,
+=09=09=09=09__builtin_return_address(0));
+}
+EXPORT_SYMBOL(__ioremap);
+
+void __iounmap(volatile void __iomem *io_addr)
+{
+=09void *addr =3D (void *)(PAGE_MASK & (unsigned long)io_addr);
+
+=09vunmap(addr);
+}
+EXPORT_SYMBOL(__iounmap);


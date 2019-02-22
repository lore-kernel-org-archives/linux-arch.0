Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbfBVSFD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:05:03 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 2/3] riscv: io: Update __io_[p]ar() macros to take an argument
Date: Fri, 22 Feb 2019 18:04:53 +0000
Message-ID: <20190222180454.5992-3-will.deacon@arm.com>
In-Reply-To: <20190222180454.5992-1-will.deacon@arm.com>
References: <20190222180454.5992-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de, catalin.marinas@arm.com, geert@linux-m68k.org, palmer@sifive.com, Will Deacon <will.deacon@arm.com>
Message-ID: <20190222180453.XzCy9qdSaK7g6Wix2JJOUpIwHA3VOMfoPFoSbya1kSI@z>

The definitions of the __io_[p]ar() macros in asm-generic/io.h take the
value returned by the preceding I/O read as an argument so that
architectures can use this to create order with a subsequent delayX()
routine using a dependency.

Update the riscv barrier definitions to match, although the argument
is currently unused.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/riscv/include/asm/io.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index b269451e7e85..1d9c1376dc64 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -163,20 +163,20 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * doesn't define any ordering between the memory space and the I/O space.
  */
 #define __io_br()	do {} while (0)
-#define __io_ar()	__asm__ __volatile__ ("fence i,r" : : : "memory");
+#define __io_ar(v)	__asm__ __volatile__ ("fence i,r" : : : "memory");
 #define __io_bw()	__asm__ __volatile__ ("fence w,o" : : : "memory");
 #define __io_aw()	do {} while (0)
 
-#define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(); __v; })
-#define readw(c)	({ u16 __v; __io_br(); __v = readw_cpu(c); __io_ar(); __v; })
-#define readl(c)	({ u32 __v; __io_br(); __v = readl_cpu(c); __io_ar(); __v; })
+#define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
+#define readw(c)	({ u16 __v; __io_br(); __v = readw_cpu(c); __io_ar(__v); __v; })
+#define readl(c)	({ u32 __v; __io_br(); __v = readl_cpu(c); __io_ar(__v); __v; })
 
 #define writeb(v,c)	({ __io_bw(); writeb_cpu((v),(c)); __io_aw(); })
 #define writew(v,c)	({ __io_bw(); writew_cpu((v),(c)); __io_aw(); })
 #define writel(v,c)	({ __io_bw(); writel_cpu((v),(c)); __io_aw(); })
 
 #ifdef CONFIG_64BIT
-#define readq(c)	({ u64 __v; __io_br(); __v = readq_cpu(c); __io_ar(); __v; })
+#define readq(c)	({ u64 __v; __io_br(); __v = readq_cpu(c); __io_ar(__v); __v; })
 #define writeq(v,c)	({ __io_bw(); writeq_cpu((v),(c)); __io_aw(); })
 #endif
 
@@ -198,20 +198,20 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * writes.
  */
 #define __io_pbr()	__asm__ __volatile__ ("fence io,i"  : : : "memory");
-#define __io_par()	__asm__ __volatile__ ("fence i,ior" : : : "memory");
+#define __io_par(v)	__asm__ __volatile__ ("fence i,ior" : : : "memory");
 #define __io_pbw()	__asm__ __volatile__ ("fence iow,o" : : : "memory");
 #define __io_paw()	__asm__ __volatile__ ("fence o,io"  : : : "memory");
 
-#define inb(c)		({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(); __v; })
-#define inw(c)		({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(); __v; })
-#define inl(c)		({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(); __v; })
+#define inb(c)		({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
+#define inw(c)		({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
+#define inl(c)		({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
 
 #define outb(v,c)	({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
 #define outw(v,c)	({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
 #define outl(v,c)	({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
 
 #ifdef CONFIG_64BIT
-#define inq(c)		({ u64 __v; __io_pbr(); __v = readq_cpu((void*)(c)); __io_par(); __v; })
+#define inq(c)		({ u64 __v; __io_pbr(); __v = readq_cpu((void*)(c)); __io_par(__v); __v; })
 #define outq(v,c)	({ __io_pbw(); writeq_cpu((v),(void*)(c)); __io_paw(); })
 #endif
 
@@ -254,16 +254,16 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 		afence;								\
 	}
 
-__io_reads_ins(reads,  u8, b, __io_br(), __io_ar())
-__io_reads_ins(reads, u16, w, __io_br(), __io_ar())
-__io_reads_ins(reads, u32, l, __io_br(), __io_ar())
+__io_reads_ins(reads,  u8, b, __io_br(), __io_ar(addr))
+__io_reads_ins(reads, u16, w, __io_br(), __io_ar(addr))
+__io_reads_ins(reads, u32, l, __io_br(), __io_ar(addr))
 #define readsb(addr, buffer, count) __readsb(addr, buffer, count)
 #define readsw(addr, buffer, count) __readsw(addr, buffer, count)
 #define readsl(addr, buffer, count) __readsl(addr, buffer, count)
 
-__io_reads_ins(ins,  u8, b, __io_pbr(), __io_par())
-__io_reads_ins(ins, u16, w, __io_pbr(), __io_par())
-__io_reads_ins(ins, u32, l, __io_pbr(), __io_par())
+__io_reads_ins(ins,  u8, b, __io_pbr(), __io_par(addr))
+__io_reads_ins(ins, u16, w, __io_pbr(), __io_par(addr))
+__io_reads_ins(ins, u32, l, __io_pbr(), __io_par(addr))
 #define insb(addr, buffer, count) __insb((void __iomem *)(long)addr, buffer, count)
 #define insw(addr, buffer, count) __insw((void __iomem *)(long)addr, buffer, count)
 #define insl(addr, buffer, count) __insl((void __iomem *)(long)addr, buffer, count)
@@ -283,10 +283,10 @@ __io_writes_outs(outs, u32, l, __io_pbw(), __io_paw())
 #define outsl(addr, buffer, count) __outsl((void __iomem *)(long)addr, buffer, count)
 
 #ifdef CONFIG_64BIT
-__io_reads_ins(reads, u64, q, __io_br(), __io_ar())
+__io_reads_ins(reads, u64, q, __io_br(), __io_ar(addr))
 #define readsq(addr, buffer, count) __readsq(addr, buffer, count)
 
-__io_reads_ins(ins, u64, q, __io_pbr(), __io_par())
+__io_reads_ins(ins, u64, q, __io_pbr(), __io_par(addr))
 #define insq(addr, buffer, count) __insq((void __iomem *)addr, buffer, count)
 
 __io_writes_outs(writes, u64, q, __io_bw(), __io_aw())
-- 
2.11.0

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:45822 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbXIFLjW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2007 07:39:22 -0400
Received: from localhost.localdomain ([127.0.0.1]:13293 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025642AbXIFLjV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Sep 2007 12:39:21 +0100
Date: Thu, 6 Sep 2007 12:39:18 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Removal of dma_cache_(wback|inv|wback_inv) functions
Message-ID: <20070906113918.GA1585@linux-mips.org>
References: <20070904115615.GA14986@linux-mips.org> <20070904124212.GR14130@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070904124212.GR14130@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

So this is looking ok?  I got an ACK from Paul Mundt for SH.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/avr32/mm/dma-coherent.c        |    6 ++--
 arch/mips/mm/cache.c                |    2 -
 arch/sh/drivers/pci/dma-dreamcast.c |    2 +
 arch/sh/mm/consistent.c             |    8 +++---
 arch/sh64/kernel/pci-dma.c          |    3 +-
 include/asm-alpha/io.h              |    6 ----
 include/asm-avr32/io.h              |    7 -----
 include/asm-blackfin/io.h           |    4 ---
 include/asm-h8300/io.h              |    6 ----
 include/asm-i386/io.h               |   11 +-------
 include/asm-ia64/io.h               |    4 ---
 include/asm-m68k/io.h               |    6 ----
 include/asm-m68knommu/io.h          |    6 ----
 include/asm-mips/io.h               |    2 +
 include/asm-parisc/io.h             |    5 ----
 include/asm-powerpc/io.h            |   17 ------------
 include/asm-ppc/io.h                |   17 ------------
 include/asm-sh/floppy.h             |    2 +
 include/asm-sh/io.h                 |   25 ------------------
 include/asm-sh64/dma-mapping.h      |    6 ++++
 include/asm-sh64/io.h               |   48 -----------------------------------
 include/asm-sparc/io.h              |    7 -----
 include/asm-sparc64/io.h            |    6 ----
 include/asm-x86_64/io.h             |    6 ----
 24 files changed, 19 insertions(+), 193 deletions(-)

diff --git a/arch/avr32/mm/dma-coherent.c b/arch/avr32/mm/dma-coherent.c
index 099212d..177fea8 100644
--- a/arch/avr32/mm/dma-coherent.c
+++ b/arch/avr32/mm/dma-coherent.c
@@ -21,13 +21,13 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size, int direction)
 
 	switch (direction) {
 	case DMA_FROM_DEVICE:		/* invalidate only */
-		dma_cache_inv(vaddr, size);
+		invalidate_dcache_region(vaddr, size);
 		break;
 	case DMA_TO_DEVICE:		/* writeback only */
-		dma_cache_wback(vaddr, size);
+		clean_dcache_region(vaddr, size);
 		break;
 	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		dma_cache_wback_inv(vaddr, size);
+		flush_dcache_region(vaddr, size);
 		break;
 	default:
 		BUG();
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 81f925a..49d4646 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -46,8 +46,6 @@ void (*_dma_cache_wback)(unsigned long start, unsigned long size);
 void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
 EXPORT_SYMBOL(_dma_cache_wback_inv);
-EXPORT_SYMBOL(_dma_cache_wback);
-EXPORT_SYMBOL(_dma_cache_inv);
 
 #endif /* CONFIG_DMA_NONCOHERENT */
 
diff --git a/arch/sh/drivers/pci/dma-dreamcast.c b/arch/sh/drivers/pci/dma-dreamcast.c
index 230d6ec..888a340 100644
--- a/arch/sh/drivers/pci/dma-dreamcast.c
+++ b/arch/sh/drivers/pci/dma-dreamcast.c
@@ -51,7 +51,7 @@ void *dreamcast_consistent_alloc(struct device *dev, size_t size,
 	buf = P2SEGADDR(buf);
 
 	/* Flush the dcache before we hand off the buffer */
-	dma_cache_wback_inv((void *)buf, size);
+	__flush_purge_region((void *)buf, size);
 
 	return (void *)buf;
 }
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 38c82d8..e220c29 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -34,7 +34,7 @@ void *consistent_alloc(gfp_t gfp, size_t size, dma_addr_t *handle)
 	/*
 	 * We must flush the cache before we pass it on to the device
 	 */
-	dma_cache_wback_inv(ret, size);
+	__flush_purge_region(ret, size);
 
 	page = virt_to_page(ret);
 	free = page + (size >> PAGE_SHIFT);
@@ -68,13 +68,13 @@ void consistent_sync(void *vaddr, size_t size, int direction)
 
 	switch (direction) {
 	case DMA_FROM_DEVICE:		/* invalidate only */
-		dma_cache_inv(p1addr, size);
+		__flush_invalidate_region(p1addr, size);
 		break;
 	case DMA_TO_DEVICE:		/* writeback only */
-		dma_cache_wback(p1addr, size);
+		__flush_wback_region(p1addr, size);
 		break;
 	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		dma_cache_wback_inv(p1addr, size);
+		__flush_purge_region(p1addr, size);
 		break;
 	default:
 		BUG();
diff --git a/arch/sh64/kernel/pci-dma.c b/arch/sh64/kernel/pci-dma.c
index a9328f8..e3f1d32 100644
--- a/arch/sh64/kernel/pci-dma.c
+++ b/arch/sh64/kernel/pci-dma.c
@@ -8,6 +8,7 @@
  * Dynamic DMA mapping support.
  */
 #include <linux/types.h>
+#include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/pci.h>
@@ -31,7 +32,7 @@ void *consistent_alloc(struct pci_dev *hwdev, size_t size,
 	if (vp != NULL) {
 		memset(vp, 0, size);
 		*dma_handle = virt_to_phys(ret);
-		dma_cache_wback_inv((unsigned long)ret, size);
+		dma_cache_sync(NULL, ret, size, DMA_BIDIRECTIONAL);
 	}
 
 	return vp;
diff --git a/include/asm-alpha/io.h b/include/asm-alpha/io.h
index ab5b60d..38f18cf 100644
--- a/include/asm-alpha/io.h
+++ b/include/asm-alpha/io.h
@@ -551,12 +551,6 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
 #endif
 #define RTC_ALWAYS_BCD	0
 
-/* Nothing to do */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
 /*
  * Some mucking forons use if[n]def writeq to check if platform has it.
  * It's a bloody bad idea and we probably want ARCH_HAS_WRITEQ for them
diff --git a/include/asm-avr32/io.h b/include/asm-avr32/io.h
index 64bb92b..8be7ea9 100644
--- a/include/asm-avr32/io.h
+++ b/include/asm-avr32/io.h
@@ -298,13 +298,6 @@ extern void __iounmap(void __iomem *addr);
 #define ioport_map(port, nr)	ioremap(port, nr)
 #define ioport_unmap(port)	iounmap(port)
 
-#define dma_cache_wback_inv(_start, _size)	\
-	flush_dcache_region(_start, _size)
-#define dma_cache_inv(_start, _size)		\
-	invalidate_dcache_region(_start, _size)
-#define dma_cache_wback(_start, _size)		\
-	clean_dcache_region(_start, _size)
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/include/asm-blackfin/io.h b/include/asm-blackfin/io.h
index 142cb33..818d949 100644
--- a/include/asm-blackfin/io.h
+++ b/include/asm-blackfin/io.h
@@ -183,10 +183,6 @@ extern void blkfin_inv_cache_all(void);
 #define	ioport_map(port, nr)		((void __iomem*)(port))
 #define	ioport_unmap(addr)
 
-#define dma_cache_inv(_start,_size) do { blkfin_inv_cache_all();} while (0)
-#define dma_cache_wback(_start,_size) do { } while (0)
-#define dma_cache_wback_inv(_start,_size) do { blkfin_inv_cache_all();} while (0)
-
 /* Pages to physical address... */
 #define page_to_phys(page)      ((page - mem_map) << PAGE_SHIFT)
 #define page_to_bus(page)       ((page - mem_map) << PAGE_SHIFT)
diff --git a/include/asm-h8300/io.h b/include/asm-h8300/io.h
index 91b7487..7543a57 100644
--- a/include/asm-h8300/io.h
+++ b/include/asm-h8300/io.h
@@ -264,12 +264,6 @@ static inline void *ioremap_fullcache(unsigned long physaddr, unsigned long size
 
 extern void iounmap(void *addr);
 
-/* Nothing to do */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
 /* H8/300 internal I/O functions */
 static __inline__ unsigned char ctrl_inb(unsigned long addr)
 {
diff --git a/include/asm-i386/io.h b/include/asm-i386/io.h
index e8e0bd6..4ea7b1a 100644
--- a/include/asm-i386/io.h
+++ b/include/asm-i386/io.h
@@ -237,18 +237,9 @@ static inline void flush_write_buffers(void)
 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory");
 }
 
-#define dma_cache_inv(_start,_size)		flush_write_buffers()
-#define dma_cache_wback(_start,_size)		flush_write_buffers()
-#define dma_cache_wback_inv(_start,_size)	flush_write_buffers()
-
 #else
 
-/* Nothing to do */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-#define flush_write_buffers()
+#define flush_write_buffers() do { } while (0)
 
 #endif
 
diff --git a/include/asm-ia64/io.h b/include/asm-ia64/io.h
index eb17a86..4ebed77 100644
--- a/include/asm-ia64/io.h
+++ b/include/asm-ia64/io.h
@@ -435,10 +435,6 @@ extern void memcpy_fromio(void *dst, const volatile void __iomem *src, long n);
 extern void memcpy_toio(volatile void __iomem *dst, const void *src, long n);
 extern void memset_io(volatile void __iomem *s, int c, long n);
 
-#define dma_cache_inv(_start,_size)             do { } while (0)
-#define dma_cache_wback(_start,_size)           do { } while (0)
-#define dma_cache_wback_inv(_start,_size)       do { } while (0)
-
 # endif /* __KERNEL__ */
 
 /*
diff --git a/include/asm-m68k/io.h b/include/asm-m68k/io.h
index 47bb9cf..baf4f9b 100644
--- a/include/asm-m68k/io.h
+++ b/include/asm-m68k/io.h
@@ -384,12 +384,6 @@ static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
 }
 
-
-/* m68k caches aren't DMA coherent */
-extern void dma_cache_wback_inv(unsigned long start, unsigned long size);
-extern void dma_cache_wback(unsigned long start, unsigned long size);
-extern void dma_cache_inv(unsigned long start, unsigned long size);
-
 static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
 	__builtin_memset((void __force *) addr, val, count);
diff --git a/include/asm-m68knommu/io.h b/include/asm-m68knommu/io.h
index 8df4cee..653d9b2 100644
--- a/include/asm-m68knommu/io.h
+++ b/include/asm-m68knommu/io.h
@@ -165,12 +165,6 @@ static inline void *ioremap_fullcache(unsigned long physaddr, unsigned long size
 
 extern void iounmap(void *addr);
 
-/* Nothing to do */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
 /* Pages to physical address... */
 #define page_to_phys(page)      ((page - mem_map) << PAGE_SHIFT)
 #define page_to_bus(page)       ((page - mem_map) << PAGE_SHIFT)
diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
index 7ba9289..d79a889 100644
--- a/include/asm-mips/io.h
+++ b/include/asm-mips/io.h
@@ -554,6 +554,8 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int
  *    caches.  Dirty lines of the caches may be written back or simply
  *    be discarded.  This operation is necessary before dma operations
  *    to the memory.
+ *
+ * This API used to be exported; it now is for arch code internal use only.
  */
 #ifdef CONFIG_DMA_NONCOHERENT
 
diff --git a/include/asm-parisc/io.h b/include/asm-parisc/io.h
index 4cc9bce..95f00e1 100644
--- a/include/asm-parisc/io.h
+++ b/include/asm-parisc/io.h
@@ -270,11 +270,6 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
 /* IO Port space is :      BBiiii   where BB is HBA number. */
 #define IO_SPACE_LIMIT 0x00ffffff
 
-
-#define dma_cache_inv(_start,_size)		do { flush_kernel_dcache_range(_start,_size); } while (0)
-#define dma_cache_wback(_start,_size)		do { flush_kernel_dcache_range(_start,_size); } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { flush_kernel_dcache_range(_start,_size); } while (0)
-
 /* PA machines have an MM I/O space from 0xf0000000-0xffffffff in 32
  * bit mode and from 0xfffffffff0000000-0xfffffffffffffff in 64 bit
  * mode (essentially just sign extending.  This macro takes in a 32
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index bb8d965..a59028a 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -498,23 +498,6 @@ static inline void name at					\
 #define writeq	writeq
 #endif
 
-#ifdef CONFIG_NOT_COHERENT_CACHE
-
-#define dma_cache_inv(_start,_size) \
-	invalidate_dcache_range(_start, (_start + _size))
-#define dma_cache_wback(_start,_size) \
-	clean_dcache_range(_start, (_start + _size))
-#define dma_cache_wback_inv(_start,_size) \
-	flush_dcache_range(_start, (_start + _size))
-
-#else /* CONFIG_NOT_COHERENT_CACHE */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
-#endif /* !CONFIG_NOT_COHERENT_CACHE */
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index 95d5904..de083df 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -518,23 +518,6 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 #include <asm/mpc8260_pci9.h>
 #endif
 
-#ifdef CONFIG_NOT_COHERENT_CACHE
-
-#define dma_cache_inv(_start,_size) \
-	invalidate_dcache_range(_start, (_start + _size))
-#define dma_cache_wback(_start,_size) \
-	clean_dcache_range(_start, (_start + _size))
-#define dma_cache_wback_inv(_start,_size) \
-	flush_dcache_range(_start, (_start + _size))
-
-#else
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
-#endif
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/include/asm-sh/floppy.h b/include/asm-sh/floppy.h
index 3b59b3a..c52309f 100644
--- a/include/asm-sh/floppy.h
+++ b/include/asm-sh/floppy.h
@@ -213,7 +213,7 @@ static int hard_dma_setup(char *addr, unsigned long size, int mode, int io)
 	}
 #endif
 
-	dma_cache_wback_inv(addr, size);
+	__flush_purge_region(addr, size);
 
 	/* actual, physical DMA */
 	doing_pdma = 0;
diff --git a/include/asm-sh/io.h b/include/asm-sh/io.h
index e6a1877..cc7821f 100644
--- a/include/asm-sh/io.h
+++ b/include/asm-sh/io.h
@@ -301,31 +301,6 @@ __ioremap_mode(unsigned long offset, unsigned long size, unsigned long flags)
 	__iounmap((addr))
 
 /*
- * The caches on some architectures aren't dma-coherent and have need to
- * handle this in software.  There are three types of operations that
- * can be applied to dma buffers.
- *
- *  - dma_cache_wback_inv(start, size) makes caches and RAM coherent by
- *    writing the content of the caches back to memory, if necessary.
- *    The function also invalidates the affected part of the caches as
- *    necessary before DMA transfers from outside to memory.
- *  - dma_cache_inv(start, size) invalidates the affected parts of the
- *    caches.  Dirty lines of the caches may be written back or simply
- *    be discarded.  This operation is necessary before dma operations
- *    to the memory.
- *  - dma_cache_wback(start, size) writes back any dirty lines but does
- *    not invalidate the cache.  This can be used before DMA reads from
- *    memory,
- */
-
-#define dma_cache_wback_inv(_start,_size) \
-    __flush_purge_region(_start,_size)
-#define dma_cache_inv(_start,_size) \
-    __flush_invalidate_region(_start,_size)
-#define dma_cache_wback(_start,_size) \
-    __flush_wback_region(_start,_size)
-
-/*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
  */
diff --git a/include/asm-sh64/dma-mapping.h b/include/asm-sh64/dma-mapping.h
index de43099..e661857 100644
--- a/include/asm-sh64/dma-mapping.h
+++ b/include/asm-sh64/dma-mapping.h
@@ -42,7 +42,11 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 				  enum dma_data_direction dir)
 {
-	dma_cache_wback_inv((unsigned long)vaddr, size);
+	unsigned long s = (unsigned long) vaddr & L1_CACHE_ALIGN_MASK;
+	unsigned long e = (vaddr + size) & L1_CACHE_ALIGN_MASK;
+
+	for (; s <= e; s += L1_CACHE_BYTES)
+		asm volatile ("ocbp	%0, 0" : : "r" (s));
 }
 
 static inline dma_addr_t dma_map_single(struct device *dev,
diff --git a/include/asm-sh64/io.h b/include/asm-sh64/io.h
index 1f37b69..dca1669 100644
--- a/include/asm-sh64/io.h
+++ b/include/asm-sh64/io.h
@@ -175,54 +175,6 @@ unsigned long onchip_remap(unsigned long addr, unsigned long size, const char* n
 extern void onchip_unmap(unsigned long vaddr);
 
 /*
- * The caches on some architectures aren't dma-coherent and have need to
- * handle this in software.  There are three types of operations that
- * can be applied to dma buffers.
- *
- *  - dma_cache_wback_inv(start, size) makes caches and RAM coherent by
- *    writing the content of the caches back to memory, if necessary.
- *    The function also invalidates the affected part of the caches as
- *    necessary before DMA transfers from outside to memory.
- *  - dma_cache_inv(start, size) invalidates the affected parts of the
- *    caches.  Dirty lines of the caches may be written back or simply
- *    be discarded.  This operation is necessary before dma operations
- *    to the memory.
- *  - dma_cache_wback(start, size) writes back any dirty lines but does
- *    not invalidate the cache.  This can be used before DMA reads from
- *    memory,
- */
-
-static __inline__ void dma_cache_wback_inv (unsigned long start, unsigned long size)
-{
-	unsigned long s = start & L1_CACHE_ALIGN_MASK;
-	unsigned long e = (start + size) & L1_CACHE_ALIGN_MASK;
-
-	for (; s <= e; s += L1_CACHE_BYTES)
-		asm volatile ("ocbp	%0, 0" : : "r" (s));
-}
-
-static __inline__ void dma_cache_inv (unsigned long start, unsigned long size)
-{
-	// Note that caller has to be careful with overzealous
-	// invalidation should there be partial cache lines at the extremities
-	// of the specified range
-	unsigned long s = start & L1_CACHE_ALIGN_MASK;
-	unsigned long e = (start + size) & L1_CACHE_ALIGN_MASK;
-
-	for (; s <= e; s += L1_CACHE_BYTES)
-		asm volatile ("ocbi	%0, 0" : : "r" (s));
-}
-
-static __inline__ void dma_cache_wback (unsigned long start, unsigned long size)
-{
-	unsigned long s = start & L1_CACHE_ALIGN_MASK;
-	unsigned long e = (start + size) & L1_CACHE_ALIGN_MASK;
-
-	for (; s <= e; s += L1_CACHE_BYTES)
-		asm volatile ("ocbwb	%0, 0" : : "r" (s));
-}
-
-/*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
  */
diff --git a/include/asm-sparc/io.h b/include/asm-sparc/io.h
index c23e74a..243bf8e 100644
--- a/include/asm-sparc/io.h
+++ b/include/asm-sparc/io.h
@@ -310,13 +310,6 @@ extern void sbus_iounmap(volatile void __iomem *vaddr, unsigned long size);
 #define RTC_PORT(x)   (rtc_port + (x))
 #define RTC_ALWAYS_BCD  0
 
-/* Nothing to do */
-/* P3: Only IDE DMA may need these. XXX Verify that it still does... */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
 #endif
 
 #define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
diff --git a/include/asm-sparc64/io.h b/include/asm-sparc64/io.h
index 9565a89..cd7ef30 100644
--- a/include/asm-sparc64/io.h
+++ b/include/asm-sparc64/io.h
@@ -474,12 +474,6 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 #define sbus_iounmap(__addr, __size)	\
 	release_region((unsigned long)(__addr), (__size))
 
-/* Nothing to do */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/include/asm-x86_64/io.h b/include/asm-x86_64/io.h
index 7475095..a037b07 100644
--- a/include/asm-x86_64/io.h
+++ b/include/asm-x86_64/io.h
@@ -249,12 +249,6 @@ void memset_io(volatile void __iomem *a, int b, size_t c);
  */
 #define __ISA_IO_base ((char __iomem *)(PAGE_OFFSET))
 
-/* Nothing to do */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
 #define flush_write_buffers() 
 
 extern int iommu_bio_merge;

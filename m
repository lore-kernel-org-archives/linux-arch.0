Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 10 Mar 2005 12:16:18 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: ia64-specific-dev-mem-handlers.patch
Message-Id: <20050310121618.1242b2d6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: Jes Sorensen <jes@trained-monkey.org>
List-ID: <linux-arch.vger.kernel.org>


It is believed that this will be useful to other architectures which allow
users to uncacheably map RAM.  Could interested parties please comment?



From: Jes Sorensen <jes@wildopensource.com>

Convert /dev/mem read/write calls to use arch_translate_mem_ptr if
available.  Needed on ia64 for pages converted fo uncached mappings to
avoid it being accessed in cached mode after the conversion which can lead
to memory corruption.  Introduces PG_uncached page flag for marking pages
uncached.

Also folds do_write_mem into write_mem as it was it's only user.

Use __ARCH_HAS_NO_PAGE_ZERO_MAPPED for architectures to indicate they
require magic handling of the zero page (Sparc and m68k).

Signed-off-by: Jes Sorensen <jes@wildopensource.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/char/mem.c         |  231 ++++++++++++++++++++++++++++---------
 25-akpm/include/asm-alpha/io.h     |   11 +
 25-akpm/include/asm-arm/io.h       |   11 +
 25-akpm/include/asm-arm26/io.h     |   11 +
 25-akpm/include/asm-cris/io.h      |   11 +
 25-akpm/include/asm-frv/io.h       |   12 +
 25-akpm/include/asm-h8300/io.h     |   11 +
 25-akpm/include/asm-i386/io.h      |   11 +
 25-akpm/include/asm-ia64/uaccess.h |   36 +++++
 25-akpm/include/asm-m32r/io.h      |   11 +
 25-akpm/include/asm-m68k/io.h      |   14 ++
 25-akpm/include/asm-m68knommu/io.h |   11 +
 25-akpm/include/asm-mips/io.h      |   11 +
 25-akpm/include/asm-parisc/io.h    |   11 +
 25-akpm/include/asm-ppc/io.h       |   11 +
 25-akpm/include/asm-ppc64/io.h     |   11 +
 25-akpm/include/asm-s390/io.h      |   11 +
 25-akpm/include/asm-sparc/io.h     |   13 ++
 25-akpm/include/asm-sparc64/io.h   |   11 +
 25-akpm/include/asm-um/io.h        |   11 +
 25-akpm/include/asm-v850/io.h      |   11 +
 25-akpm/include/asm-x86_64/io.h    |   11 +
 25-akpm/include/linux/page-flags.h |    6 
 23 files changed, 448 insertions(+), 51 deletions(-)

diff -puN drivers/char/mem.c~ia64-specific-dev-mem-handlers drivers/char/mem.c
--- 25/drivers/char/mem.c~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/drivers/char/mem.c	2005-03-09 22:44:39.000000000 -0800
@@ -111,39 +111,6 @@ static inline int valid_phys_addr_range(
 }
 #endif
 
-static ssize_t do_write_mem(void *p, unsigned long realp,
-			    const char __user * buf, size_t count, loff_t *ppos)
-{
-	ssize_t written;
-	unsigned long copied;
-
-	written = 0;
-#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
-	/* we don't have page 0 mapped on sparc and m68k.. */
-	if (realp < PAGE_SIZE) {
-		unsigned long sz = PAGE_SIZE-realp;
-		if (sz > count) sz = count; 
-		/* Hmm. Do something? */
-		buf+=sz;
-		p+=sz;
-		count-=sz;
-		written+=sz;
-	}
-#endif
-	copied = copy_from_user(p, buf, count);
-	if (copied) {
-		ssize_t ret = written + (count - copied);
-
-		if (ret)
-			return ret;
-		return -EFAULT;
-	}
-	written += count;
-	*ppos += written;
-	return written;
-}
-
-
 /*
  * This funcion reads the *physical* memory. The f_pos points directly to the 
  * memory location. 
@@ -152,15 +119,16 @@ static ssize_t read_mem(struct file * fi
 			size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	ssize_t read;
+	ssize_t read, sz;
+	char *ptr;
 
 	if (!valid_phys_addr_range(p, &count))
 		return -EFAULT;
 	read = 0;
-#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
+#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
 	/* we don't have page 0 mapped on sparc and m68k.. */
 	if (p < PAGE_SIZE) {
-		unsigned long sz = PAGE_SIZE-p;
+		sz = PAGE_SIZE - p;
 		if (sz > count) 
 			sz = count; 
 		if (sz > 0) {
@@ -173,9 +141,33 @@ static ssize_t read_mem(struct file * fi
 		}
 	}
 #endif
-	if (copy_to_user(buf, __va(p), count))
-		return -EFAULT;
-	read += count;
+
+	while (count > 0) {
+		/*
+		 * Handle first page in case it's not aligned
+		 */
+		if (-p & (PAGE_SIZE - 1))
+			sz = -p & (PAGE_SIZE - 1);
+		else
+			sz = PAGE_SIZE;
+
+		sz = min_t(unsigned long, sz, count);
+
+		/*
+		 * On ia64 if a page has been mapped somewhere as
+		 * uncached, then it must also be accessed uncached
+		 * by the kernel or data corruption may occur
+		 */
+		ptr = xlate_dev_mem_ptr(p);
+
+		if (copy_to_user(buf, ptr, sz))
+			return -EFAULT;
+		buf += sz;
+		p += sz;
+		count -= sz;
+		read += sz;
+	}
+
 	*ppos += read;
 	return read;
 }
@@ -184,10 +176,64 @@ static ssize_t write_mem(struct file * f
 			 size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
+	ssize_t written, sz;
+	unsigned long copied;
+	void *ptr;
 
 	if (!valid_phys_addr_range(p, &count))
 		return -EFAULT;
-	return do_write_mem(__va(p), p, buf, count, ppos);
+
+	written = 0;
+
+#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
+	/* we don't have page 0 mapped on sparc and m68k.. */
+	if (p < PAGE_SIZE) {
+		unsigned long sz = PAGE_SIZE - p;
+		if (sz > count)
+			sz = count;
+		/* Hmm. Do something? */
+		buf += sz;
+		p += sz;
+		count -= sz;
+		written += sz;
+	}
+#endif
+
+	while (count > 0) {
+		/*
+		 * Handle first page in case it's not aligned
+		 */
+		if (-p & (PAGE_SIZE - 1))
+			sz = -p & (PAGE_SIZE - 1);
+		else
+			sz = PAGE_SIZE;
+
+		sz = min_t(unsigned long, sz, count);
+
+		/*
+		 * On ia64 if a page has been mapped somewhere as
+		 * uncached, then it must also be accessed uncached
+		 * by the kernel or data corruption may occur
+		 */
+		ptr = xlate_dev_mem_ptr(p);
+
+		copied = copy_from_user(ptr, buf, sz);
+		if (copied) {
+			ssize_t ret;
+
+			ret = written + (sz - copied);
+			if (ret)
+				return ret;
+			return -EFAULT;
+		}
+		buf += sz;
+		p += sz;
+		count -= sz;
+		written += sz;
+	}
+
+	*ppos += written;
+	return written;
 }
 
 static int mmap_mem(struct file * file, struct vm_area_struct * vma)
@@ -221,16 +267,17 @@ static ssize_t read_kmem(struct file *fi
 			 size_t count, loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	ssize_t read = 0;
-	ssize_t virtr = 0;
+	ssize_t read, virtr, sz;
 	char * kbuf; /* k-addr because vread() takes vmlist_lock rwlock */
-		
+
+	read = 0;
+	virtr = 0;
 	if (p < (unsigned long) high_memory) {
 		read = count;
 		if (count > (unsigned long) high_memory - p)
 			read = (unsigned long) high_memory - p;
 
-#if defined(__sparc__) || (defined(__mc68000__) && defined(CONFIG_MMU))
+#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
 		/* we don't have page 0 mapped on sparc and m68k.. */
 		if (p < PAGE_SIZE && read > 0) {
 			size_t tmp = PAGE_SIZE - p;
@@ -243,11 +290,31 @@ static ssize_t read_kmem(struct file *fi
 			count -= tmp;
 		}
 #endif
-		if (copy_to_user(buf, (char *)p, read))
-			return -EFAULT;
-		p += read;
-		buf += read;
-		count -= read;
+		while (read > 0) {
+			/*
+			 * Handle first page in case it's not aligned
+			 */
+			if (-p & (PAGE_SIZE - 1))
+				sz = -p & (PAGE_SIZE - 1);
+			else
+				sz = PAGE_SIZE;
+
+			sz = min_t(unsigned long, sz, count);
+
+			/*
+			 * On ia64 if a page has been mapped somewhere as
+			 * uncached, then it must also be accessed uncached
+			 * by the kernel or data corruption may occur
+			 */
+			kbuf = xlate_dev_kmem_ptr((char *)p);
+
+			if (copy_to_user(buf, kbuf, sz))
+				return -EFAULT;
+			buf += sz;
+			p += sz;
+			read -= sz;
+			count -= sz;
+		}
 	}
 
 	if (count > 0) {
@@ -277,6 +344,70 @@ static ssize_t read_kmem(struct file *fi
  	return virtr + read;
 }
 
+
+static inline ssize_t
+do_write_kmem(void *p, unsigned long realp, const char __user * buf,
+	      size_t count, loff_t *ppos)
+{
+	ssize_t written, sz;
+	unsigned long copied;
+
+	written = 0;
+#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
+	/* we don't have page 0 mapped on sparc and m68k.. */
+	if (realp < PAGE_SIZE) {
+		unsigned long sz = PAGE_SIZE - realp;
+		if (sz > count)
+			sz = count;
+		/* Hmm. Do something? */
+		buf += sz;
+		p += sz;
+		realp += sz;
+		count -= sz;
+		written += sz;
+	}
+#endif
+
+	while (count > 0) {
+		char *ptr;
+		/*
+		 * Handle first page in case it's not aligned
+		 */
+		if (-realp & (PAGE_SIZE - 1))
+			sz = -realp & (PAGE_SIZE - 1);
+		else
+			sz = PAGE_SIZE;
+
+		sz = min_t(unsigned long, sz, count);
+
+		/*
+		 * On ia64 if a page has been mapped somewhere as
+		 * uncached, then it must also be accessed uncached
+		 * by the kernel or data corruption may occur
+		 */
+		ptr = xlate_dev_kmem_ptr(p);
+
+		copied = copy_from_user(ptr, buf, sz);
+		if (copied) {
+			ssize_t ret;
+
+			ret = written + (sz - copied);
+			if (ret)
+				return ret;
+			return -EFAULT;
+		}
+		buf += sz;
+		p += sz;
+		realp += sz;
+		count -= sz;
+		written += sz;
+	}
+
+	*ppos += written;
+	return written;
+}
+
+
 /*
  * This function writes to the *virtual* memory as seen by the kernel.
  */
@@ -295,7 +426,7 @@ static ssize_t write_kmem(struct file * 
 		if (count > (unsigned long) high_memory - p)
 			wrote = (unsigned long) high_memory - p;
 
-		written = do_write_mem((void*)p, p, buf, wrote, ppos);
+		written = do_write_kmem((void*)p, p, buf, wrote, ppos);
 		if (written != wrote)
 			return written;
 		wrote = written;
diff -puN include/asm-alpha/io.h~ia64-specific-dev-mem-handlers include/asm-alpha/io.h
--- 25/include/asm-alpha/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-alpha/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -666,6 +666,17 @@ isa_memcpy_toio(unsigned long offset, co
 #define writeq writeq
 #define readq readq
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __KERNEL__ */
 
 #endif /* __ALPHA_IO_H */
diff -puN include/asm-arm26/io.h~ia64-specific-dev-mem-handlers include/asm-arm26/io.h
--- 25/include/asm-arm26/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-arm26/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -420,5 +420,16 @@ extern void consistent_sync(void *vaddr,
 #define BIOVEC_MERGEABLE(vec1, vec2)	\
 	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_ARM_IO_H */
diff -puN include/asm-arm/io.h~ia64-specific-dev-mem-handlers include/asm-arm/io.h
--- 25/include/asm-arm/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-arm/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -271,5 +271,16 @@ extern void __iounmap(void __iomem *addr
 #define BIOVEC_MERGEABLE(vec1, vec2)	\
 	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_ARM_IO_H */
diff -puN include/asm-cris/io.h~ia64-specific-dev-mem-handlers include/asm-cris/io.h
--- 25/include/asm-cris/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-cris/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -86,4 +86,15 @@ extern void iounmap(void *addr);
 #define outsw(x,y,z)
 #define outsl(x,y,z)
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif
diff -puN include/asm-frv/io.h~ia64-specific-dev-mem-handlers include/asm-frv/io.h
--- 25/include/asm-frv/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-frv/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -273,6 +273,18 @@ static inline void flush_write_buffers(v
 	__asm__ __volatile__ ("membar" : : :"memory");
 }
 
+
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_IO_H */
diff -puN include/asm-h8300/io.h~ia64-specific-dev-mem-handlers include/asm-h8300/io.h
--- 25/include/asm-h8300/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-h8300/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -317,6 +317,17 @@ static __inline__ void ctrl_outl(unsigne
 #define virt_to_bus virt_to_phys
 #define bus_to_virt phys_to_virt
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __KERNEL__ */
 
 #endif /* _H8300_IO_H */
diff -puN include/asm-i386/io.h~ia64-specific-dev-mem-handlers include/asm-i386/io.h
--- 25/include/asm-i386/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-i386/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -49,6 +49,17 @@
 
 #include <linux/vmalloc.h>
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 /**
  *	virt_to_phys	-	map virtual addresses to physical
  *	@address: address to remap
diff -puN include/asm-ia64/uaccess.h~ia64-specific-dev-mem-handlers include/asm-ia64/uaccess.h
--- 25/include/asm-ia64/uaccess.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-ia64/uaccess.h	2005-03-09 22:44:39.000000000 -0800
@@ -35,6 +35,8 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/page-flags.h>
+#include <linux/mm.h>
 
 #include <asm/intrinsics.h>
 #include <asm/pgtable.h>
@@ -367,4 +369,38 @@ ia64_done_with_exception (struct pt_regs
 	return 0;
 }
 
+#define ARCH_HAS_TRANSLATE_MEM_PTR	1
+static __inline__ char *
+xlate_dev_mem_ptr (unsigned long p)
+{
+	struct page *page;
+	char * ptr;
+
+	page = pfn_to_page(p >> PAGE_SHIFT);
+	if (PageUncached(page))
+		ptr = (char *)p + __IA64_UNCACHED_OFFSET;
+	else
+		ptr = __va(p);
+
+	return ptr;
+}
+
+/*
+ * Convert a virtual cached kernel memory pointer to an uncached pointer
+ */
+static __inline__ char *
+xlate_dev_kmem_ptr (char * p)
+{
+	struct page *page;
+	char * ptr;
+
+	page = virt_to_page((unsigned long)p >> PAGE_SHIFT);
+	if (PageUncached(page))
+		ptr = (char *)__pa(p) + __IA64_UNCACHED_OFFSET;
+	else
+		ptr = p;
+
+	return ptr;
+}
+
 #endif /* _ASM_IA64_UACCESS_H */
diff -puN include/asm-m32r/io.h~ia64-specific-dev-mem-handlers include/asm-m32r/io.h
--- 25/include/asm-m32r/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-m32r/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -216,6 +216,17 @@ memcpy_toio(volatile void __iomem *dst, 
 	memcpy((void __force *) dst, src, count);
 }
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif  /* __KERNEL__ */
 
 #endif  /* _ASM_M32R_IO_H */
diff -puN include/asm-m68k/io.h~ia64-specific-dev-mem-handlers include/asm-m68k/io.h
--- 25/include/asm-m68k/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-m68k/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -359,4 +359,18 @@ extern void dma_cache_inv(unsigned long 
 #endif
 
 #endif /* __KERNEL__ */
+
+#define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
+
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* _IO_H */
diff -puN include/asm-m68knommu/io.h~ia64-specific-dev-mem-handlers include/asm-m68knommu/io.h
--- 25/include/asm-m68knommu/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-m68knommu/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -187,6 +187,17 @@ extern void iounmap(void *addr);
 #define virt_to_bus virt_to_phys
 #define bus_to_virt phys_to_virt
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __KERNEL__ */
 
 #endif /* _M68KNOMMU_IO_H */
diff -puN include/asm-mips/io.h~ia64-specific-dev-mem-handlers include/asm-mips/io.h
--- 25/include/asm-mips/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-mips/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -616,4 +616,15 @@ extern void (*_dma_cache_inv)(unsigned l
 #define csr_out32(v,a) (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST) = (v))
 #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST))
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* _ASM_IO_H */
diff -puN include/asm-parisc/io.h~ia64-specific-dev-mem-handlers include/asm-parisc/io.h
--- 25/include/asm-parisc/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-parisc/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -403,4 +403,15 @@ extern void outsl (unsigned long port, c
 
 #include <asm-generic/iomap.h>
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif
diff -puN include/asm-ppc64/io.h~ia64-specific-dev-mem-handlers include/asm-ppc64/io.h
--- 25/include/asm-ppc64/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-ppc64/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -442,6 +442,17 @@ out:
 extern int check_legacy_ioport(unsigned long base_port);
 
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __KERNEL__ */
 
 #endif /* _PPC64_IO_H */
diff -puN include/asm-ppc/io.h~ia64-specific-dev-mem-handlers include/asm-ppc/io.h
--- 25/include/asm-ppc/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-ppc/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -552,4 +552,15 @@ extern void pci_iounmap(struct pci_dev *
 #include <asm/mpc8260_pci9.h>
 #endif
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __KERNEL__ */
diff -puN include/asm-s390/io.h~ia64-specific-dev-mem-handlers include/asm-s390/io.h
--- 25/include/asm-s390/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-s390/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -107,6 +107,17 @@ extern void iounmap(void *addr);
 
 #define mmiowb()
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __KERNEL__ */
 
 #endif
diff -puN include/asm-sparc64/io.h~ia64-specific-dev-mem-handlers include/asm-sparc64/io.h
--- 25/include/asm-sparc64/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-sparc64/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -485,6 +485,17 @@ extern void pci_iounmap(struct pci_dev *
 #define dma_cache_wback(_start,_size)		do { } while (0)
 #define dma_cache_wback_inv(_start,_size)	do { } while (0)
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif
 
 #endif /* !(__SPARC64_IO_H) */
diff -puN include/asm-sparc/io.h~ia64-specific-dev-mem-handlers include/asm-sparc/io.h
--- 25/include/asm-sparc/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-sparc/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -274,4 +274,17 @@ extern void sbus_iounmap(volatile void _
 
 #endif
 
+#define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
+
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* !(__SPARC_IO_H) */
diff -puN include/asm-um/io.h~ia64-specific-dev-mem-handlers include/asm-um/io.h
--- 25/include/asm-um/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-um/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -22,4 +22,15 @@ static inline void * phys_to_virt(unsign
 	return __va(address);
 }
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif
diff -puN include/asm-v850/io.h~ia64-specific-dev-mem-handlers include/asm-v850/io.h
--- 25/include/asm-v850/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-v850/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -119,4 +119,15 @@ outsl (unsigned long port, const void *s
 #define memcpy_fromio(dst, src, len) memcpy (dst, (void *)src, len)
 #define memcpy_toio(dst, src, len) memcpy ((void *)dst, src, len)
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __V850_IO_H__ */
diff -puN include/asm-x86_64/io.h~ia64-specific-dev-mem-handlers include/asm-x86_64/io.h
--- 25/include/asm-x86_64/io.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/asm-x86_64/io.h	2005-03-09 22:44:39.000000000 -0800
@@ -329,6 +329,17 @@ out:
 extern int iommu_bio_merge;
 #define BIO_VMERGE_BOUNDARY iommu_bio_merge
 
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
 #endif /* __KERNEL__ */
 
 #endif
diff -puN include/linux/page-flags.h~ia64-specific-dev-mem-handlers include/linux/page-flags.h
--- 25/include/linux/page-flags.h~ia64-specific-dev-mem-handlers	2005-03-09 22:44:39.000000000 -0800
+++ 25-akpm/include/linux/page-flags.h	2005-03-09 22:44:39.000000000 -0800
@@ -75,7 +75,7 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_nosave_free		19	/* Free, should not be written */
-
+#define PG_uncached		20	/* Page has been mapped as uncached */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -301,6 +301,10 @@ extern void __mod_page_state(unsigned of
 #define PageSwapCache(page)	0
 #endif
 
+#define PageUncached(page)	test_bit(PG_uncached, &(page)->flags)
+#define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
+#define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
_

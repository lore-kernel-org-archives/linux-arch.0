Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268861AbUIQPLv@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59921 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268860AbUIQPLv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Sep 2004 11:11:51 -0400
Date: Fri, 17 Sep 2004 16:11:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] flush_cache_page in kernel/ptrace.c
Message-ID: <20040917161147.A32026@flint.arm.linux.org.uk>
References: <20040909225643.G6434@flint.arm.linux.org.uk> <Pine.LNX.4.58.0409091658370.5912@ppc970.osdl.org> <20040910162330.F22599@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910162330.F22599@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Sep 10, 2004 at 04:23:30PM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
To: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, Sep 10, 2004 at 04:23:30PM +0100, Russell King wrote:
> That's fine by me - please send your patches my way. 8)

Here's a patch which I've put together to achieve the first stage.
We remove flush_cache_page() from kernel/ptrace.c, adding it to
the arch-specific copy_{to,from}_user_page() where flush_cache_page
is non-empty.

Can architecture people test and check this patch please?

Thanks.

===== Documentation/cachetlb.txt 1.11 vs edited =====
--- 1.11/Documentation/cachetlb.txt	2004-07-11 01:14:00 +01:00
+++ edited/Documentation/cachetlb.txt	2004-09-17 14:50:31 +01:00
@@ -354,10 +354,6 @@
 	of arbitrary user pages (f.e. for ptrace()) it will use
 	these two routines.
 
-	The page has been kmap()'d, and flush_cache_page() has
-	just been called for the user mapping of this page (if
-	necessary).
-
 	Any necessary cache flushing or other coherency operations
 	that need to occur should happen here.  If the processor's
 	instruction cache does not snoop cpu stores, it is very
===== kernel/ptrace.c 1.36 vs edited =====
--- 1.36/kernel/ptrace.c	2004-09-08 07:32:59 +01:00
+++ edited/kernel/ptrace.c	2004-09-17 14:39:19 +01:00
@@ -202,8 +202,6 @@
 		if (bytes > PAGE_SIZE-offset)
 			bytes = PAGE_SIZE-offset;
 
-		flush_cache_page(vma, addr);
-
 		maddr = kmap(page);
 		if (write) {
 			copy_to_user_page(vma, page, addr,
===== include/asm-arm/cacheflush.h 1.15 vs edited =====
--- 1.15/include/asm-arm/cacheflush.h	2004-09-07 14:43:06 +01:00
+++ edited/include/asm-arm/cacheflush.h	2004-09-17 15:15:48 +01:00
@@ -237,11 +237,17 @@
  * space" model to handle this.
  */
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-do { memcpy(dst, src, len); \
-     flush_icache_user_range(vma, page, vaddr, len); \
-} while (0)
+	do {					\
+		flush_cache_page(vma, vaddr);	\
+		memcpy(dst, src, len);		\
+		flush_dcache_page(page);	\
+	} while (0)
+
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+	do {					\
+		flush_cache_page(vma, vaddr);	\
+		memcpy(dst, src, len);		\
+	} while (0)
 
 /*
  * Convert calls to our calling convention.
===== include/asm-m68k/cacheflush.h 1.9 vs edited =====
--- 1.9/include/asm-m68k/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-m68k/cacheflush.h	2004-09-17 15:15:21 +01:00
@@ -132,10 +132,18 @@
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 #define flush_icache_page(vma, page)	__flush_page_to_ram(page_address(page))
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
+
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+	do {					\
+		flush_cache_page(vma, vaddr);	\
+		memcpy(dst, src, len);		\
+	} while (0)
+
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+	do {					\
+		flush_cache_page(vma, vaddr);	\
+		memcpy(dst, src, len);		\
+	} while (0)
 
 extern void flush_icache_range(unsigned long address, unsigned long endaddr);
 
===== include/asm-parisc/cacheflush.h 1.11 vs edited =====
--- 1.11/include/asm-parisc/cacheflush.h	2004-08-13 09:23:36 +01:00
+++ edited/include/asm-parisc/cacheflush.h	2004-09-17 16:04:02 +01:00
@@ -77,11 +77,17 @@
 #define flush_icache_range(s,e)		do { flush_kernel_dcache_range_asm(s,e); flush_kernel_icache_range_asm(s,e); } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-do { memcpy(dst, src, len); \
-     flush_kernel_dcache_range_asm((unsigned long)dst, (unsigned long)dst + len); \
+do { \
+	flush_cache_page(vma, vaddr); \
+	memcpy(dst, src, len); \
+	flush_kernel_dcache_range_asm((unsigned long)dst, (unsigned long)dst + len); \
 } while (0)
+
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+do { \
+	flush_cache_page(vma, vaddr); \
+	memcpy(dst, src, len); \
+} while (0)
 
 static inline void flush_cache_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end)
===== include/asm-sh64/cacheflush.h 1.1 vs edited =====
--- 1.1/include/asm-sh64/cacheflush.h	2004-06-29 15:44:46 +01:00
+++ edited/include/asm-sh64/cacheflush.h	2004-09-17 15:31:42 +01:00
@@ -30,13 +30,17 @@
 #define flush_icache_page(vma, page)	do { } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-do { memcpy(dst, src, len); \
-     flush_icache_user_range(vma, page, vaddr, len); \
-} while (0)
+	do {							\
+		flush_cache_page(vma, vaddr);			\
+		memcpy(dst, src, len);				\
+		flush_icache_user_range(vma, page, vaddr, len);	\
+	} while (0)
 
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
-
+	do {							\
+		flush_cache_page(vma, vaddr);			\
+		memcpy(dst, src, len);				\
+	} while (0)
 
 #endif /* __ASSEMBLY__ */
 
===== include/asm-sh/cacheflush.h 1.2 vs edited =====
--- 1.2/include/asm-sh/cacheflush.h	2003-10-02 08:11:59 +01:00
+++ edited/include/asm-sh/cacheflush.h	2004-09-17 15:29:45 +01:00
@@ -14,10 +14,16 @@
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-do { memcpy(dst, src, len); \
-     flush_icache_user_range(vma, page, vaddr, len); \
-} while (0)
+	do {							\
+		flush_cache_page(vma, vaddr);			\
+		memcpy(dst, src, len);				\
+		flush_icache_user_range(vma, page, vaddr, len);	\
+	} while (0)
+
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+	do {							\
+		flush_cache_page(vma, vaddr);			\
+		memcpy(dst, src, len);				\
+	} while (0)
 
 #endif /* __ASM_SH_CACHEFLUSH_H */
===== include/asm-sparc64/cacheflush.h 1.6 vs edited =====
--- 1.6/include/asm-sparc64/cacheflush.h	2004-08-07 07:01:03 +01:00
+++ edited/include/asm-sparc64/cacheflush.h	2004-09-17 15:58:35 +01:00
@@ -38,9 +38,16 @@
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+	do {					\
+		flush_cache_page(vma, vaddr);	\
+		memcpy(dst, src, len);		\
+	} while (0)
+
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+	do {					\
+		flush_cache_page(vma, vaddr);	\
+		memcpy(dst, src, len);		\
+	} while (0)
 
 extern void flush_dcache_page(struct page *page);
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
===== include/asm-sparc/cacheflush.h 1.5 vs edited =====
--- 1.5/include/asm-sparc/cacheflush.h	2004-05-22 22:56:28 +01:00
+++ edited/include/asm-sparc/cacheflush.h	2004-09-17 15:57:49 +01:00
@@ -57,9 +57,15 @@
 #define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+	do {					\
+		flush_cache_page(vma, vaddr);	\
+		memcpy(dst, src, len);		\
+	} while (0)
 #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
-	memcpy(dst, src, len)
+	do {					\
+		flush_cache_page(vma, vaddr);	\
+		memcpy(dst, src, len);		\
+	} while (0)
 
 BTFIXUPDEF_CALL(void, __flush_page_to_ram, unsigned long)
 BTFIXUPDEF_CALL(void, flush_sig_insns, struct mm_struct *, unsigned long)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

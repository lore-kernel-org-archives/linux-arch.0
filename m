Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:24542 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751101AbWIATIJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2006 15:08:09 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k81J89n6020924
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 15:08:09 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k81J88Pb275178
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 15:08:08 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k81J88Ut028233
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 15:08:08 -0400
Subject: [PATCH 3/9] actual generic PAGE_SIZE infrastructure
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 01 Sep 2006 12:08:07 -0700
References: <20060901190805.C906A21A@localhost.localdomain>
In-Reply-To: <20060901190805.C906A21A@localhost.localdomain>
Message-Id: <20060901190807.522EDD97@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Dave Hansen <haveblue@us.ibm.com>
List-ID: <linux-arch.vger.kernel.org>


* Add _ALIGN_UP() which we'll use now and _ALIGN_DOWN(), just for
  parity.
* Define ASM_CONST() macro to help using constants in both assembly
  and C code.  Several architectures have some form of this, and
  they will be consolidated around this one.
* Actually create PAGE_SHIFT and PAGE_SIZE macros
* For now, require that architectures enable GENERIC_PAGE_SIZE in
  order to get this new code.  This option will be removed by the
  last patch in the series, and makes the series bisect-safe.
* Note that this moves the compiler.h define outside of the
  #ifdef __KERNEL__, but that's OK because it has its own.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 threadalloc-dave/include/asm-generic/page.h |   29 +++++++++++++++++-
 threadalloc-dave/mm/Kconfig                 |   44 ++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 2 deletions(-)

diff -puN include/asm-generic/page.h~generic-PAGE_SIZE-infrastructure include/asm-generic/page.h
--- threadalloc/include/asm-generic/page.h~generic-PAGE_SIZE-infrastructure	2006-09-01 11:30:54.000000000 -0700
+++ threadalloc-dave/include/asm-generic/page.h	2006-09-01 11:30:55.000000000 -0700
@@ -1,11 +1,36 @@
 #ifndef _ASM_GENERIC_PAGE_H
 #define _ASM_GENERIC_PAGE_H
 
+#include <linux/compiler.h>
+#include <linux/align.h>
+
 #ifdef __KERNEL__
-#ifndef __ASSEMBLY__
 
-#include <linux/compiler.h>
+#ifdef __ASSEMBLY__
+#define ASM_CONST(x) x
+#else
+#define __ASM_CONST(x) x##UL
+#define ASM_CONST(x) __ASM_CONST(x)
+#endif
+
+#ifdef CONFIG_ARCH_GENERIC_PAGE_SIZE
+
+#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
+#define PAGE_SIZE       (ASM_CONST(1) << PAGE_SHIFT)
+
+/*
+ * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
+ * assign PAGE_MASK to a larger type it gets extended the way we want
+ * (i.e. with 1s in the high bits)
+ */
+#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))
 
+/* to align the pointer to the (next) page boundary */
+#define PAGE_ALIGN(addr)        ALIGN(addr, PAGE_SIZE)
+
+#endif /* CONFIG_ARCH_GENERIC_PAGE_SIZE */
+
+#ifndef __ASSEMBLY__
 #ifndef CONFIG_ARCH_HAVE_GET_ORDER
 /* Pure 2^n version of get_order */
 static __inline__ __attribute_const__ int get_order(unsigned long size)
diff -puN mm/Kconfig~generic-PAGE_SIZE-infrastructure mm/Kconfig
--- threadalloc/mm/Kconfig~generic-PAGE_SIZE-infrastructure	2006-09-01 11:30:54.000000000 -0700
+++ threadalloc-dave/mm/Kconfig	2006-09-01 11:30:55.000000000 -0700
@@ -2,6 +2,50 @@ config ARCH_HAVE_GET_ORDER
 	def_bool y
 	depends on IA64 || PPC32 || XTENSA
 
+choice
+	prompt "Kernel page size"
+	depends on ARCH_GENERIC_PAGE_SIZE
+config PAGE_SIZE_4KB
+	bool "4KB"
+	help
+	  The kernel page size determines the basic chunk of memory handled
+	  by the Linux VM.  If these pages are larger, the kernel can
+	  use the same amount of physical memory with fewer data structures.
+	  This reduces the VM overhead in handling large amounts of data.
+	  Larger pages can also lead to better TLB coverage for large memory
+	  applications.
+
+	  However, larger pages also lead to memory being wasted by the
+	  kernel since all files require a minimum of one page of memory.
+	  With a 64KB page size, a 1 byte file will consume 64KB of memory.
+
+	  A 4KB pagesize is fairly standard and may be required for 32-bit
+	  compatibility on many platforms.
+
+	  It is usually not wise to select another page size than the default.
+
+config PAGE_SIZE_8KB
+	bool "8KB"
+config PAGE_SIZE_16KB
+	bool "16KB"
+config PAGE_SIZE_64KB
+	bool "64KB"
+config PAGE_SIZE_512KB
+	bool "512KB"
+config PAGE_SIZE_4MB
+	bool "4MB"
+endchoice
+
+config PAGE_SHIFT
+	int
+	depends on ARCH_GENERIC_PAGE_SIZE
+	default "13" if PAGE_SIZE_8KB
+	default "14" if PAGE_SIZE_16KB
+	default "16" if PAGE_SIZE_64KB
+	default "19" if PAGE_SIZE_512KB
+	default "22" if PAGE_SIZE_4MB
+	default "12"
+
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on EXPERIMENTAL || ARCH_SELECT_MEMORY_MODEL
_

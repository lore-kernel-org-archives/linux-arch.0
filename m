Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:40121 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751124AbWIATIM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2006 15:08:12 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k81J8BYP001949
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 15:08:11 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k81J8BsB264502
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 15:08:11 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k81J8BLY011438
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 15:08:11 -0400
Subject: [PATCH 8/9] powerpc generic PAGE_SIZE
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 01 Sep 2006 12:08:10 -0700
References: <20060901190805.C906A21A@localhost.localdomain>
In-Reply-To: <20060901190805.C906A21A@localhost.localdomain>
Message-Id: <20060901190810.4A12962F@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Dave Hansen <haveblue@us.ibm.com>
List-ID: <linux-arch.vger.kernel.org>


This is the powerpc portion to convert it over to the generic PAGE_SIZE
framework.

* add powerpc default of 64k pages to mm/Kconfig, when the 64k
  option is enabled.  Defaults to 4k otherwise.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 threadalloc-dave/include/asm-powerpc/page.h |   24 +-----------------------
 threadalloc-dave/include/asm-ppc/page.h     |   15 +--------------
 threadalloc-dave/arch/powerpc/Kconfig       |    5 ++++-
 threadalloc-dave/arch/powerpc/boot/page.h   |    3 ---
 threadalloc-dave/mm/Kconfig                 |    2 +-
 5 files changed, 7 insertions(+), 42 deletions(-)

diff -puN include/asm-powerpc/page.h~powerpc include/asm-powerpc/page.h
--- threadalloc/include/asm-powerpc/page.h~powerpc	2006-09-01 11:30:53.000000000 -0700
+++ threadalloc-dave/include/asm-powerpc/page.h	2006-09-01 11:30:59.000000000 -0700
@@ -12,33 +12,14 @@
 
 #ifdef __KERNEL__
 #include <linux/align.h>
+#include <asm-generic/page.h>
 #include <asm/asm-compat.h>
 #include <asm/kdump.h>
 
-/*
- * On PPC32 page size is 4K. For PPC64 we support either 4K or 64K software
- * page size. When using 64K pages however, whether we are really supporting
- * 64K pages in HW or not is irrelevant to those definitions.
- */
-#ifdef CONFIG_PPC_64K_PAGES
-#define PAGE_SHIFT		16
-#else
-#define PAGE_SHIFT		12
-#endif
-
-#define PAGE_SIZE		(ASM_CONST(1) << PAGE_SHIFT)
-
 /* We do define AT_SYSINFO_EHDR but don't use the gate mechanism */
 #define __HAVE_ARCH_GATE_AREA		1
 
 /*
- * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
- * assign PAGE_MASK to a larger type it gets extended the way we want
- * (i.e. with 1s in the high bits)
- */
-#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))
-
-/*
  * KERNELBASE is the virtual address of the start of the kernel, it's often
  * the same as PAGE_OFFSET, but _might not be_.
  *
@@ -90,9 +71,6 @@
 #include <asm/page_32.h>
 #endif
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	ALIGN(addr, PAGE_SIZE)
-
 /*
  * Don't compare things with KERNELBASE or PAGE_OFFSET to test for
  * "kernelness", use is_kernel_addr() - it should do what you want.
diff -puN include/asm-ppc/page.h~powerpc include/asm-ppc/page.h
--- threadalloc/include/asm-ppc/page.h~powerpc	2006-09-01 11:30:53.000000000 -0700
+++ threadalloc-dave/include/asm-ppc/page.h	2006-09-01 11:30:59.000000000 -0700
@@ -3,16 +3,7 @@
 
 #include <linux/align.h>
 #include <asm/asm-compat.h>
-
-/* PAGE_SHIFT determines the page size */
-#define PAGE_SHIFT	12
-#define PAGE_SIZE	(ASM_CONST(1) << PAGE_SHIFT)
-
-/*
- * Subtle: this is an int (not an unsigned long) and so it
- * gets extended to 64 bits the way want (i.e. with 1s).  -- paulus
- */
-#define PAGE_MASK	(~((1 << PAGE_SHIFT) - 1))
+#include <asm-generic/page.h>
 
 #ifdef __KERNEL__
 
@@ -37,10 +28,6 @@ typedef unsigned long pte_basic_t;
 #define PTE_FMT		"%.8lx"
 #endif
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	ALIGN(addr, PAGE_SIZE)
-
-
 #undef STRICT_MM_TYPECHECKS
 
 #ifdef STRICT_MM_TYPECHECKS
diff -puN arch/powerpc/Kconfig~powerpc arch/powerpc/Kconfig
--- threadalloc/arch/powerpc/Kconfig~powerpc	2006-09-01 11:28:14.000000000 -0700
+++ threadalloc-dave/arch/powerpc/Kconfig	2006-09-01 11:30:59.000000000 -0700
@@ -725,8 +725,11 @@ config ARCH_MEMORY_PROBE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
+config ARCH_GENERIC_PAGE_SIZE
+	def_bool y
+
 config PPC_64K_PAGES
-	bool "64k page size"
+	bool "enable 64k page size"
 	depends on PPC64
 	help
 	  This option changes the kernel logical page size to 64k. On machines
diff -puN arch/powerpc/boot/page.h~powerpc arch/powerpc/boot/page.h
--- threadalloc/arch/powerpc/boot/page.h~powerpc	2006-09-01 11:28:14.000000000 -0700
+++ threadalloc-dave/arch/powerpc/boot/page.h	2006-09-01 11:30:59.000000000 -0700
@@ -28,7 +28,4 @@
 /* align addr on a size boundary - adjust address up if needed */
 #define _ALIGN(addr,size)     _ALIGN_UP(addr,size)
 
-/* to align the pointer to the (next) page boundary */
-#define PAGE_ALIGN(addr)	_ALIGN(addr, PAGE_SIZE)
-
 #endif				/* _PPC_BOOT_PAGE_H */
diff -puN mm/Kconfig~powerpc mm/Kconfig
--- threadalloc/mm/Kconfig~powerpc	2006-09-01 11:30:59.000000000 -0700
+++ threadalloc-dave/mm/Kconfig	2006-09-01 11:30:59.000000000 -0700
@@ -51,7 +51,7 @@ config PAGE_SHIFT
 	depends on ARCH_GENERIC_PAGE_SIZE
 	default "13" if PAGE_SIZE_8KB
 	default "14" if PAGE_SIZE_16KB
-	default "16" if PAGE_SIZE_64KB
+	default "16" if PAGE_SIZE_64KB || PPC_64K_PAGES
 	default "19" if PAGE_SIZE_512KB
 	default "22" if PAGE_SIZE_4MB
 	default "12"
_

From: akpm@linux-foundation.org
Subject: [patch 140/200] mm: remove duplicate asm/mman.h files
Date: Mon, 21 Sep 2009 17:03:48 -0700
Message-ID: <200909220003.n8M03nGn032383@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41519 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752901AbZIVAWs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 21 Sep 2009 20:22:48 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A number of architectures have identical asm/mman.h files so they can all
be merged by using the new generic file.

The remaining asm/mman.h files are substantially different from each
other.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/include/asm/mman.h     |   20 -------------------
 arch/avr32/include/asm/mman.h   |   20 -------------------
 arch/cris/include/asm/mman.h    |   22 ---------------------
 arch/frv/include/asm/mman.h     |   21 --------------------
 arch/h8300/include/asm/mman.h   |   20 -------------------
 arch/ia64/include/asm/mman.h    |   16 +--------------
 arch/m32r/include/asm/mman.h    |   20 -------------------
 arch/m68k/include/asm/mman.h    |   20 -------------------
 arch/mn10300/include/asm/mman.h |   31 ------------------------------
 arch/s390/include/asm/mman.h    |   15 --------------
 10 files changed, 11 insertions(+), 194 deletions(-)

diff -puN arch/arm/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files arch/arm/include/asm/mman.h
--- a/arch/arm/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files
+++ a/arch/arm/include/asm/mman.h
@@ -1,19 +1 @@
-#ifndef __ARM_MMAN_H__
-#define __ARM_MMAN_H__
-
-#include <asm-generic/mman-common.h>
-
-#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define MAP_LOCKED	0x2000		/* pages are locked */
-#define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) page tables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
-
-#endif /* __ARM_MMAN_H__ */
+#include <asm-generic/mman.h>
diff -puN arch/avr32/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files arch/avr32/include/asm/mman.h
--- a/arch/avr32/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files
+++ a/arch/avr32/include/asm/mman.h
@@ -1,19 +1 @@
-#ifndef __ASM_AVR32_MMAN_H__
-#define __ASM_AVR32_MMAN_H__
-
-#include <asm-generic/mman-common.h>
-
-#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define MAP_LOCKED	0x2000		/* pages are locked */
-#define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) page tables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
-
-#endif /* __ASM_AVR32_MMAN_H__ */
+#include <asm-generic/mman.h>
diff -puN arch/cris/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files arch/cris/include/asm/mman.h
--- a/arch/cris/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files
+++ a/arch/cris/include/asm/mman.h
@@ -1,21 +1 @@
-#ifndef __CRIS_MMAN_H__
-#define __CRIS_MMAN_H__
-
-/* verbatim copy of asm-i386/ version */
-
-#include <asm-generic/mman-common.h>
-
-#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define MAP_LOCKED	0x2000		/* pages are locked */
-#define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
-
-#endif /* __CRIS_MMAN_H__ */
+#include <asm-generic/mman.h>
diff -puN arch/frv/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files arch/frv/include/asm/mman.h
--- a/arch/frv/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files
+++ a/arch/frv/include/asm/mman.h
@@ -1,20 +1 @@
-#ifndef __ASM_MMAN_H__
-#define __ASM_MMAN_H__
-
-#include <asm-generic/mman-common.h>
-
-#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define MAP_LOCKED	0x2000		/* pages are locked */
-#define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
-
-#endif /* __ASM_MMAN_H__ */
-
+#include <asm-generic/mman.h>
diff -puN arch/h8300/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files arch/h8300/include/asm/mman.h
--- a/arch/h8300/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files
+++ a/arch/h8300/include/asm/mman.h
@@ -1,19 +1 @@
-#ifndef __H8300_MMAN_H__
-#define __H8300_MMAN_H__
-
-#include <asm-generic/mman-common.h>
-
-#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define MAP_LOCKED	0x2000		/* pages are locked */
-#define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
-
-#endif /* __H8300_MMAN_H__ */
+#include <asm-generic/mman.h>
diff -puN arch/ia64/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files arch/ia64/include/asm/mman.h
--- a/arch/ia64/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files
+++ a/arch/ia64/include/asm/mman.h
@@ -8,21 +8,9 @@
  *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
  */
 
-#include <asm-generic/mman-common.h>
+#include <asm-generic/mman.h>
 
-#define MAP_GROWSDOWN	0x00100		/* stack-like segment */
-#define MAP_GROWSUP	0x00200		/* register stack-like segment */
-#define MAP_DENYWRITE	0x00800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x01000		/* mark it as an executable */
-#define MAP_LOCKED	0x02000		/* pages are locked */
-#define MAP_NORESERVE	0x04000		/* don't check for reservations */
-#define MAP_POPULATE	0x08000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
+#define MAP_GROWSUP	0x0200		/* register stack-like segment */
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff -puN arch/m32r/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files arch/m32r/include/asm/mman.h
--- a/arch/m32r/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files
+++ a/arch/m32r/include/asm/mman.h
@@ -1,19 +1 @@
-#ifndef __M32R_MMAN_H__
-#define __M32R_MMAN_H__
-
-#include <asm-generic/mman-common.h>
-
-#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define MAP_LOCKED	0x2000		/* pages are locked */
-#define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
-
-#endif /* __M32R_MMAN_H__ */
+#include <asm-generic/mman.h>
diff -puN arch/m68k/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files arch/m68k/include/asm/mman.h
--- a/arch/m68k/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files
+++ a/arch/m68k/include/asm/mman.h
@@ -1,19 +1 @@
-#ifndef __M68K_MMAN_H__
-#define __M68K_MMAN_H__
-
-#include <asm-generic/mman-common.h>
-
-#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define MAP_LOCKED	0x2000		/* pages are locked */
-#define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
-
-#endif /* __M68K_MMAN_H__ */
+#include <asm-generic/mman.h>
diff -puN arch/mn10300/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files arch/mn10300/include/asm/mman.h
--- a/arch/mn10300/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files
+++ a/arch/mn10300/include/asm/mman.h
@@ -1,30 +1 @@
-/* MN10300 Constants for mmap and co.
- *
- * Copyright (C) 2007 Matsushita Electric Industrial Co., Ltd.
- * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
- * - Derived from asm-x86/mman.h
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public Licence
- * as published by the Free Software Foundation; either version
- * 2 of the Licence, or (at your option) any later version.
- */
-#ifndef _ASM_MMAN_H
-#define _ASM_MMAN_H
-
-#include <asm-generic/mman-common.h>
-
-#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define MAP_LOCKED	0x2000		/* pages are locked */
-#define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
-
-#endif /* _ASM_MMAN_H */
+#include <asm-generic/mman.h>
diff -puN arch/s390/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files arch/s390/include/asm/mman.h
--- a/arch/s390/include/asm/mman.h~mm-remove-duplicate-asm-mmanh-files
+++ a/arch/s390/include/asm/mman.h
@@ -9,20 +9,7 @@
 #ifndef __S390_MMAN_H__
 #define __S390_MMAN_H__
 
-#include <asm-generic/mman-common.h>
-
-#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define MAP_LOCKED	0x2000		/* pages are locked */
-#define MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB	0x40000		/* create a huge page mapping */
-
-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
+#include <asm-generic/mman.h>
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__) && defined(CONFIG_64BIT)
 int s390_mmap_check(unsigned long addr, unsigned long len);
_

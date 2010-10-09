Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62180 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760519Ab0JIT6J (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 9 Oct 2010 15:58:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/6] bitops: remove duplicated extern declarations
Date: Sat,  9 Oct 2010 21:57:52 +0200
Message-ID: <1286654272-21483-7-git-send-email-arnd@arndb.de>
In-Reply-To: <1286654272-21483-1-git-send-email-arnd@arndb.de>
References: <1286654272-21483-1-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20101009195752.ZpPqFwVnF2EfG1jGOGOFZ43SBk_osDgOqgRELa156EM@z>

From: Akinobu Mita <akinobu.mita@gmail.com>

If CONFIG_GENERIC_FIND_NEXT_BIT is enabled, find_next_bit() and
find_next_zero_bit() are doubly declared in asm-generic/bitops/find.h
and linux/bitops.h.

asm/bitops.h includes asm-generic/bitops/find.h if and only if the
architecture enables CONFIG_GENERIC_FIND_NEXT_BIT. And asm/bitops.h
is included by linux/bitops.h

So we can just remove the extern declarations of find_next_bit() and
find_next_zero_bit() in linux/bitops.h.

Also we can remove unneeded #ifndef CONFIG_GENERIC_FIND_NEXT_BIT in
asm-generic/bitops/find.h.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/bitops/find.h |   14 ++++++++++++--
 include/linux/bitops.h            |   23 -----------------------
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 30afec0..110fa70 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -1,13 +1,23 @@
 #ifndef _ASM_GENERIC_BITOPS_FIND_H_
 #define _ASM_GENERIC_BITOPS_FIND_H_
 
-#ifndef CONFIG_GENERIC_FIND_NEXT_BIT
+/**
+ * find_next_bit - find the next set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ */
 extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
 		size, unsigned long offset);
 
+/**
+ * find_next_zero_bit - find the next cleared bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ */
 extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned
 		long size, unsigned long offset);
-#endif
 
 #ifdef CONFIG_GENERIC_FIND_FIRST_BIT
 
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index adb0f11..827cc95 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -149,28 +149,5 @@ extern unsigned long find_last_bit(const unsigned long *addr,
 				   unsigned long size);
 #endif /* CONFIG_GENERIC_FIND_LAST_BIT */
 
-#ifdef CONFIG_GENERIC_FIND_NEXT_BIT
-
-/**
- * find_next_bit - find the next set bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The bitmap size in bits
- */
-extern unsigned long find_next_bit(const unsigned long *addr,
-				   unsigned long size, unsigned long offset);
-
-/**
- * find_next_zero_bit - find the next cleared bit in a memory region
- * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
- * @size: The bitmap size in bits
- */
-
-extern unsigned long find_next_zero_bit(const unsigned long *addr,
-					unsigned long size,
-					unsigned long offset);
-
-#endif /* CONFIG_GENERIC_FIND_NEXT_BIT */
 #endif /* __KERNEL__ */
 #endif
-- 
1.7.1


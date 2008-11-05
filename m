From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [RFC-PATCH 2/5] unaligned: convert arches where unaligned access
 is OK
Date: Wed, 05 Nov 2008 10:16:17 -0800
Message-ID: <1225908977.5991.181.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:5002 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbYKESQY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Nov 2008 13:16:24 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

No functional changes, just use the asm-generic header.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 arch/cris/include/asm/unaligned.h      |    7 ++-----
 arch/m68knommu/include/asm/unaligned.h |   22 +++++-----------------
 arch/powerpc/include/asm/unaligned.h   |    7 ++-----
 arch/s390/include/asm/unaligned.h      |    7 ++-----
 arch/x86/include/asm/unaligned.h       |    8 ++------
 include/asm-m68k/unaligned.h           |    7 ++-----
 include/asm-mn10300/unaligned.h        |   10 +++++-----
 7 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/arch/cris/include/asm/unaligned.h b/arch/cris/include/asm/unaligned.h
index 7b3f3fe..0634570 100644
--- a/arch/cris/include/asm/unaligned.h
+++ b/arch/cris/include/asm/unaligned.h
@@ -4,10 +4,7 @@
 /*
  * CRIS can do unaligned accesses itself. 
  */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
+#define _UNALIGNED_ACCESS_OK
+#include <asm-generic/unaligned.h>
 
 #endif /* _ASM_CRIS_UNALIGNED_H */
diff --git a/arch/m68knommu/include/asm/unaligned.h b/arch/m68knommu/include/asm/unaligned.h
index eb1ea4c..651419e 100644
--- a/arch/m68knommu/include/asm/unaligned.h
+++ b/arch/m68knommu/include/asm/unaligned.h
@@ -1,25 +1,13 @@
 #ifndef _ASM_M68KNOMMU_UNALIGNED_H
 #define _ASM_M68KNOMMU_UNALIGNED_H
 
-
-#ifdef CONFIG_COLDFIRE
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
-#else
 /*
- * The m68k can do unaligned accesses itself. 
+ * The m68k can do unaligned accesses itself.  COLDFIRE can not.
  */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
+#ifndef CONFIG_COLDFIRE
+# define _UNALIGNED_ACCESS_OK
 #endif
 
+#include <asm-generic/unaligned.h>
+
 #endif /* _ASM_M68KNOMMU_UNALIGNED_H */
diff --git a/arch/powerpc/include/asm/unaligned.h b/arch/powerpc/include/asm/unaligned.h
index 5f1b1e3..5fb95fc 100644
--- a/arch/powerpc/include/asm/unaligned.h
+++ b/arch/powerpc/include/asm/unaligned.h
@@ -6,11 +6,8 @@
 /*
  * The PowerPC can do unaligned accesses itself in big endian mode.
  */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#define _UNALIGNED_ACCESS_OK
+#include <asm-generic/unaligned.h>
 
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_UNALIGNED_H */
diff --git a/arch/s390/include/asm/unaligned.h b/arch/s390/include/asm/unaligned.h
index da9627a..69a4088 100644
--- a/arch/s390/include/asm/unaligned.h
+++ b/arch/s390/include/asm/unaligned.h
@@ -4,10 +4,7 @@
 /*
  * The S390 can do unaligned accesses itself. 
  */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#define _UNALIGNED_ACCESS_OK
+#include <asm-generic/unaligned.h>
 
 #endif /* _ASM_S390_UNALIGNED_H */
diff --git a/arch/x86/include/asm/unaligned.h b/arch/x86/include/asm/unaligned.h
index a7bd416..1ba0b8a 100644
--- a/arch/x86/include/asm/unaligned.h
+++ b/arch/x86/include/asm/unaligned.h
@@ -4,11 +4,7 @@
 /*
  * The x86 can do unaligned accesses itself.
  */
-
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned __get_unaligned_le
-#define put_unaligned __put_unaligned_le
+#define _UNALIGNED_ACCESS_OK
+#include <asm-generic/unaligned.h>
 
 #endif /* _ASM_X86_UNALIGNED_H */
diff --git a/include/asm-m68k/unaligned.h b/include/asm-m68k/unaligned.h
index 77698f2..2d92d6a 100644
--- a/include/asm-m68k/unaligned.h
+++ b/include/asm-m68k/unaligned.h
@@ -4,10 +4,7 @@
 /*
  * The m68k can do unaligned accesses itself.
  */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
+#define _UNALIGNED_ACCESS_OK
+#include <asm-generic/unaligned.h>
 
 #endif /* _ASM_M68K_UNALIGNED_H */
diff --git a/include/asm-mn10300/unaligned.h b/include/asm-mn10300/unaligned.h
index 0df6713..0ab409f 100644
--- a/include/asm-mn10300/unaligned.h
+++ b/include/asm-mn10300/unaligned.h
@@ -11,10 +11,10 @@
 #ifndef _ASM_MN10300_UNALIGNED_H
 #define _ASM_MN10300_UNALIGNED_H
 
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
+/*
+ * The MN10300 can do unaligned accesses itself.
+ */
+#define _UNALIGNED_ACCESS_OK
+#include <asm-generic/unaligned.h>
 
 #endif /* _ASM_MN10300_UNALIGNED_H */
-- 
1.6.0.3.756.gb776d

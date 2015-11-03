From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 26/28] asm-generic: vmlinux.lds.h: allow customized rodata section name
Date: Tue,  3 Nov 2015 22:20:57 +0200
Message-ID: <1446582059-17355-27-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Some architectures needs customized rodata section names (e.g. lkl for
Windows host). Allow them to set the rodata section name.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 arch/lkl/include/asm/vmlinux.lds.h | 5 -----
 include/asm-generic/vmlinux.lds.h  | 9 +++++++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/lkl/include/asm/vmlinux.lds.h b/arch/lkl/include/asm/vmlinux.lds.h
index 392c94a..7c1a640 100644
--- a/arch/lkl/include/asm/vmlinux.lds.h
+++ b/arch/lkl/include/asm/vmlinux.lds.h
@@ -2,14 +2,9 @@
 #define _LKL_VMLINUX_LDS_H
 
 #ifdef __MINGW32__
-#define VMLINUX_SYMBOL(sym) _##sym
 #define RODATA_SECTION .rdata
 #endif
 
 #include <asm-generic/vmlinux.lds.h>
 
-#ifndef RODATA_SECTION
-#define RODATA_SECTION .rodata
-#endif
-
 #endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1781e54..8bd8b90 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -241,11 +241,16 @@
 /*
  * Read only Data
  */
+
+#ifndef RODATA_SECTION
+#define RODATA_SECTION .rodata
+#endif
+
 #define RO_DATA_SECTION(align)						\
 	. = ALIGN((align));						\
-	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
+	RODATA_SECTION    : AT(ADDR(RODATA_SECTION) - LOAD_OFFSET) {	\
 		VMLINUX_SYMBOL(__start_rodata) = .;			\
-		*(.rodata) *(.rodata.*)					\
+		*(RODATA_SECTION) *(RODATA_SECTION.*)			\
 		*(__vermagic)		/* Kernel version magic */	\
 		. = ALIGN(8);						\
 		VMLINUX_SYMBOL(__start___tracepoints_ptrs) = .;		\
-- 
2.1.0

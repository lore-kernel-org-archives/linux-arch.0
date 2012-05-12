From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/4] xtensa: Setup CROSS_COMPILE at the top
Date: Sat, 12 May 2012 22:39:08 +0200
Message-ID: <1336855148-18817-4-git-send-email-geert@linux-m68k.org>
References: <1336855148-18817-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336855148-18817-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>
List-Id: linux-arch.vger.kernel.org

CROSS_COMPILE must be setup before using e.g. cc-option (and a few other
as-*, cc-*, ld-* macros), else they will check against the wrong compiler
when cross-compiling, and may invoke the cross compiler with wrong or
suboptimal compiler options.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Zankel <chris@zankel.net>
---
 arch/xtensa/Makefile |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 7608559..d41f9ed 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -21,6 +21,18 @@ variant-$(CONFIG_XTENSA_VARIANT_LINUX_CUSTOM)	:= custom
 VARIANT = $(variant-y)
 export VARIANT
 
+# Test for cross compiling
+
+ifneq ($(VARIANT),)
+  COMPILE_ARCH = $(shell uname -m)
+
+  ifneq ($(COMPILE_ARCH), xtensa)
+    ifndef CROSS_COMPILE
+      CROSS_COMPILE = xtensa_$(VARIANT)-
+    endif
+  endif
+endif
+
 # Platform configuration
 
 platform-$(CONFIG_XTENSA_PLATFORM_XT2000)	:= xt2000
@@ -54,18 +66,6 @@ KBUILD_DEFCONFIG := iss_defconfig
 
 core-$(CONFIG_EMBEDDED_RAMDISK)	+= arch/xtensa/boot/ramdisk/
 
-# Test for cross compiling
-
-ifneq ($(VARIANT),)
-  COMPILE_ARCH = $(shell uname -m)
-
-  ifneq ($(COMPILE_ARCH), xtensa)
-    ifndef CROSS_COMPILE
-      CROSS_COMPILE = xtensa_$(VARIANT)-
-    endif
-  endif
-endif
-
 # Only build variant and/or platform if it includes a Makefile
 
 buildvar := $(shell test -a $(srctree)/arch/xtensa/variants/$(VARIANT)/Makefile && echo arch/xtensa/variants/$(VARIANT)/)
-- 
1.7.0.4

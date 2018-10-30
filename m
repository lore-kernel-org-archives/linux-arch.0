Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:51973 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727593AbeJ3Uwp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Oct 2018 16:52:45 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 1/2] csky: remove builtin-dtb Kbuild
Date: Tue, 30 Oct 2018 19:59:26 +0800
Message-Id: <d7007cad85bb06e0f4e081bc4daf6f0f79c81861.1540900718.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: robh@kernel.org, arnd@arndb.de
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>

Remove the builtin-dtb implementation in arch/csky.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig.debug     | 10 +---------
 arch/csky/Makefile          |  2 --
 arch/csky/boot/dts/Makefile |  7 -------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/csky/Kconfig.debug b/arch/csky/Kconfig.debug
index 48cf6ff..22a162cd 100644
--- a/arch/csky/Kconfig.debug
+++ b/arch/csky/Kconfig.debug
@@ -1,9 +1 @@
-menu "C-SKY Debug Options"
-config CSKY_BUILTIN_DTB
-	string "Use kernel builtin dtb"
-	help
-	  User could define the dtb instead of the one which is passed from
-	  bootloader.
-	  Sometimes for debug, we want to use a built-in dtb and then we needn't
-	  modify bootloader at all.
-endmenu
+# dummy file, do not delete
diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 67a4ae1..91f7222 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -65,9 +65,7 @@ libs-y += arch/csky/lib/ \
 	$(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
 
 boot := arch/csky/boot
-ifneq '$(CONFIG_CSKY_BUILTIN_DTB)' '""'
 core-y += $(boot)/dts/
-endif
 
 all: zImage
 
diff --git a/arch/csky/boot/dts/Makefile b/arch/csky/boot/dts/Makefile
index 305e81a..19a7f02 100644
--- a/arch/csky/boot/dts/Makefile
+++ b/arch/csky/boot/dts/Makefile
@@ -1,13 +1,6 @@
 dtstree	:= $(srctree)/$(src)
 
-ifneq '$(CONFIG_CSKY_BUILTIN_DTB)' '""'
-builtindtb-y := $(patsubst "%",%,$(CONFIG_CSKY_BUILTIN_DTB))
-dtb-y += $(builtindtb-y).dtb
-obj-y += $(builtindtb-y).dtb.o
-.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
-else
 dtb-y := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-endif
 
 always += $(dtb-y)
 clean-files += *.dtb *.dtb.S
-- 
2.7.4
